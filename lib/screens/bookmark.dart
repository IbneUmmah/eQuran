// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/assets/quranformat.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/audiostate.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';
import 'package:quran/screens/eachsurahtext.dart';
import 'package:quran/screens/statusmaker.dart';
import 'package:quran/screens/ayahbyayah.dart';
import 'package:flutter/material.dart';
import 'package:quran/widgets/customanimations.dart';
import 'package:quran/widgets/reuseablewidgets.dart';

final bookmarkProvider =
    ChangeNotifierProvider.autoDispose((_) => BookmarkController());

class BookmarkController with ChangeNotifier {
  //Search Feature///

  List<Surah> surahs = [];
  List<Ayah> arabicAyahs = [];
  List<Ayah> translationAyahs = [];
  List<Reciter> reciters = [];
  List<TextTranslation> textTranslations = [];
  initialize() async {
    surahs = await compute(getBookmarkedSurahs, true);
    reciters = await compute(getBookmarkedReciters, true);
    textTranslations = await compute(getBookmarkedTextTranslations, true);

    List<List<Ayah>> response = await compute(getBookmarkedAyahs, true);
    arabicAyahs = response[0];

    translationAyahs = response[1];
    currentItemCount = arabicAyahs.length;
    notifyListeners();
  }

  BookmarkController() {
    initialize();
  }

  updateBookmarkReciter(Reciter reciter) {
    reciters.remove(reciter);
    currentItemCount = currentItemCount - 1;
    notifyListeners();
    reciter.bookmarked = !(reciter.bookmarked);
    UC.isar.writeTxn(() {
      return UC.isar.reciters.put(reciter);
    });
  }

  updateSelectedReciter(Reciter reciter) {
    Reciter? alreadySelectedReciter;

    for (Reciter reciter in reciters) {
      if (reciter.isSelected) {
        alreadySelectedReciter = reciter;
        alreadySelectedReciter.isSelected = false;
      }
    }

    reciter.isSelected = true;
    UC.uv.updateSelectedReciter(reciter);
    UC.isar.writeTxn(() {
      return UC.isar.reciters.putAll([reciter, alreadySelectedReciter!]);
    });
    notifyListeners();
    compute(resetSurahsDurations, true);
  }

  updateBookmarkTranslation(TextTranslation textTranslation) {
    textTranslations.remove(textTranslation);
    currentItemCount = currentItemCount - 1;
    notifyListeners();
    textTranslation.bookmarked = !(textTranslation.bookmarked);
    UC.isar.writeTxn(() {
      return UC.isar.textTranslations.put(textTranslation);
    });
  }

