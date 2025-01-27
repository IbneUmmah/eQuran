import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';

import 'package:quran/widgets/reuseablewidgets.dart';

final reciterProvider = ChangeNotifierProvider((_) => ReciterController());

class ReciterController with ChangeNotifier {
  //Search Feature///

  ReciterController() {
    generateReciters();
  }

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

  List<Reciter> totalReciters = [];
  List<Reciter> foundReciters = [];

  generateReciters() {
    List<Reciter> reciters =
        UC.isar.reciters.where().sortByName().findAllSync();
    totalReciters = reciters;
    foundReciters = reciters;
  }

  updateBookmark(Reciter reciter) {
    reciter.bookmarked = !(reciter.bookmarked);
    UC.isar.writeTxn(() {
      return UC.isar.reciters.put(reciter);
    });
    notifyListeners();
  }

  updateSelected(Reciter reciter) {
    Reciter? alreadySelectedReciter;

    for (Reciter reciter in totalReciters) {
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
    UC.uv.updateSelectedReciter(reciter);
    notifyListeners();
    compute(resetSurahsDurations, true);
  }

  searchByNameOrNumber(String str) {
    if (str.isEmpty) {
      foundReciters = totalReciters;
      notifyListeners();
      return;
    }
    int value = int.tryParse(str) ?? 0;
    if (value != 0 && value <= 134) {
      List<Reciter> current = [totalReciters[value]];

      foundReciters = current;
      notifyListeners();
      return;
    } else {
      List<Reciter> current = [];
      for (int i = 0; i < totalReciters.length; i++) {
        String lower = str.toLowerCase();

        final toMatch = RegExp(lower);
        if (toMatch.hasMatch(totalReciters[i].name.toLowerCase())) {
          current.add(totalReciters[i]);
        }
      }

      foundReciters = current;
      notifyListeners();
    }
  }
}

class RecitersScreen extends ConsumerWidget {
  static const id = 'Reciters';

  RecitersScreen({Key? key}) : super(key: key);
  String image =
      kBeautifulBackgrounds[Random().nextInt(kBeautifulBackgrounds.length)];
  ScrollController scroll = ScrollController();

  @override
  Widget build(BuildContext context, ref) {
    final rP = ref.watch(reciterProvider);

    return WillPopScope(
      onWillPop: () async {
        rP.unfocusClear();
        scroll.dispose();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
              //automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).canvasColor,
              title: rP.isSearching
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          80.0,
                        ),
                      ),
                      child: CupertinoTextField(
                        autofocus: true,
                        focusNode: rP.focusNode,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                        keyboardType: TextInputType.text,
                        controller: rP.textEditingController,
                        onChanged: (String str) {
                          rP.searchByNameOrNumber(str);
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
                            'Search Reciters',
                          ),
                          InkWell(
                            onTap: () {
                              rP.updateSearch(true);

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
                                    '${rP.totalReciters.length} Reciters Available',
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
                        itemCount: rP.foundReciters.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AnimationConfiguration.staggeredGrid(
                            columnCount: rP.foundReciters.length,
                            position: index,
                            duration: const Duration(milliseconds: 475),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: EachReciterWidget(
                                  reciterNo: index + 1,
                                  reciterName: rP.foundReciters[index].name,
                                  isBookmarked:
                                      rP.foundReciters[index].bookmarked,
                                  bookmarkTap: () {
                                    rP.updateBookmark(rP.foundReciters[index]);
                                  },
                                  isSelected:
                                      rP.foundReciters[index].isSelected,
                                  selected: () {
                                    rP.updateSelected(rP.foundReciters[index]);
                                  },
                                  server: rP.foundReciters[index].identifier,
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
