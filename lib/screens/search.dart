// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/audiostate.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';
import 'package:quran/screens/statusmaker.dart';
import 'package:quran/widgets/customanimations.dart';
import 'package:quran/widgets/reuseablewidgets.dart';

final searchProvider =
    ChangeNotifierProvider.autoDispose((_) => SearchController());

class SearchController with ChangeNotifier {
  String status = 'Type anything to search for\n.g: ALLAH';

  bool isSearching = false;
  bool isLooking = false;
  int byWord = 0;
  int bySentence = 1;
  int groupValue = 0;

  updateGroupValue(int? newGroupValue) {
    groupValue = newGroupValue ?? 0;
    notifyListeners();
  }

  updateSearch(bool _) {
    isSearching = _;

    notifyListeners();
  }

  void unfocusClear() {
    searchByNameOrNumber('');
  }

  List<Ayah> foundArabicAyahs = [];
  List<Ayah> foundTranslationAyahs = [];

  updateBookmark(Ayah ayah) {
    ayah.bookmarked = !(ayah.bookmarked ?? false);
    UC.isar.writeTxn(() {
      return UC.isar.ayahs.put(ayah);
    });
    notifyListeners();
  }

  searchByNameOrNumber(String str) async {
    foundArabicAyahs.clear();
    foundTranslationAyahs.clear();
    status = "Searching...";
    isLooking = true;
    notifyListeners();

    List qr = str.split(' ');

    if (qr.length == 1) {
      compute(finAyahsByWord, str).then((response) {
        if (response[0].isNotEmpty) {
          foundArabicAyahs = response[0];

          foundTranslationAyahs = response[1];
        } else {
          status = 'Found Nothing! Try another term';
          foundArabicAyahs.clear();
          foundTranslationAyahs.clear();
        }

        isLooking = false;
        notifyListeners();
      });
    } else {
      compute(finAyahsBySentence, str).then((response) {
        if (response[0].isNotEmpty) {
          foundArabicAyahs = response[0];

          foundTranslationAyahs = response[1];
        } else {
          status = 'Found Nothing! Try another term';
          foundArabicAyahs.clear();
          foundTranslationAyahs.clear();
        }

        isLooking = false;
        notifyListeners();
      });
    }
  }

  void bookmarkAyah(Ayah ayah) {
    ayah.bookmarked = !(ayah.bookmarked ?? false);
    UC.isar.writeTxnSync(() {
      UC.isar.ayahs.putSync(ayah);
    });
    notifyListeners();
  }

  reciteAyah(
      {required BuildContext context,
      required WidgetRef ref,
      required Ayah ayah}) async {
    final snackBar = SnackBar(
      content: AyahRecitingWidget(
        text: ayah.text,
        textDirection:
            ayah.direction == 'rtl' ? TextDirection.rtl : TextDirection.ltr,
      ),
      duration: const Duration(minutes: 5),
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

class Search extends ConsumerWidget {
  Search({Key? key}) : super(key: key) {
    focusNode.requestFocus();
  }

  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  ScrollController scroll = ScrollController();
  String image =
      kBeautifulBackgrounds[Random().nextInt(kBeautifulBackgrounds.length)];

  @override
  Widget build(BuildContext context, ref) {
    final sP = ref.watch(searchProvider);
    return WillPopScope(
      onWillPop: () async {
        sP.unfocusClear();
        scroll.dispose();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
              //automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).canvasColor,
              title: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    80.0,
                  ),
                ),
                child: CupertinoTextField(
                  autofocus: true,
                  focusNode: focusNode,
                  suffix: InkWell(
                      onTap: () {
                        sP.searchByNameOrNumber(
                            textEditingController.value.text);
                      },
                      child: const Icon(CupertinoIcons.search)),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                  ),
                  keyboardType: TextInputType.text,
                  controller: textEditingController,
                  onChanged: (String str) {
                    //sP.searchByNameOrNumber(str);
                  },
                  onSubmitted: (value) {
                    sP.searchByNameOrNumber(value);
                  },
                ),
              )),
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
                                    '${sP.foundArabicAyahs.length} Ayahs found',
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
                sP.foundArabicAyahs.isEmpty
                    ? sP.isLooking
                        ? Padding(
                            padding: const EdgeInsets.only(top: 38.0),
                            child: Column(
                              children: [
                                const CircularProgressIndicator(
                                  color: Colors.green,
                                ),
                                Center(
                                  child: Text(sP.status),
                                )
                              ],
                            ),
                          )
                        : Center(
                            child: Text(sP.status),
                          )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimationLimiter(
                          child: ListView.builder(
                              itemCount: sP.foundArabicAyahs.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return AnimationConfiguration.staggeredGrid(
                                  columnCount: sP.foundArabicAyahs.length,
                                  position: index,
                                  duration: const Duration(milliseconds: 475),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: EachAyahWidget(
                                        no: sP.foundArabicAyahs[index]
                                            .numberInSurah,
                                        copyText: () {
                                          Clipboard.setData(ClipboardData(
                                              text:
                                                  '${sP.foundArabicAyahs[index].text}﴿${arabicNumeric(sP.foundArabicAyahs[index].numberInSurah)}﴾\n${sP.foundTranslationAyahs[index].text}'));
                                        },
                                        share: () async {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return StatusMaker(
                                                ayahNumber: sP
                                                    .foundTranslationAyahs[
                                                        index]
                                                    .number);
                                          }));
                                        },

                                        chapterNo: sP
                                            .foundArabicAyahs[index].chapterNo,
                                        arabic: sP.foundArabicAyahs[index].text,
                                        translation: sP
                                            .foundTranslationAyahs[index].text,
                                        textDirection:
                                            sP.foundTranslationAyahs[index]
                                                        .direction ==
                                                    "ltr"
                                                ? TextDirection.ltr
                                                : TextDirection.rtl,
                                        textDirectionString: sP
                                            .foundTranslationAyahs[index]
                                            .direction,
                                        sajda: sP.foundTranslationAyahs[index]
                                                .sajda ??
                                            '', //data.data[0][index].sajda,

                                        bookmarked: sP
                                                .foundTranslationAyahs[index]
                                                .bookmarked ??
                                            false,
                                        bookmark: () {
                                          sP.bookmarkAyah(
                                              sP.foundTranslationAyahs[index]);
                                        },
                                        audio: () async {
                                          sP.reciteAyah(
                                              context: context,
                                              ref: ref,
                                              ayah: sP.foundTranslationAyahs[
                                                  index]);
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