  Future<bool> downloadTextTranslation(
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

  String currentDownloading = '';
  updateSelectedTextTranslation(
      TextTranslation textTranslation, BuildContext context) async {
    if (textTranslation.isDownloaded == false) {
      currentDownloading = textTranslation.identifier;
      notifyListeners();
      bool downloaded = await downloadTextTranslation(textTranslation, context);
      if (downloaded == false) return false;
      textTranslation.isDownloaded = true;
    }

    TextTranslation? alreadySelectedTranslation;

    for (TextTranslation tTranslation in textTranslations) {
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

  bool textSurah = true;
  void chapterSelect({
    required BuildContext context,
    required Surah surah,
  }) async {
    FocusScope.of(context).unfocus();

    if (textSurah) {
      await Navigator.push(
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
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AyahByAyahScreen(
            chapterNo: surah.number,
          ),
        ),
      );

      // SP.gs.put('scrollVerse$chapterNo',
      //     ref.read(verseByVerseProvider).currentPixels);
      // ref.refresh(lastProvider);
      //   Get.find<Last>().update();
      //Update current pixels as well;
    }
  }

  void updateBookmarkSurah(Surah surah) {
    surahs.remove(surah);
    currentItemCount = currentItemCount - 1;
    notifyListeners();
    surah.bookmarked = !(surah.bookmarked ?? false);
    UC.isar.writeTxnSync(() {
      UC.isar.surahs.putSync(surah);
    });
  }

  void updateBookmarkAyah(
      {required Ayah arabicAyah, required Ayah translationAyah}) {
    arabicAyahs.remove(arabicAyah);
    translationAyahs.remove(translationAyah);
    currentItemCount = currentItemCount - 1;
    notifyListeners();
    translationAyah.bookmarked = !(translationAyah.bookmarked ?? false);
    UC.isar.writeTxnSync(() {
      UC.isar.ayahs.putSync(translationAyah);
    });
  }

  int currentRecitingAyah = 0;
  reciteAyah(
      {required BuildContext context,
      required WidgetRef ref,
      required Ayah ayah}) async {
    currentRecitingAyah = ayah.number;
    notifyListeners();
    final snackBar = SnackBar(
      content: AyahRecitingWidget(
        text: ayah.text,
        textDirection:
            ayah.direction == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
      ),
      duration: const Duration(minutes: 1),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    Duration? duration =
        await ref.read(audioStateProvider).reciteAyah(ayah: ayah);
    if (duration != null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      final snackBar = SnackBar(
        content: AyahRecitingWidget(
          duration: duration,
          text: ayah.text,
          textDirection:
              ayah.direction == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
        ),
        duration: duration,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
    }
  }

  int currentBookmarkIndex = 0;
  String currentBookmarksShowing = "Ayah";
  updateBookmarkIndex(int value) {
    currentBookmarkIndex = value;
    switch (currentBookmarkIndex) {
      case 0:
        currentBookmarksShowing = "Ayahs";
        currentItemCount = arabicAyahs.length;
        break;
      case 1:
        currentBookmarksShowing = "Surahs";
        currentItemCount = surahs.length;
        break;
      case 2:
        currentBookmarksShowing = "Reciters";
        currentItemCount = reciters.length;
        break;
      case 3:
        currentBookmarksShowing = "Ayah Translations";
        currentItemCount = textTranslations.length;
        break;
      default:
        return 0;
    }
    notifyListeners();
  }

  int currentItemCount = 0;
}

class BookmarkScreen extends ConsumerWidget {
  static const id = 'bookmarkScreen';

  BookmarkScreen({Key? key}) : super(key: key);

  String image =
      kBeautifulBackgrounds[Random().nextInt(kBeautifulBackgrounds.length)];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bMP = ref.watch(bookmarkProvider);
    return WillPopScope(
      onWillPop: () async {
        //sP.isSearching ? sP.updateSearch(false) : null;
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).canvasColor,
            title: const Text(
              'Bookmarks',
            ),
          ),
          // floatingActionButton: Container(
          //   color: Colors.red,
          //   child: InkWell(
          //       onTap: () async {
          //         double oldPosition = upScrollController.position.pixels;
          //         double addPosition =
          //             upScrollController.position.maxScrollExtent / 10;
          //         double newPosition = oldPosition + addPosition;
          //         upScrollController.jumpTo(newPosition);
          //         downScrollController.jumpTo(newPosition);
          //       },
          //       child: Icon(Icons.add, size: 40)),
          // ),
          body: Column(
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
                            AutoSizeText(
                              '${bMP.currentItemCount} ${bMP.currentBookmarksShowing} found',
                              maxLines: 1,
                              maxFontSize: 30,
                              minFontSize: 10,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 40.0,
                padding: const EdgeInsets.only(
                  top: 3.0,
                  bottom: 3.0,
                ),
                child: CupertinoSegmentedControl<int>(
                  groupValue: bMP.currentBookmarkIndex,
                  borderColor: Theme.of(context).primaryColor.withOpacity(0.4),
                  selectedColor: Theme.of(context).primaryColor,
                  children: const {
                    0: Text('Ayahs'),
                    1: Text('Surahs'),
                    2: Text('Reciters'),
                    3: Text('Translations')
                  },
                  onValueChanged: (int value) async {
                    //Stop Player

                    bMP.updateBookmarkIndex(value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  //physics: NeverScrollableScrollPhysics(),
                  itemCount: bMP.currentItemCount,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    //physics: ScrollPhysics(),

                    if (bMP.currentBookmarkIndex == 0) {
                      return EachAyahWidget(
                          no: bMP.arabicAyahs[index].numberInSurah,
                          chapterNo: bMP.arabicAyahs[index].chapterNo,
                          arabic: bMP.arabicAyahs[index].text,
                          sajda: bMP.arabicAyahs[index].sajda ?? '',
                          translation: bMP.translationAyahs[index].text,
                          textDirectionString: bMP.arabicAyahs[index].direction,
                          textDirection:
                              bMP.translationAyahs[index].direction == "ltr"
                                  ? TextDirection.ltr
                                  : TextDirection.rtl,
                          isReciting: bMP.translationAyahs[index].number ==
                              bMP.currentRecitingAyah,
                          audio: () {
                            bMP.reciteAyah(
                                context: context,
                                ref: ref,
                                ayah: bMP.translationAyahs[index]);
                          },
                          copyText: () {
                            Clipboard.setData(ClipboardData(
                                text:
                                    '${bMP.arabicAyahs[index].text}﴿${arabicNumeric(bMP.arabicAyahs[index].numberInSurah)}﴾\n${bMP.translationAyahs[index].text}'));
                          },
                          share: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return StatusMaker(
                                    ayahNumber:
                                        bMP.translationAyahs[index].number);
                              },
                            ));
                          },
                          bookmark: () {
                            bMP.updateBookmarkAyah(
                                arabicAyah: bMP.arabicAyahs[index],
                                translationAyah: bMP.translationAyahs[index]);
                          },
                          bookmarked: true);
                    } else if (bMP.currentBookmarkIndex == 1) {
                      return EachTextSurahWidget(
                          chapterNo: bMP.surahs[index].number.toString(),
                          chapterNameEn: bMP.surahs[index].englishName,
                          chapterNameAr: bMP.surahs[index].name,
                          chapterNametranslation:
                              bMP.surahs[index].englishNameTranslation,
                          chapterType: bMP.surahs[index].revelationType,
                          chapterAyats:
                              bMP.surahs[index].numberOfAyahs.toString(),
                          isFavourite: true,
                          tap: () {
                            bMP.chapterSelect(
                                context: context, surah: bMP.surahs[index]);
                          },
                          likeButton: () {
                            bMP.updateBookmarkSurah(bMP.surahs[index]);
                          });
                    } else if (bMP.currentBookmarkIndex == 2) {
                      return EachReciterWidget(
                          reciterNo: index + 1,
                          reciterName: bMP.reciters[index].name,
                          isBookmarked: true,
                          bookmarkTap: () {
                            bMP.updateBookmarkReciter(bMP.reciters[index]);
                          },
                          isSelected: bMP.reciters[index].isSelected,
                          selected: () {
                            bMP.updateSelectedReciter(bMP.reciters[index]);
                          },
                          server: '');
                    } else if (bMP.currentBookmarkIndex == 3) {
                      return EachTextTranslationWidget(
                        translationNo: (index + 1).toString(),
                        translationNameEn: languageCodes[
                            bMP.textTranslations[index].language]!,
                        translationNameL:
                            bMP.textTranslations[index].englishName,
                        type: bMP.textTranslations[index].type,
                        isSelected: bMP.textTranslations[index].isSelected,
                        selectedTap: () {
                          bMP.updateSelectedTextTranslation(
                              bMP.textTranslations[index], context);
                        },
                        isBookmarked: true,
                        bookmarkTap: () {
                          bMP.updateBookmarkTranslation(
                              bMP.textTranslations[index]);
                        },
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
