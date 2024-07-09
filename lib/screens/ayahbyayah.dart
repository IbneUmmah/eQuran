// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/audiostate.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';
import 'package:quran/screens/statusmaker.dart';
import 'package:quran/widgets/customanimations.dart';

import 'package:quran/widgets/reuseablewidgets.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter/material.dart';

final ayahByAyahProvider = ChangeNotifierProvider.autoDispose
    .family<AyahbyAyahController, int>(
        (_, chapterNo) => AyahbyAyahController(chapterNo));

class AyahbyAyahController with ChangeNotifier {
  List<Ayah> surahText = [];
  List<GlobalKey> textLocation = [];
  List<Ayah> surahTranslationText = [];
  Ayah? lastVisibleAyah;
  Ayah? previouslyReadAyah;

  void bookmarkAyah(Ayah ayah) {
    ayah.bookmarked = !(ayah.bookmarked ?? false);
    UC.isar.writeTxnSync(() {
      UC.isar.ayahs.putSync(ayah);
    });
    notifyListeners();
  }

  updateLastVisibleAyah(Ayah ayah) {
    lastVisibleAyah = ayah;
  }

  Surah? surah;

  generateChaptersText(int surahNo) async {
    surah = await UC.isar.surahs.filter().numberEqualTo(surahNo).findFirst();

    List<List<Ayah>> response =
        await compute(getTextAndTranslationAyahsBySurahNo, surahNo);
    surahText = response[0];
    surahTranslationText = response[1]; //

    textLocation = List.generate(surahText.length, (i) => GlobalKey());
    notifyListeners();
    for (Ayah ayah in surahTranslationText) {
      if (ayah.lastRead != null) {
        previouslyReadAyah = ayah;
      }
    }
  }

  Future<Ayah?> removePreviouslyReadAyah(int chapterNo) async {
    List<Ayah> previouslyReadAyahs = await UC.isar.ayahs
        .filter()
        .chapterNoEqualTo(chapterNo)
        .and()
        .languageEqualTo(kEnglishText)
        .and()
        .not()
        .lastReadIsNull()
        .sortByLastRead()
        .findAll();
    previouslyReadAyah =
        previouslyReadAyahs.isNotEmpty ? previouslyReadAyahs.last : null;

    for (Ayah element in previouslyReadAyahs) {
      element.lastRead = null;
    }
    if (previouslyReadAyahs.isNotEmpty) {
      UC.isar.writeTxn(() {
        return UC.isar.ayahs.putAll(previouslyReadAyahs);
      });
    }

    return previouslyReadAyah;
  }

  gotoChapter(int chapterNo) {
    generateChaptersText(chapterNo);
  }

  final int currentAyahChapter;
  AyahbyAyahController(this.currentAyahChapter) {
    //generateChaptersText(currentAyahChapter);
  }
  goToLastReadAyah() {
    previouslyReadAyah != null
        ? Scrollable.ensureVisible(
            textLocation[previouslyReadAyah!.numberInSurah - 1].currentContext!)
        : null;
  }

  persistLastVisibleAyah() {
    removePreviouslyReadAyah(surah!.number);
    if (lastVisibleAyah != null) {
      lastVisibleAyah?.lastRead = DateTime.now().millisecondsSinceEpoch;
      UC.isar.writeTxn(() {
        return UC.isar.ayahs.put(lastVisibleAyah!);
      });
    }
  }

  showLastReadSnackBar(BuildContext context) async {
    await generateChaptersText(currentAyahChapter);
    snackBarShowed = true;
    await Future.delayed(const Duration(seconds: 1));

    if (previouslyReadAyah == null) {
      return;
    }
    final snackBar = SnackBar(
      content: const MyCustomAnimation(
        duration: Duration(seconds: 3),
      ),
      //backgroundColor: Colors.black,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 100),
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'Continue',
        textColor: Colors.green,
        onPressed: goToLastReadAyah,
      ),
      duration: const Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  bool snackBarShowed = false;
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
}

class AyahByAyahScreen extends ConsumerWidget {
  static const String id = 'verseByVerse';

  final int chapterNo;
  final String surahBackground =
      kBeautifulBackgrounds[Random().nextInt(kBeautifulBackgrounds.length)];
  AyahByAyahScreen({Key? key, required this.chapterNo}) : super(key: key);

