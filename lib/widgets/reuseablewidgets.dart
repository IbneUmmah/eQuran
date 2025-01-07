import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran/main.dart';
import 'package:quran/widgets/ayahcount.dart';
import 'package:quran/widgets/customanimations.dart';
import 'package:visibility_detector/visibility_detector.dart';

Map<String, String> arabicNumbers = {
  '0': '٠',
  '1': '١',
  '2': '٢',
  '3': '٣',
  '4': '٤',
  '5': '٥',
  '6': '٦',
  '7': '٧',
  '8': '٨',
  '9': '٩'
};
String arabicNumeric(int i) {
  String mathNumbers = i.toString();
  String finalString = '';

  for (String character in mathNumbers.characters) {
    finalString = finalString + arabicNumbers[character]!;
  }
  return finalString;
}

showToast(
    {required BuildContext context,
    required Widget content,
    Duration duration = const Duration(seconds: 4),
    Color color = Colors.green,
    SnackBarAction? action}) {
  final snackBar = SnackBar(
    content: CountDownAnimation(
      duration: duration,
      color: color,
      child: content,
    ),
    //backgroundColor: Colors.black,

    action: action,
    duration: duration,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final TextDirection textDirection;
  final Duration animationDuration, backDuration, pauseDuration;

  const MarqueeWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.textDirection = TextDirection.ltr,
    this.animationDuration = const Duration(milliseconds: 6000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: widget.direction,
      controller: scrollController,
      child: widget.child,
    );
  }

  jumpToEnd() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      widget.textDirection == TextDirection.rtl ? jumpToEnd() : null;
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          widget.textDirection == TextDirection.rtl
              ? scrollController.position.minScrollExtent
              : scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
        );
      }
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: Curves.easeOut,
        );
      }
    }
  }
}

class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;
  final Color color;
  const GlassMorphism({
    Key? key,
    required this.child,
    required this.start,
    required this.end,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(start),
                color.withOpacity(end),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              width: 1.5,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class CircleGlassMorphism extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;
  final Color color;
  const CircleGlassMorphism({
    Key? key,
    required this.child,
    required this.start,
    required this.end,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(start),
              color.withOpacity(end),
            ],
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
          ),
          //borderRadius: BorderRadius.circular(10.0),
          shape: BoxShape.circle,
          // border: Border.all(
          //   width: 1.5,
          //   color: Colors.white.withOpacity(0.2),
          // ),
        ),
        child: child,
      ),
    );
  }
}

class EachAudioSurahWidget extends StatelessWidget {
  final String chapterNo;
  final String chapterNameEn;
  final String chapterNameAr;
  final String chapterType;
  final String chapterAyats;
  final bool? isFavourite;
  final bool? isRepeat;
  final bool isReciting;
  final Function playTap;

