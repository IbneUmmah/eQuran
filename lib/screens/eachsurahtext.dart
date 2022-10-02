// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/fastfunctions.dart';

import 'package:quran/main.dart';

import 'package:quran/widgets/customanimations.dart';
import 'package:quran/widgets/reuseablewidgets.dart';

EachChapterFunctions functions = EachChapterFunctions();
final eachSurahTextProvider = ChangeNotifierProvider.autoDispose
    .family<EachSurahTextController, int>(
        (_, chapterNo) => EachSurahTextController(chapterNo));

class EachSurahTextController with ChangeNotifier {
  void startupServices(int chapterNo) async {
    // generateChaptersText(chapterNo);
  }

  List<GlobalKey> textLocation = [];

  final int currentChapterNo;
  EachSurahTextController(this.currentChapterNo) {
    //startupServices(currentChapterNo);
    scroller.addListener(_scrollListener);
  }
  bool chapterNameinArabic = true;

  double currentPixels = 0.0;
  double maximumPixels = 100.0;

  bool isBeingChanged = false;

  bool isPlaying = false;
  bool isReading = false;

  //final AudioPlayer player = QuranAudioController.player;

  startReading() {
    int? durationofScroll = 12;

    int speed = UC.hive.get('speed') ?? 1;
    isReading
        ? scroller.jumpTo(scroller.position.pixels)
        : scroller.animateTo(scroller.position.maxScrollExtent,
            duration: Duration(seconds: durationofScroll ~/ speed),
            curve: Curves.linear);
    isReading = !isReading;
    notifyListeners();
  }

  double totalDurationInSec = 0.0;
  int currentPositioninSec = 0;
  final int pixelsToScroll = 500;
  ScrollController scroller = ScrollController();

  _scrollListener() {
    ScrollDirection userScroll = scroller.position.userScrollDirection;
    double currentPixel = scroller.position.pixels;
    //double totalPixels = scroller.position.maxScrollExtent;
    currentPixels = currentPixel;

    if (userScroll == ScrollDirection.forward) {
      if (isPlaying) {
        scroller.jumpTo(scroller.position.pixels - pixelsToScroll);
        scroller.animateTo(scroller.position.maxScrollExtent,
            duration: Duration(
                seconds: (totalDurationInSec - currentPositioninSec).toInt()),
            curve: Curves.linear);
      } else if (isReading) {
        scroller.jumpTo(scroller.position.pixels - pixelsToScroll);
        int durationofScroll = 12;
        scroller.animateTo(scroller.position.maxScrollExtent,
            duration: Duration(
                seconds:
                    durationofScroll ~/ UC.hive.get('speed', defaultValue: 1)),
            curve: Curves.linear);
      }
    } else if (userScroll == ScrollDirection.reverse) {
      if (isPlaying) {
        scroller.jumpTo(scroller.position.pixels + pixelsToScroll);
        scroller.animateTo(scroller.position.maxScrollExtent,
            duration: Duration(
                seconds: (totalDurationInSec - currentPositioninSec).toInt()),
            curve: Curves.linear);
      } else if (isReading) {
        scroller.jumpTo(scroller.position.pixels + pixelsToScroll);
        int durationofScroll = 12;
        scroller.animateTo(scroller.position.maxScrollExtent,
            duration: Duration(
                seconds:
                    durationofScroll ~/ UC.hive.get('speed', defaultValue: 1)),
            curve: Curves.linear);
      }
    }
    maximumPixels = scroller.position.maxScrollExtent;
    // maximumPixels.update((val) {
    //   maximumPixels = RxDouble(scroller.position.maxScrollExtent);
    // });
    currentPixels = scroller.position.pixels;
    // currentPixels.update((val) {
    //   currentPixels = RxDouble(scroller.position.pixels);
    // });
  }

  List<Ayah> foundChapterText = [];
  Surah? surah;
  Ayah? lastVisibleAyah;
  Ayah? previouslyReadAyah;
  Widget textWidget = const CircularProgressIndicator(
    color: Colors.green,
  );
  updateLastVisibleAyah(Ayah ayah) {
    lastVisibleAyah = ayah;
  }

  generateChaptersText(int surahNo) async {
    List<Ayah> chapterText = await compute(getTextBySurahNo, surahNo);

    surah = UC.isar.surahs.filter().numberEqualTo(surahNo).findFirstSync();
    foundChapterText = chapterText;
    textLocation = List.generate(foundChapterText.length, (i) => GlobalKey());
    for (Ayah ayah in chapterText) {
      if (ayah.lastRead != null) {
        previouslyReadAyah = ayah;
      }
    }
  }

  goToLastReadAyah() {
    previouslyReadAyah != null
        ? Scrollable.ensureVisible(
            textLocation[previouslyReadAyah!.numberInSurah - 1].currentContext!)
        : null;
  }

  gotoChapter(int chapterNo) {
    generateChaptersText(chapterNo);
  }

