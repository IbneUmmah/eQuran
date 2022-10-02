import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:quran/assets/quranformat.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/fastfunctions.dart';

import 'package:quran/main.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:quran/widgets/reuseablewidgets.dart';

final textTranslationProvider =
    ChangeNotifierProvider((_) => TextTranslationController());

class TextTranslationController with ChangeNotifier {
  //Search Feature///

  TextTranslationController() {
    generateTextTranslations();
  }

  TextEditingController textEditingController = TextEditingController();

  FocusNode focusNode = FocusNode();
  bool isSearching = false;
  String currentDownloading = '';

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

  List<TextTranslation> totalTextTranslations = [];
  List<TextTranslation> foundTextTranslations = [];

  generateTextTranslations() {
    List<TextTranslation> textTranslations =
        UC.isar.textTranslations.where().sortByLanguage().findAllSync();
    totalTextTranslations = textTranslations;
    foundTextTranslations = textTranslations;
  }

  updateBookmark(TextTranslation textTranslation) {
    textTranslation.bookmarked = !(textTranslation.bookmarked);
    UC.isar.writeTxn(() {
      return UC.isar.textTranslations.put(textTranslation);
    });
    notifyListeners();
  }

  Future<bool> downloadTranslation(
      TextTranslation textTranslation, BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Downloading.... It Will take few seconds and only 2mb only the first time'),
        ),
      );
      bool downloaded =
          await compute(downloadAyahTranslation, textTranslation.identifier);
      if (downloaded == false) return false;

      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Something went wrong.\nYou must have internet connection. It will use only 2mb.'),
          backgroundColor: Colors.red.withOpacity(0.5),
        ),
      );
      return false;
    }
  }

  updateSelected(TextTranslation textTranslation, BuildContext context) async {
    if (textTranslation.isDownloaded == false) {
      currentDownloading = textTranslation.identifier;
      notifyListeners();
      bool downloaded = await downloadTranslation(textTranslation, context);
      if (downloaded == false) return false;
      textTranslation.isDownloaded = true;
    }

    TextTranslation? alreadySelectedTranslation;

    for (TextTranslation tTranslation in totalTextTranslations) {
      if (tTranslation.isSelected) {
        alreadySelectedTranslation = tTranslation;
        alreadySelectedTranslation.isSelected = false;
      }
    }

    textTranslation.isSelected = true;
    UC.isar.writeTxn(() {
      return UC.isar.textTranslations
          .putAll([textTranslation, alreadySelectedTranslation!]);
    });
    currentDownloading = '';
    notifyListeners();
  }

  searchByNameOrNumber(String str) {
    if (str.isEmpty) {
      foundTextTranslations = totalTextTranslations;
      notifyListeners();
      return;
    }
    int value = int.tryParse(str) ?? 0;
    if (value != 0 && value <= 134) {
      List<TextTranslation> current = [totalTextTranslations[value]];

      foundTextTranslations = current;
      notifyListeners();
      return;
    } else {
      List<TextTranslation> current = [];
      for (int i = 0; i < totalTextTranslations.length; i++) {
        String lower = str.toLowerCase();

        final toMatch = RegExp(lower);
        if (toMatch.hasMatch(totalTextTranslations[i].name.toLowerCase()) ||
            toMatch
                .hasMatch(totalTextTranslations[i].englishName.toLowerCase()) ||
            toMatch.hasMatch(totalTextTranslations[i].language.toLowerCase()) ||
            toMatch.hasMatch(languageCodes[totalTextTranslations[i].language]!
                .toLowerCase())) {
          current.add(totalTextTranslations[i]);
        }
      }

      foundTextTranslations = current;
      notifyListeners();
    }
  }
}

class AyahTranslationsScreen extends ConsumerWidget {
  static const id = 'verseTranslationsScreen';
  AyahTranslationsScreen({Key? key}) : super(key: key);
  String image =
      kBeautifulBackgrounds[Random().nextInt(kBeautifulBackgrounds.length)];
  ScrollController scroll = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    final tP = ref.watch(textTranslationProvider);

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
                                    '${tP.totalTextTranslations.length} Ayah Translations Available',
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
                        itemCount: tP.foundTextTranslations.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: tP.foundTextTranslations.length,
                            position: index,
                            duration: const Duration(milliseconds: 100),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: EachTextTranslationWidget(
                                  translationNo: (index + 1).toString(),
                                  translationNameEn: languageCodes[tP
                                      .foundTextTranslations[index].language]!,
                                  translationNameL: tP
                                      .foundTextTranslations[index].englishName,
                                  type: tP.foundTextTranslations[index].type
                                      .toUpperCase(),
                                  isDownloading: tP.foundTextTranslations[index]
                                          .identifier ==
                                      tP.currentDownloading,
                                  isSelected: tP
                                      .foundTextTranslations[index].isSelected,
                                  isBookmarked: tP
                                      .foundTextTranslations[index].bookmarked,
                                  bookmarkTap: () {
                                    tP.updateBookmark(
                                        tP.foundTextTranslations[index]);
                                  },
                                  selectedTap: () {
                                    tP.updateSelected(
                                        tP.foundTextTranslations[index],
                                        context);
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