  const EachAudioSurahWidget(
      {Key? key,
      required this.chapterNo,
      required this.chapterNameEn,
      required this.chapterNameAr,
      required this.chapterType,
      required this.chapterAyats,
      this.isFavourite,
      this.isRepeat,
      required this.isReciting,
      required this.playTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: playTap as void Function()?,
      child: Container(
        //height: 120.0,
        decoration: BoxDecoration(
          border: isReciting
              ? Border.all(
                  color: const Color(0XFF29BB89),
                  width: 2,
                  style: BorderStyle.solid,
                )
              : const Border(),
          borderRadius: BorderRadius.circular(
            15.0,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: const EdgeInsets.all(4.0),
                margin: const EdgeInsets.only(
                  top: 4.0,
                  bottom: 4.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CounterWidget(
                      count: int.parse(
                        chapterNo,
                      ),
                      isReciting: isReciting,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chapterNameEn,
                          textAlign: TextAlign.start,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    height: 1.2,
                                    color: isReciting
                                        ? const Color(0XFF29BB89)
                                        : Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.color,
                                  ),
                        ),
                        Text(
                          '$chapterType $chapterAyats Ayats',
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    //TODO: it was .button before
                                    color: isReciting
                                        ? const Color(0XFF29BB89)
                                        : Colors
                                            .grey, //Theme.of(context).primaryColor.withOpacity(0.8),
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ],
                    ),
                    Text(
                      chapterNameAr,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            height: 1,
                            fontFamily: "ScheherazadeNew-Bold",
                            color: isReciting
                                ? const Color(0XFF29BB89)
                                : Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class EachAyahWidget extends StatelessWidget {
  final int no;

  final int chapterNo;
  final String arabic;
  final String sajda;
  final String translation;
  final String textDirectionString;
  final Function copyText;
  final Function audio;
  final Function share;
  final Function bookmark;
  final bool isReciting;
  final TextDirection textDirection;
  final bool bookmarked;
  const EachAyahWidget({
    Key? key,
    required this.no,
    required this.chapterNo,
    required this.arabic,
    required this.sajda,
    required this.translation,
    required this.textDirectionString,
    required this.textDirection,
    required this.copyText,
    required this.audio,
    required this.share,
    required this.bookmark,
    required this.bookmarked,
    this.isReciting = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //key: key,
      surfaceTintColor: Theme.of(context).canvasColor,
      color: Theme.of(context).canvasColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Text(
                '$arabic﴿${arabicNumeric(no)}﴾',
                style: TextStyle(
                  fontSize: UC.uv.selectedArabicFontSize,
                  fontFamily: "ScheherazadeNew-Bold",
                ),
                textAlign: TextAlign.justify,
                textDirection: TextDirection.rtl,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  translation,
                  style: TextStyle(
                    fontSize: UC.uv.selectedTranslationFontSize,
                    fontFamily: "NotoNastaliqUrdu-Regular",
                    height: 2.0,
                  ),
                  textAlign: TextAlign.justify,
                  textDirection: textDirection,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                //color: Colors.transparent,
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(sajda),
                        CupertinoContextMenu(
                          actions: <Widget>[
                            CupertinoContextMenuAction(
                              isDefaultAction: true,
                              onPressed: () {
                                copyText();
                                Navigator.pop(context);
                              },
                              trailingIcon:
                                  CupertinoIcons.doc_on_clipboard_fill,
                              child: const Text('Copy Text'),
                            ),
                            CupertinoContextMenuAction(
                              onPressed: () {
                                share();
                              },
                              trailingIcon: CupertinoIcons.share,
                              child: const Text('Share as Picture'),
                            ),
                            CupertinoContextMenuAction(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              trailingIcon: Icons.exit_to_app,
                              isDestructiveAction: true,
                              child: const Text('Cancel'),
                            ),
                          ],
                          child: Material(
                            child: InkWell(
                              onTap: () {
                                share();
                              },
                              child: const Icon(Icons.share),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            bookmark();
                          },
                          child: Icon(
                            bookmarked
                                ? CupertinoIcons.bookmark_fill
                                : CupertinoIcons.bookmark,
                            size: 20.0,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            await audio();
                          },
                          child: Icon(
                            // vc.currentRecitingAyah == no
                            isReciting
                                ? CupertinoIcons.pause
                                : CupertinoIcons.play,

                            size: 25.0,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AudioTranslationWidget extends StatelessWidget {
  final String translationNo;
  final String translationNameEn;
  final String translationNameL;

  //final bool isLiked;
  //final Function likedTap;
  final bool isSelected;
  final Function selectedTap;

  const AudioTranslationWidget({
    Key? key,
    required this.translationNo,
    required this.translationNameEn,
    required this.translationNameL,
    //required this.isLiked,
    //required this.likedTap,
    required this.isSelected,
    required this.selectedTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onDoubleTap: likedTap as void Function()?,
      child: Column(
        children: [
          ListTile(
            leading: CounterWidget(count: int.parse(translationNo)),
            title: Text(
              translationNameEn,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            trailing: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    //elevation: MaterialStateProperty.all(10.0),
                    backgroundColor: MaterialStateProperty.all(
                      isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context)
                              .canvasColor, //Theme.of(context).primaryColor,
                    ),
                  ),
              onPressed: selectedTap as void Function()?,
              child: Text(isSelected ? 'Selected' : 'Select',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            subtitle: Text(
              translationNameL,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          )
        ],
      ),
    );
  }
}

class EachReciterWidget extends StatelessWidget {
  final int reciterNo;
  final String reciterName;
  final bool isSelected;
  final Function selected;
  final bool isBookmarked;
  final Function bookmarkTap;
  final String server;

  const EachReciterWidget(
      {Key? key,
      required this.reciterNo,
      required this.reciterName,
      required this.isBookmarked,
      required this.bookmarkTap,
      required this.isSelected,
      required this.selected,
      required this.server})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      //onTap: () {},
      onDoubleTap: bookmarkTap as void Function()?,
      child: Column(
        children: [
          ListTile(
            leading: CounterWidget(count: reciterNo),
            title: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                reciterName,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            trailing: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    //elevation: MaterialStateProperty.all(10.0),
                    backgroundColor: MaterialStateProperty.all(
                      isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context)
                              .canvasColor, //Theme.of(context).primaryColor,
                    ),
                  ),
              onPressed: selected as void Function()?,
              child: Text(
                isSelected ? 'Selected' : 'Select',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: GestureDetector(
              onTap: bookmarkTap as void Function()?,
              child: Icon(
                isBookmarked
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark,
                size: 20.0,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          )
        ],
      ),
    );
  }
}

class EachTextSurahWidget extends StatelessWidget {
  final String chapterNo;
  final String chapterNameEn;
  final String chapterNameAr;
  final String chapterNametranslation;
  final String chapterType;
  final String chapterAyats;
  final bool isFavourite;

  final Function tap;
  final Function likeButton;

  const EachTextSurahWidget({
    Key? key,
    required this.chapterNo,
    required this.chapterNameEn,
    required this.chapterNameAr,
    required this.chapterNametranslation,
    required this.chapterType,
    required this.chapterAyats,
    required this.isFavourite,
    required this.tap,
    required this.likeButton,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap as void Function(),
      onDoubleTap: likeButton as void Function(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.only(
                top: 8.0,
                bottom: 4.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  justCount(int.parse(chapterNo) - 1),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapterNameEn,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              height: 1.2,
                            ),
                      ),
                      Text(
                        '$chapterType $chapterAyats Ayats',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                  Text(
                    chapterNameAr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          height: 1.2,
                        ),
                  ),
                ],
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: likeButton as void Function()?,
                child: Icon(
                  isFavourite ? Icons.bookmark : Icons.bookmark_border,
                  size: 20.0,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          )
        ],
      ),
    );
  }
}

class EachTextTranslationWidget extends StatelessWidget {
  final String translationNo;
  final String translationNameEn;
  final String translationNameL;
  final String type;

  final bool isBookmarked;
  final Function bookmarkTap;
  final bool isSelected;
  final bool isDownloading;
  final Function selectedTap;

  const EachTextTranslationWidget({
    Key? key,
    required this.translationNo,
    required this.translationNameEn,
    required this.translationNameL,
    required this.type,
    //required this.translationIdentifier,
    //  this.textDirection,
    required this.isBookmarked,
    required this.bookmarkTap,
    this.isDownloading = false,
    required this.isSelected,
    required this.selectedTap,
  }) : super(key: key);

  //RxBool downloading = false.obs;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: bookmarkTap as void Function()?,
      child: Column(
        children: [
          ListTile(
            leading: CounterWidget(count: int.parse(translationNo)),
            title: Text(
              translationNameEn,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            trailing: ElevatedButton(
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    //elevation: MaterialStateProperty.all(10.0),
                    backgroundColor: MaterialStateProperty.all(
                      isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context)
                              .canvasColor, //Theme.of(context).primaryColor,
                    ),
                  ),
              onPressed: selectedTap as void Function()?,
              child: Text(
                  isDownloading
                      ? 'Downloading'
                      : isSelected
                          ? 'Selected'
                          : 'Select',
                  style: Theme.of(context).textTheme.bodySmall),
            ),
            subtitle: Text(
              '$translationNameL\n$type',
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
            ),
          ),
          InkWell(
            onTap: bookmarkTap as void Function()?,
            child: Icon(
              isBookmarked
                  ? CupertinoIcons.bookmark_fill
                  : CupertinoIcons.bookmark,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 20.0,
            ),
            child: Divider(
              color: Colors.grey,
              thickness: 0.2,
            ),
          )
        ],
      ),
    );
  }
}

WidgetSpan counter(int i) {
  return WidgetSpan(
    child: Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 8.0,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
              child: CustomPaint(
            size: Size(45, (45 * 1).toDouble()),
            painter: CounterFrame(),
          )),
          Positioned(
            left: i < 10
                ? 18.0
                : i < 100
                    ? 14.0
                    : 10.0,
            top: 6.0,
            width: 45.0,
            height: 45.0,
            child: Text(arabicNumeric(i + 1),
                softWrap: true,
                style: const TextStyle(
                  fontSize: 20.0,
                )),
          ),
        ],
      ),
    ),
  );
}

WidgetSpan stringCounter(int i, Key key, Function onVisibilityChanged) {
  return WidgetSpan(
    child: VisibilityDetector(
      onVisibilityChanged: (VisibilityInfo info) {
        onVisibilityChanged();
      },
      key: key,
      child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            bottom: 8.0,
          ),
          child: Text(
            '﴾${arabicNumeric(i + 1)}﴿',
            style: TextStyle(fontSize: UC.uv.selectedArabicFontSize),
          )),
    ),
  );
}

Widget justCount(int i) {
  return Padding(
    padding: const EdgeInsets.only(
      left: 8.0,
      right: 8.0,
      bottom: 8.0,
    ),
    child: Text(
      '﴾${arabicNumeric(i + 1)}﴿',
      style: const TextStyle(
        fontSize: 30.0,
      ),
    ),
  );
}

class CounterWidget extends StatelessWidget {
  final int count;
  final bool isReciting;
  const CounterWidget({Key? key, required this.count, this.isReciting = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
            child: CustomPaint(
          size: Size(45, (45 * 1).toDouble()),
          painter: CounterFrame(),
        )),
        Positioned(
          left: count < 10
              ? 20.0
              : count < 100
                  ? 18.0
                  : 14.0,
          top: 10.0,
          width: 45.0,
          height: 45.0,
          child: Text(count.toString(),
              softWrap: true,
              style: TextStyle(
                fontSize: 12.0,
                color: isReciting
                    ? const Color(0XFF29BB89)
                    : Theme.of(context).textTheme.bodyLarge?.color,
              )),
        ),
      ],
    );
  }
}
