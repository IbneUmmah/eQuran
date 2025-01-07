import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';
import 'package:quran/reciters/qurantranslations.dart';
import 'package:quran/widgets/reuseablewidgets.dart';

final audioTranslationProvider =
    ChangeNotifierProvider.autoDispose((_) => AudioTranslationController());

class AudioTranslationController with ChangeNotifier {
  //Search Feature///

  String selectedAudioTranslation =
      UC.hive.get(kSelectedAudioTranslation) ?? 'English';

  AudioTranslationController();

  TextEditingController textEditingController = TextEditingController();

  FocusNode focusNode = FocusNode();
  bool isSearching = false;

  updateSearch(bool _) {
    isSearching = _;

    notifyListeners();
  }

  void unfocusClear() {
    focusNode.unfocus();
    updateSearch(false);
    textEditingController.clear();
    searchByNameOrNumber('');
  }

  List<AudioSurahTranslation> totalTranslations =
      AudioSurahTranslation.quranTranslations;
  List<AudioSurahTranslation> foundTranslations =
      AudioSurahTranslation.quranTranslations;

  updateSelected(AudioSurahTranslation audioTranslation) {
    UC.hive.put(kSelectedAudioTranslation, audioTranslation.name);
    selectedAudioTranslation = audioTranslation.name;
    UC.uv.updateSelectedAudioTranslation(audioTranslation.name);
    notifyListeners();
    compute(resetSurahsDurations, true);
  }

  searchByNameOrNumber(String str) {
    if (str.isEmpty) {
      foundTranslations = totalTranslations;
      notifyListeners();
      return;
    }
    int value = int.tryParse(str) ?? 0;
    if (value != 0 && value <= 134) {
      List<AudioSurahTranslation> current = [totalTranslations[value]];

      foundTranslations = current;
      notifyListeners();
      return;
    } else {
      List<AudioSurahTranslation> current = [];
      for (int i = 0; i < totalTranslations.length; i++) {
        String lower = str.toLowerCase();

        final toMatch = RegExp(lower);
        if (toMatch.hasMatch(totalTranslations[i].name.toLowerCase()) ||
            toMatch.hasMatch(totalTranslations[i].nativeName.toLowerCase())) {
          current.add(totalTranslations[i]);
        }
      }

      foundTranslations = current;
      notifyListeners();
    }
  }
}

class AudioTranslationsScreen extends ConsumerWidget {
  static const id = 'audioTranslationsScreen';
  //Controller gController = Get.find();

  AudioTranslationsScreen({Key? key}) : super(key: key);
  final String image =
      kBeautifulBackgrounds[Random().nextInt(kBeautifulBackgrounds.length)];
  ScrollController scroll = ScrollController();
  @override
  Widget build(BuildContext context, ref) {
    final tP = ref.watch(audioTranslationProvider);

    return WillPopScope(
      onWillPop: () async {
        tP.unfocusClear();
        scroll.dispose();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
              //automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).canvasColor,
              title: tP.isSearching
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          80.0,
                        ),
                      ),
                      child: CupertinoTextField(
                        autofocus: true,
                        focusNode: tP.focusNode,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        keyboardType: TextInputType.text,
                        controller: tP.textEditingController,
                        onChanged: (String str) {
                          tP.searchByNameOrNumber(str);
                        },
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                          const Text(
                            'Search Translations',
                          ),
                          InkWell(
                            onTap: () {
                              tP.updateSearch(true);

                              //FocusScope.of(context).requestFocus(sP.focusNode);
                            },
                            child: const Icon(
                              CupertinoIcons.search,
                              size: 20.0,
                            ),
                          ),
                        ])),
          body: SingleChildScrollView(
            controller: scroll,
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
                      image: CachedNetworkImageProvider(image),
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
                              Column(
                                children: [
                                  AutoSizeText(
                                    '${tP.totalTranslations.length} Audio Translations Available',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimationLimiter(
                    child: ListView.builder(
                        itemCount: tP.foundTranslations.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: tP.foundTranslations.length,
                            position: index,
                            duration: const Duration(milliseconds: 475),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: AudioTranslationWidget(
                                  translationNo: (index + 1).toString(),
                                  translationNameEn:
                                      tP.foundTranslations[index].name,
                                  translationNameL:
                                      tP.foundTranslations[index].nativeName,
                                  isSelected:
                                      tP.foundTranslations[index].name ==
                                          tP.selectedAudioTranslation,
                                  selectedTap: () {
                                    tP.updateSelected(
                                        tP.foundTranslations[index]);
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
