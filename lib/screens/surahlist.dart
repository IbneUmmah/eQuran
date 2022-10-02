import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:isar/isar.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';
import 'package:quran/screens/eachsurahtext.dart';
import 'package:quran/screens/ayahbyayah.dart';
import 'package:flutter/material.dart';
import 'package:quran/commonutils.dart' show CurrentTime;
import 'package:quran/widgets/reuseablewidgets.dart';

final surahProvider = ChangeNotifierProvider.autoDispose
    .family<SurahController, bool>(
        (_, textSurah) => SurahController(textSurah));

class SurahController with ChangeNotifier {
  //Search Feature///

  TextEditingController textEditingController = TextEditingController();

  FocusNode focusNode = FocusNode();
  bool isSearching = false;
  Surah? lastReadSurah;
  Ayah? lastReadAyah;
  double lastReadPercentage = 0.0;

  updateSearch(bool _) {
    isSearching = _;

    notifyListeners();
  }

  void unfocusClear() {
    focusNode.unfocus();
    textEditingController.clear();
    searchByNameOrNumber('');
  }

  void startupServices() async {
    await generateChaptersList();
    focusNode.unfocus();
  }

  bool textSurah;
  SurahController(this.textSurah) {
    startupServices();
  }

  void chapterSelect({
    required BuildContext context,
    required Surah surah,
  }) async {
    FocusScope.of(context).unfocus();
    textEditingController.clear();
    searchByNameOrNumber('');
    if (textSurah) {
      Ayah? ayah = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (
            context,
          ) =>
              EachQuranText(
            chapterNo: surah.number,
          ),
        ),
      );
      updateLastReadValues(surah, ayah);

      // SP.gs.put('scrollText$chapterNo', currentPixels);
      // ref.refresh(lastProvider);
      //  Get.find<Last>().update();
    } else {
      Ayah? ayah = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AyahByAyahScreen(
            chapterNo: surah.number,
          ),
        ),
      );
      updateLastReadValues(surah, ayah);
      // SP.gs.put('scrollVerse$chapterNo',
      //     ref.read(verseByVerseProvider).currentPixels);
      // ref.refresh(lastProvider);
      //   Get.find<Last>().update();
      //Update current pixels as well;
    }
  }

  void bookmarkSurah(Surah surah) {
    surah.bookmarked = !(surah.bookmarked ?? false);
    UC.isar.writeTxnSync(() {
      UC.isar.surahs.putSync(surah);
    });
    notifyListeners();
  }

  List<Surah> totalChapters = <Surah>[];
  List<Surah> foundChapters = <Surah>[];

  int verseByVerse = 0;

  generateChaptersList() async {
    List<Surah> chapters = await compute(getAllSurahs, true);
    totalChapters = chapters;
    foundChapters = chapters;
    await generateLastReadValues();

    notifyListeners();
  }

  generateLastReadValues() async {
    if (textSurah) {
      lastReadSurah = UC.isar.surahs
          .filter()
          .not()
          .lastReadIsNull()
          .sortByLastReadDesc()
          .findFirstSync();
      lastReadAyah = UC.isar.ayahs
          .filter()
          .group((q) =>
              q.languageEqualTo(kArabicText).and().not().lastReadIsNull())
          .sortByLastReadDesc()
          .findFirstSync();

      if (lastReadAyah != null && lastReadSurah != null) {
        lastReadPercentage =
            (lastReadAyah!.numberInSurah / lastReadSurah!.numberOfAyahs);
      }
    } else {
      lastReadAyah = UC.isar.ayahs
          .filter()
          .group((q) =>
              q.not().lastReadIsNull()..and().languageEqualTo(kEnglishText))
          .sortByLastReadDesc()
          .findFirstSync();

      if (lastReadAyah != null) {
        lastReadSurah = UC.isar.surahs
            .filter()
            .numberEqualTo(lastReadAyah!.chapterNo)
            .findFirstSync();
        lastReadPercentage =
            (lastReadAyah!.numberInSurah / lastReadSurah!.numberOfAyahs);
      }
    }
  }

  updateLastReadValues(Surah? surah, Ayah? ayah) {
    lastReadSurah = surah;
    lastReadAyah = ayah;

    if (lastReadAyah != null && lastReadSurah != null) {
      lastReadPercentage =
          (lastReadAyah!.numberInSurah / lastReadSurah!.numberOfAyahs);
    }

    notifyListeners();
  }

  searchByNameOrNumber(String str) {
    if (str.isEmpty) {
      foundChapters = totalChapters;
      notifyListeners();
    }
    int value = int.tryParse(str) ?? 0;
    if (value != 0 && value < 115) {
      List<Surah> current = [];
      for (int i = 0; i < totalChapters.length; i++) {
        final toMatch = RegExp('$value');
        if (toMatch.hasMatch(totalChapters[i].number.toString())) {
          current.add(totalChapters[i]);
        }
      }

      foundChapters = current;
      notifyListeners();
    } else {
      List<Surah> current = [];
      for (int i = 0; i < totalChapters.length; i++) {
        String lower = str.toLowerCase();

        final toMatch = RegExp(lower);
        if (toMatch.hasMatch(totalChapters[i].englishName.toLowerCase())) {
          current.add(totalChapters[i]);
        }
      }

      foundChapters = current;
      notifyListeners();
    }
  }
}