  generateTextWidget(
    BuildContext context,
    double fontSize,
  ) {
    //List<String> ayats = chapter.where((element) => element['text']).toList();
    //Doub fontSize = 30.0;
    List<Ayah> surahText = foundChapterText;

    if (surahText.isEmpty) {
      return Container();
    }

    List<InlineSpan> allAyats = [];
    if (surahText[0].chapterNo != 1 && surahText[0].chapterNo != 9) {
      allAyats.add(
        TextSpan(
          text: surahText[0]
              .text
              .split("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ")[1],
        ),
      );
      allAyats.add(stringCounter(0, textLocation[0], () {
        updateLastVisibleAyah(surahText[0]);
      }));
    } else {
      if (surahText[0].chapterNo != 9) {
        if (surahText[0].chapterNo != 1) {
          allAyats.add(stringCounter(0, textLocation[0], () {
            updateLastVisibleAyah(surahText[0]);
          }));
        }

        allAyats.add(
          TextSpan(
            text: surahText[0]
                .text
                .split("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ")[1],
          ),
        );
      } else {
        allAyats.add(stringCounter(0, textLocation[0], () {
          updateLastVisibleAyah(surahText[0]);
        }));
      }
    }

    for (int i = 1; i < surahText.length; i++) {
      allAyats.add(
        TextSpan(
          text: surahText[i].text,
          children: [
            stringCounter(i, textLocation[i], () {
              updateLastVisibleAyah(surahText[i]);
            })
          ],
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1!.color,
            fontSize: fontSize,
            fontFamily: "ScheherazadeNew-Bold",
            textBaseline: TextBaseline.alphabetic,
          ),
        ),
      );
    }

    textWidget = RichText(
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      text: TextSpan(
          text: surahText[0].chapterNo == 9 ? surahText[0].text : null,
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1!.color,
            fontSize: fontSize,
            fontFamily: "ScheherazadeNew-Bold",
          ),
          children: allAyats),
    );
    notifyListeners();
  }

  Future<Ayah?> removePreviouslyReadAyah(int chapterNo) async {
    List<Ayah> previouslyReadAyahs = await UC.isar.ayahs
        .filter()
        .chapterNoEqualTo(chapterNo)
        .and()
        .languageEqualTo(kArabicText)
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

  persistLastVisibleAyah() {
    removePreviouslyReadAyah(surah!.number);
    if (lastVisibleAyah != null) {
      int time = DateTime.now().millisecondsSinceEpoch;
      lastVisibleAyah?.lastRead = time;
      surah?.lastRead = time;
      UC.isar.writeTxn(() {
        return UC.isar.surahs.put(surah!);
      });
      UC.isar.writeTxn(() {
        return UC.isar.ayahs.put(lastVisibleAyah!);
      });
    }
  }

  showLastReadSnackBar(BuildContext context) async {
    await generateChaptersText(currentChapterNo);
    generateTextWidget(context, UC.uv.selectedArabicFontSize);

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
}

class EachQuranText extends ConsumerWidget {
  static const String id = 'eachQuranText';
  final int chapterNo;
  EachQuranText({
    Key? key,
    required this.chapterNo,
  }) : super(key: key);

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    //final c = ref.watch(eachChapterTextProvider);
    final eSP = ref.watch(eachSurahTextProvider(chapterNo));
    if (!eSP.snackBarShowed) {
      eSP.showLastReadSnackBar(context);
    }

    return WillPopScope(
      onWillPop: () async {
        await eSP.persistLastVisibleAyah();
        print(eSP.lastVisibleAyah?.text);
        Navigator.pop(context, eSP.lastVisibleAyah);
        return true;
        // eSP.surah!.number != chapterNo
        //     ? ref.refresh(eachSurahTextProvider(chapterNo))
        //     : null;
        // return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            automaticallyImplyLeading: true,

            backgroundColor: Colors.transparent,
            //elevation: 0.0,
            //bottomOpacity: 0.0,
            //toolbarOpacity: 0.0,
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
                        image: CachedNetworkImageProvider(kBeautifulBackgrounds[
                            Random().nextInt(kBeautifulBackgrounds.length)]),
                      ),
                    ),
                    child: Center(
                      child: GlassMorphism(
                        start: 0.1,
                        end: 0.2,
                        child: Container(
                          margin: const EdgeInsets.all(20.0),
                          child: AutoSizeText(
                            eSP.surah?.name ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  eSP.foundChapterText.isEmpty
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            eSP.foundChapterText[0].chapterNo == 1
                                ? Flexible(flex: 1, child: justCount(0))
                                : const SizedBox(),
                            eSP.foundChapterText[0].chapterNo == 9
                                ? const SizedBox()
                                : const Flexible(
                                    flex: 4,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 18.0),
                                      child: AutoSizeText(
                                        "﻿بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                                        textAlign: TextAlign.justify,
                                        minFontSize: 30,
                                        maxFontSize: 40,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                  eSP.textWidget,
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
                            await eSP.persistLastVisibleAyah();
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

class EachChapterFunctions {}
