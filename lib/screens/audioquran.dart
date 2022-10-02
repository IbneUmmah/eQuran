import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/audiostate.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';
import 'package:quran/widgets/reuseablewidgets.dart';

final audioQuranProvider =
    ChangeNotifierProvider((_) => AudioQuranController());

class AudioQuranController with ChangeNotifier {
  List<Surah> totalSurahs = <Surah>[];
  List<Surah> foundSurahs = <Surah>[];

  Reciter selectedReciter = UC.uv.selectedReciter;
  String selectedTranslation = UC.uv.selectedAudioTranslation;
  AudioType currentAudioType = UC.uv.selectedAudioType;

  int currentReciting = UC.hive.get('lastRecited') ?? 0;
  bool buffering = false;
  bool pause = false;
  generateChaptersList() async {
    List<Surah> chapters = await compute(getAllSurahs, true);
    totalSurahs = chapters;
    foundSurahs = chapters;
    //await generateLastReadValues();

    notifyListeners();
  }

  searchByNameOrNumber(String str) {
    if (str.isEmpty) {
      foundSurahs = totalSurahs;
      notifyListeners();
    }
    int value = int.tryParse(str) ?? 0;
    if (value != 0 && value < 115) {
      List<Surah> current = [];
      for (int i = 0; i < totalSurahs.length; i++) {
        final toMatch = RegExp('$value');
        if (toMatch.hasMatch(totalSurahs[i].number.toString())) {
          current.add(totalSurahs[i]);
        }
      }

      foundSurahs = current;
      notifyListeners();
    } else {
      List<Surah> current = [];
      for (int i = 0; i < totalSurahs.length; i++) {
        String lower = str.toLowerCase();

        final toMatch = RegExp(lower);
        if (toMatch.hasMatch(totalSurahs[i].englishName.toLowerCase())) {
          current.add(totalSurahs[i]);
        }
      }

      foundSurahs = current;
      notifyListeners();
    }
  }

  //int(SP.gs.get('currentReciting') ?? 0);

  reciteThisSurah(Surah surah, {required WidgetRef ref}) {
    Reciter selectedReciter = UC.uv.selectedReciter;
    String selectedTranslation = UC.uv.selectedAudioTranslation;

    String? album;
    String reciterName = selectedReciter.name;

    String translationServer = selectedTranslation;
    String reciterUrl =
        'https://server${selectedReciter.serverNo}.mp3quran.net/${selectedReciter.identifier}/chapter.mp3';
    String translationUrl =
        'http://www.truemuslims.net/download.php?path=Quran/$translationServer/chapter.mp3';
    late String url;
    if (currentAudioType == AudioType.arabic) {
      url = reciterUrl;
      album = reciterName;
    } else {
      url = translationUrl;
      album = translationServer;
    }

    List<AudioSource> chapters = [];
    for (int i = 0; i < totalSurahs.length; i++) {
      int finalIndex = i + 1;
      String newIndex;

      if (finalIndex < 10) {
        newIndex = '00$finalIndex';
      } else if (finalIndex < 100 && finalIndex >= 10) {
        newIndex = '0$finalIndex';
      } else {
        newIndex = '$finalIndex';
      }

      chapters.add(LockCachingAudioSource(
        Uri.parse(url.replaceAll('chapter', newIndex)),
        cacheFile: File('${UC.uv.appDirectoryPath}/$album/$newIndex'),
        tag: MediaItem(
            // Specify a unique ID for each media item:
            id: '$i',
            // Metadata to display in the notification:
            album: album,
            title: totalSurahs[i].englishName,
            artist: album,
            extras: totalSurahs[i].toJson()
            // extras: {
            //   'chapterOrVerse': 'chapter',
            //   'chapterNo': totalSurahs[i].number,
            //   'chapterName': totalSurahs[i].name,
            //   'chapterEnglishName': totalSurahs[i].englishName,
            //   'chapterEnglishNameTranslation':
            //       totalSurahs[i].englishNameTranslation,
            //   'chapterNumberOfAyahs': totalSurahs[i].numberOfAyahs,
            //   'chapterRevelationType': totalSurahs[i].revelationType.toString(),
            //   'albumName': album,
            // }
            //artUri: Uri.parse('https://example.com/albumart.jpg'),
            ),
      ));
    }

    ref.read(audioStateProvider).reciteSurah(chapters, surah, album);
  }