class QuranFull extends ConsumerWidget {
  static const id = 'QuranFull';
  //ScrollController controller = ScrollController();
  final bool textSurah;
  const QuranFull({Key? key, this.textSurah = true}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sP = ref.watch(surahProvider(textSurah));
    return WillPopScope(
      onWillPop: () async {
        sP.isSearching ? sP.updateSearch(false) : null;
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Theme.of(context).canvasColor,
            appBar: AppBar(
                backgroundColor: Theme.of(context).canvasColor,
                title: sP.isSearching
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(top: 3.0),
                        height: 45.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              child: CupertinoSearchTextField(
                                autofocus: true,
                                focusNode: sP.focusNode,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.0,
                                ),
                                //keyboardType: TextInputType.text,
                                controller: sP.textEditingController,
                                onChanged: (String str) {
                                  sP.searchByNameOrNumber(str);
                                },
                                onSubmitted: (String str) {
                                  sP.searchByNameOrNumber(str);
                                },
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
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
                                sP.updateSearch(true);

                                //FocusScope.of(context).requestFocus(sP.focusNode);
                              },
                              child: const Icon(
                                CupertinoIcons.search,
                                size: 20.0,
                              ),
                            ),
                          ])),
            body: SingleChildScrollView(
              //physics: ScrollPhysics(),
              //physics: NeverScrollableScrollPhysics(),

              child: Scrollbar(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(
                              kBeautifulBackgrounds[Random()
                                  .nextInt(kBeautifulBackgrounds.length)]),
                        ),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: GlassMorphism(
                            start: 0.1,
                            end: 0.2,
                            color: Colors.green,
                            child: Container(
                              margin: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    sP.lastReadSurah != null &&
                                            sP.lastReadAyah != null
                                        ? 'Last Read ${sP.lastReadAyah!.lastRead!.currentTime}'
                                        : 'Last Read',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  Column(
                                    children: [
                                      AutoSizeText(
                                        sP.lastReadSurah != null
                                            ? '﴾${sP.lastReadSurah!.name}﴿'
                                            : 'Select any Surah to start reading',
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      AutoSizeText(
                                        sP.lastReadSurah != null
                                            ? '${sP.lastReadSurah!.number} ${sP.lastReadSurah?.englishNameTranslation}'
                                            : '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                      LinearProgressIndicator(
                                        value: sP.lastReadPercentage,
                                        color: Colors.green,
                                        backgroundColor: Colors.white,
                                      ),
                                      AutoSizeText(
                                        sP.lastReadAyah != null
                                            ? "You've read ${sP.lastReadAyah!.numberInSurah} of ${sP.lastReadSurah!.numberOfAyahs} Ayahs so far"
                                            : '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    AnimationLimiter(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: sP.foundChapters.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          //physics: ScrollPhysics(),

                          if (sP.foundChapters.isEmpty == false) {
                            return AnimationConfiguration.staggeredGrid(
                              columnCount: sP.foundChapters.length,
                              position: index,
                              duration: const Duration(milliseconds: 475),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: EachTextSurahWidget(
                                    chapterNo: sP.foundChapters[index].number
                                        .toString(),
                                    chapterNameEn:
                                        sP.foundChapters[index].englishName,
                                    chapterNameAr: sP.foundChapters[index].name,
                                    chapterNametranslation: sP
                                        .foundChapters[index]
                                        .englishNameTranslation,
                                    chapterType:
                                        sP.foundChapters[index].revelationType,
                                    chapterAyats: sP
                                        .foundChapters[index].numberOfAyahs
                                        .toString(),
                                    isFavourite:
                                        sP.foundChapters[index].bookmarked ??
                                            false,
                                    tap: () async {
                                      sP.chapterSelect(
                                        context: context,
                                        surah: sP.foundChapters[index],
                                      );
                                    },
                                    likeButton: () {
                                      sP.bookmarkSurah(sP.foundChapters[index]);
                                    },
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox(
                              width: 2000.0,
                              height: 100.0,
                              child: Text(
                                'Loading',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