  bool scrolled = false;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    final aP = ref.watch(ayahByAyahProvider(chapterNo));
    if (!aP.snackBarShowed) {
      aP.showLastReadSnackBar(context);
    }

    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        await aP.persistLastVisibleAyah();
        Navigator.pop(context, aP.lastVisibleAyah);
        return true;
        //VerseByVerseC.scroller.dispose();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Theme.of(context).canvasColor,
            title: const Text(
              'e-Quran',
            ),
          ),
          body: Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Container(
                    //width: 300,
                    //height: 250,
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(surahBackground),
                      ),
                    ),
                    child: Center(
                      child: GlassMorphism(
                        start: 0.1,
                        end: 0.2,
                        child: Container(
                          margin: const EdgeInsets.all(20.0),
                          child: AutoSizeText(
                            aP.surah?.name ?? '',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    child: ListView.builder(
                      itemCount: aP.surahText.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        if (index == 0) {
                          return aP.surahText[index].chapterNo == 1
                              ? VisibilityDetector(
                                  key: aP.textLocation[index],
                                  onVisibilityChanged: (VisibilityInfo info) {
                                    aP.updateLastVisibleAyah(
                                        aP.surahTranslationText[index]);
                                  },
                                  child: EachAyahWidget(
                                    no: aP.surahText[index].numberInSurah,
                                    copyText: () {
                                      Clipboard.setData(ClipboardData(
                                          text:
                                              '${aP.surahText[index].text}﴿${arabicNumeric(aP.surahText[index].numberInSurah)}﴾\n${aP.surahTranslationText[index].text}\n\n${aP.surah!.englishName} ${aP.surahText[index].numberInSurah}'));
                                    },
                                    share: () async {
                                      await aP.persistLastVisibleAyah();
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return StatusMaker(
                                            ayahNumber: aP
                                                .surahTranslationText[index]
                                                .number);
                                      }));
                                    },
                                    chapterNo: aP.surah!.number,
                                    arabic: aP.surahText[index].text,
                                    translation:
                                        aP.surahTranslationText[index].text,
                                    textDirection: aP
                                                .surahTranslationText[index]
                                                .direction ==
                                            "ltr"
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                    textDirectionString: aP
                                        .surahTranslationText[index].direction,
                                    sajda:
                                        aP.surahTranslationText[index].sajda ??
                                            '', //data.data[0][index].sajda,

                                    bookmarked: aP.surahTranslationText[index]
                                            .bookmarked ??
                                        false,
                                    bookmark: () {
                                      aP.bookmarkAyah(
                                          aP.surahTranslationText[index]);
                                    },
                                    isReciting:
                                        aP.surahTranslationText[index].number ==
                                            aP.currentRecitingAyah,
                                    audio: () async {
                                      aP.reciteAyah(
                                          context: context,
                                          ref: ref,
                                          ayah: aP.surahTranslationText[index]);
                                    },
                                  ),
                                )
                              : Column(
                                  children: [
                                    aP.surahText[index].chapterNo == 9
                                        ? VisibilityDetector(
                                            key: aP.textLocation[index],
                                            onVisibilityChanged:
                                                (VisibilityInfo info) {
                                              aP.updateLastVisibleAyah(aP
                                                  .surahTranslationText[index]);
                                            },
                                            child: EachAyahWidget(
                                              no: aP.surahText[index]
                                                  .numberInSurah,

                                              chapterNo: aP.surah!.number,
                                              copyText: () {
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                        '${aP.surahText[index].text}﴿${arabicNumeric(aP.surahText[index].numberInSurah)}﴾\n${aP.surahTranslationText[index].text}\n\n${aP.surah!.englishName} ${aP.surahText[index].numberInSurah}'));
                                              },
                                              share: () async {
                                                await aP
                                                    .persistLastVisibleAyah();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return StatusMaker(
                                                          ayahNumber: aP
                                                              .surahTranslationText[
                                                                  index]
                                                              .number);
                                                    },
                                                  ),
                                                );
                                              },
                                              arabic: aP.surahText[index].text,
                                              translation: aP
                                                  .surahTranslationText[index]
                                                  .text,
                                              textDirection:
                                                  aP.surahTranslationText[index]
                                                              .direction ==
                                                          "ltr"
                                                      ? TextDirection.ltr
                                                      : TextDirection.rtl,
                                              textDirectionString: aP
                                                  .surahTranslationText[index]
                                                  .direction,
                                              sajda: aP
                                                      .surahTranslationText[
                                                          index]
                                                      .sajda ??
                                                  '', //data.data[0][index].sajda,

                                              bookmarked:
                                                  aP.surahTranslationText[index]
                                                          .bookmarked ??
                                                      false,
                                              bookmark: () {
                                                aP.bookmarkAyah(
                                                    aP.surahTranslationText[
                                                        index]);
                                              },
                                              isReciting:
                                                  aP.surahTranslationText[index]
                                                          .number ==
                                                      aP.currentRecitingAyah,
                                              audio: () async {
                                                aP.reciteAyah(
                                                    context: context,
                                                    ref: ref,
                                                    ayah:
                                                        aP.surahTranslationText[
                                                            index]);
                                              },
                                            ),
                                          )
                                        : Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge
                                                    ?.color,
                                                fontSize: 37.0,
                                                fontFamily:
                                                    "ScheherazadeNew-Bold",
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ),
                                    aP.surahText[index].chapterNo == 9
                                        ? Container()
                                        : VisibilityDetector(
                                            key: aP.textLocation[index],
                                            onVisibilityChanged:
                                                (VisibilityInfo info) {
                                              aP.updateLastVisibleAyah(aP
                                                  .surahTranslationText[index]);
                                            },
                                            child: EachAyahWidget(
                                              no: aP.surahText[index]
                                                  .numberInSurah,

                                              chapterNo: aP.surah!.number,
                                              copyText: () {
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                        '${aP.surahText[index].text}﴿${arabicNumeric(aP.surahText[index].numberInSurah)}﴾\n${aP.surahTranslationText[index].text}\n\n${aP.surah!.englishName} ${aP.surahText[index].numberInSurah}'));
                                              },
                                              share: () async {
                                                await aP
                                                    .persistLastVisibleAyah();
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return StatusMaker(
                                                      ayahNumber: aP
                                                          .surahTranslationText[
                                                              index]
                                                          .number);
                                                }));
                                              },
                                              arabic: aP.surahText[index].text
                                                  .split(
                                                      "بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ")[1],
                                              translation: aP
                                                  .surahTranslationText[index]
                                                  .text,
                                              textDirection:
                                                  aP.surahTranslationText[index]
                                                              .direction ==
                                                          "ltr"
                                                      ? TextDirection.ltr
                                                      : TextDirection.rtl,
                                              textDirectionString: aP
                                                  .surahTranslationText[index]
                                                  .direction,
                                              sajda: aP
                                                      .surahTranslationText[
                                                          index]
                                                      .sajda ??
                                                  '', //data.data[0][index].sajda,

                                              bookmarked:
                                                  aP.surahTranslationText[index]
                                                          .bookmarked ??
                                                      false,
                                              bookmark: () {
                                                aP.bookmarkAyah(
                                                    aP.surahTranslationText[
                                                        index]);
                                              },
                                              isReciting:
                                                  aP.surahTranslationText[index]
                                                          .number ==
                                                      aP.currentRecitingAyah,
                                              audio: () async {
                                                aP.reciteAyah(
                                                    context: context,
                                                    ref: ref,
                                                    ayah:
                                                        aP.surahTranslationText[
                                                            index]);
                                              },
                                            ),
                                          )
                                  ],
                                );
                        }

                        return VisibilityDetector(
                          key: aP.textLocation[index],
                          onVisibilityChanged: (VisibilityInfo info) {
                            aP.updateLastVisibleAyah(
                                aP.surahTranslationText[index]);
                          },
                          child: EachAyahWidget(
                            no: aP.surahText[index].numberInSurah,
                            copyText: () {
                              Clipboard.setData(ClipboardData(
                                  text:
                                      '${aP.surahText[index].text}﴿${arabicNumeric(aP.surahText[index].numberInSurah)}﴾\n${aP.surahTranslationText[index].text}\n\n${aP.surah!.englishName} ${aP.surahText[index].numberInSurah}'));
                            },
                            share: () async {
                              await aP.persistLastVisibleAyah();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StatusMaker(
                                    ayahNumber:
                                        aP.surahTranslationText[index].number);
                              }));
                            },

                            chapterNo: aP.surahText[index].chapterNo,
                            arabic: aP.surahText[index].text,
                            translation: aP.surahTranslationText[index].text,
                            textDirection:
                                aP.surahTranslationText[index].direction ==
                                        "ltr"
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                            textDirectionString:
                                aP.surahTranslationText[index].direction,
                            sajda: aP.surahTranslationText[index].sajda ??
                                '', //data.data[0][index].sajda,

                            bookmarked:
                                aP.surahTranslationText[index].bookmarked ??
                                    false,
                            bookmark: () {
                              aP.bookmarkAyah(aP.surahTranslationText[index]);
                            },
                            isReciting: aP.surahTranslationText[index].number ==
                                aP.currentRecitingAyah,
                            audio: () async {
                              aP.reciteAyah(
                                  context: context,
                                  ref: ref,
                                  ayah: aP.surahTranslationText[index]);
                            },
                          ),
                        );
                      }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            scrollController.jumpTo(0.0);
                          },
                          child: const Text('Back to Top')),
                      ElevatedButton(
                          onPressed: () async {
                            await aP.persistLastVisibleAyah();
                            Navigator.pop(context);
                          },
                          child: const Text('Select another Surah')),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavigationChild extends StatelessWidget {
  final IconData? icon;
  final String? info;
  final Function? func;
  final bool isSelected;
  const BottomNavigationChild(
      {Key? key, this.icon, this.info, this.func, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: func as void Function()?,
        child: ListTile(
          selected: isSelected,
          title: Icon(
            icon,
            color: isSelected ? const Color(0XFF29BB89) : Colors.white,
            size: 40.0,
          ),
          subtitle: Text(
            info!,
            style: TextStyle(
              color: isSelected ? const Color(0XFF29BB89) : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