  updateCurrentAudioType(AudioType newAudioType) {
    currentAudioType = newAudioType;
    UC.uv.updateSelectedAudioType(newAudioType);

    notifyListeners();
    compute(resetSurahsDurations, true);
  }

  //Search Feature///

  bool isSearching = false;

  updateSearch(bool _) {
    isSearching = _;

    notifyListeners();
  }

  void unfocusClear() {
    searchByNameOrNumber('');
  }

  AudioQuranController() {
    generateChaptersList();
  }
}

class QuranAudio extends ConsumerWidget {
  static const String id = 'QuranAudio';

  QuranAudio({Key? key}) : super(key: key);
  TextEditingController textEditingController = TextEditingController();

  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context, ref) {
    final audioProvider = ref.watch(audioQuranProvider);
    final aSP = ref.watch(audioStateProvider);
    return WillPopScope(
      onWillPop: () async {
        focusNode.unfocus();
        audioProvider.unfocusClear();
        textEditingController.clear();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
              //automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).canvasColor,
              title: audioProvider.isSearching
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          80.0,
                        ),
                      ),
                      child: CupertinoTextField(
                        autofocus: true,
                        focusNode: focusNode,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        keyboardType: TextInputType.text,
                        controller: textEditingController,
                        onChanged: (String str) {
                          audioProvider.searchByNameOrNumber(str);
                        },
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          const Text(
                            'Search Surahs',
                          ),
                          InkWell(
                            onTap: () {
                              audioProvider.updateSearch(true);

                              //FocusScope.of(context).requestFocus(sP.focusNode);
                            },
                            child: const Icon(
                              CupertinoIcons.search,
                              size: 20.0,
                            ),
                          ),
                        ])),
          body: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 100,
                height: 35.0,
                margin: const EdgeInsets.only(
                  top: 3.0,
                  bottom: 3.0,
                ),
                child: CupertinoSegmentedControl<AudioType>(
                  groupValue: audioProvider.currentAudioType,
                  borderColor: Theme.of(context).primaryColor.withOpacity(0.4),
                  selectedColor: Theme.of(context).primaryColor,
                  children: const {
                    AudioType.arabic: Text('Arabic'),
                    AudioType.translation: Text('Translation')
                  },
                  onValueChanged: (AudioType audioType) async {
                    //Stop Player

                    audioProvider.updateCurrentAudioType(audioType);
                    ref.read(audioStateProvider).player.stop();
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Scrollbar(
                    radius: const Radius.circular(
                      10.0,
                    ),
                    thickness: 15.0,
                    //thumbColor: Theme.of(context).primaryColor,
                    interactive: true,
                    //    hoverThickness: 15.0,
                    //  showTrackOnHover: true,
                    child: AnimationLimiter(
                      child: ListView.builder(
                          itemCount: audioProvider.foundSurahs.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: audioProvider.foundSurahs.length,
                              position: index,
                              duration: const Duration(milliseconds: 475),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: EachAudioSurahWidget(
                                    chapterNo: audioProvider
                                        .foundSurahs[index].number
                                        .toString(),
                                    chapterNameEn: audioProvider
                                        .foundSurahs[index].englishName,
                                    chapterNameAr:
                                        audioProvider.foundSurahs[index].name,
                                    chapterType: audioProvider
                                        .foundSurahs[index].revelationType,
                                    chapterAyats: audioProvider
                                        .foundSurahs[index].numberOfAyahs
                                        .toString(),
                                    isFavourite: audioProvider
                                        .foundSurahs[index].bookmarked,
                                    isRepeat: false,
                                    isReciting: audioProvider
                                            .foundSurahs[index].number ==
                                        aSP.currentRecitingSurah?.number,
                                    playTap: () {
                                      //print('reciting');
                                      audioProvider.reciteThisSurah(
                                          audioProvider.foundSurahs[index],
                                          ref: ref);
                                      // AudioPlayer player =
                                      //     QuranAudioController.player;
                                      // player.seek(Duration.zero,
                                      //     index: int.parse(chapterNo) - 1);
                                      // //c.reciteThis(int.parse(chapterNo) - 1);
                                      // if (!player.playing) {
                                      //   player.play();
                                      // }
                                    },
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: OpenContainer(
            closedBuilder: (context, action) => PlayerClose(),
            closedElevation: 20.0,
            closedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            )),
            //transitionDuration: const Duration(seconds: 1),
            openBuilder: (context, action) => PlayerOpen(),
            //    transitionType: ContainerTransitionType.fadeThrough,
          ),
        ),
      ),
    );
  }
}
