// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:isar/isar.dart';
import 'package:quran/commonutils.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/audiostate.dart';
import 'package:quran/functions/fastfunctions.dart';

import 'package:quran/main.dart';
import 'package:quran/models/yearlyprayertiming.dart';
import 'package:quran/screens/audioquran.dart';
import 'package:quran/screens/bookmark.dart';
import 'package:quran/screens/eachsurahtext.dart';
import 'package:quran/screens/startup.dart';
import 'package:quran/screens/surahlist.dart';
import 'package:quran/screens/search.dart';
import 'package:quran/screens/settings.dart';
import 'package:quran/screens/statusmaker.dart';
import 'package:quran/widgets/customanimations.dart';
import 'package:quran/widgets/reuseablewidgets.dart';

final homeProvider = ChangeNotifierProvider((_) => HomeController());

class HomeController with ChangeNotifier {
  Ayah? todayAyah;
  Ayah? todayAyahTranslation;
  Surah? todaySurah;
  late Surah todayChapter;
  late final Daily todayCalender;
  late Prayer currentPrayer;
  late Prayer nextPrayer;

  List<Ayah> lastReadTextAyahs = [];
  List<Surah> lastReadTextSurahs = [];
  List<Surah> lastRecitedSurahs = [];

  HomeController() {
    generateTodayPrayers();
    currentPrayerAndNext();
    genereRandomAyah();
    generateLastReadValues();
  }

  bool isRecitingAyah = false;
  reciteAyah(
      {required BuildContext context,
      required WidgetRef ref,
      required Ayah ayah}) async {
    isRecitingAyah = true;
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
    isRecitingAyah = false;
    notifyListeners();
  }

  currentPrayerAndNext() {
    DateTime now = DateTime.now();

    for (Prayer prayer in todayCalender.timings.prayers) {
      DateTime prayerTime = DateTime.parse(prayer.time).toLocal();

      if (prayerTime.compareTo(now) == -1) {
        currentPrayer = prayer;
      } else {
        nextPrayer = prayer;
        break;
      }
      //print("${prayer.name} ${prayerTime.compareTo(now)}");
    }
    notifyListeners();
  }

  generateTodayPrayers() {
    YearlyPrayerTiming yearlyPrayerTiming = YearlyPrayerTiming.fromJson(
      jsonDecode(
        UC.hive.get(kYearlyPrayerTimings),
      ),
    );

    todayCalender = yearlyPrayerTiming.data.months[DateTime.now().month - 1]
        [DateTime.now().day - 1];
    todayCalender.timings.prayers.sort(((a, b) => a.time.compareTo(b.time)));
    Prayer lastThird = todayCalender.timings.prayers.first;
    todayCalender.timings.prayers.removeAt(0);
    todayCalender.timings.prayers.add(lastThird);
    notifyListeners();
  }

  void bookmarkAyah() {
    todayAyahTranslation!.bookmarked =
        !(todayAyahTranslation!.bookmarked ?? false);
    UC.isar.writeTxnSync(() {
      UC.isar.ayahs.putSync(todayAyahTranslation!);
    });
    notifyListeners();
  }

  generateLastReadValues() async {
    lastReadTextSurahs = UC.isar.surahs
        .filter()
        .lastReadIsNotNull()
        .sortByLastReadDesc()
        .findAllSync();

    lastReadTextAyahs = UC.isar.ayahs
        .filter()
        .lastReadIsNotNull()
        .and()
        .languageEqualTo(kArabicText)
        .sortByLastReadDesc()
        .findAllSync();
    lastRecitedSurahs = await compute(getLastRecitedSurahs, true);

    notifyListeners();
  }

  genereRandomAyah() async {
    List response = await compute(getRandomAyah, true);
    todayAyah = response[0];
    todayAyahTranslation = response[1];
    todaySurah = response[2];

    notifyListeners();
  }
}

class Home extends ConsumerWidget {
  static const String id = "home";
  Home({Key? key}) : super(key: key);
  String image =
      kBeautifulBackgrounds[Random().nextInt(kBeautifulBackgrounds.length)];
  @override
  Widget build(BuildContext context, ref) {
    final c = ref.watch(controllerProvider);
    //final _ = ref.watch(bodyProvider);
    final hP = ref.watch(homeProvider);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).canvasColor,
            centerTitle: true,
            automaticallyImplyLeading: false, //true,
            foregroundColor: const Color(0XFF29BB89),

            actions: [
              GestureDetector(
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      title: const Text('Change Theme'),
                      cancelButton: Material(
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Center(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                            c.updateAppTheme(0);
                          },
                          child: const Text(
                            'System Default',
                            style: TextStyle(
                              color: Color(0XFF29BB89),
                            ),
                          ),
                        ),
                        CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                            c.updateAppTheme(1);
                          },
                          child: const Text(
                            'Light Mode',
                            style: TextStyle(
                              color: Color(0XFF29BB89),
                            ),
                          ),
                        ),
                        CupertinoActionSheetAction(
                          isDefaultAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                            c.updateAppTheme(2);
                          },
                          child: const Text(
                            'Dark Mode',
                            style: TextStyle(
                              color: Color(0XFF29BB89),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );

                  //c.isDark.toggle();
                  //SP.gs.put('darkMode', c.isDark.value);
                },
                child: const Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    right: 20.0,
                  ),
                  child: Icon(CupertinoIcons.moon,
                      semanticLabel: 'Dark Mode on/off button',
                      color: Color(0XFF29BB89) //: Colors.white,
                      ),
                ),
              ),
            ],

            title: Text(
              'eQuran',
              style: TextStyle(
                color: Color(0XFF29BB89),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                width:
                    double.infinity, //MediaQuery.of(context).size.width - 30,
                height: 270,
                child: Stack(
                  //fit: StackFit.expand,

                  children: [
                    Container(
                      //width: 300,
                      //height: 250,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(image),
                        ),
                      ),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ListTile(
                                title: Text(
                                  '${hP.todayCalender.date.gregorian.weekday.en} ${hP.todayCalender.date.readable}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: ListTile(
                                title: Text(
                                  '${hP.todayCalender.date.hijri.weekday.en} ${hP.todayCalender.date.hijri.date}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              hP.currentPrayer.name,
                              style: TextStyle(
                                fontSize: 20,
                                height: 1.2,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat("h:mm a")
                                      .format(
                                          DateTime.parse(hP.currentPrayer.time)
                                              .toLocal())
                                      .split(' ')[0],
                                  style: TextStyle(
                                    fontSize: 40,
                                    height: 1.2,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  DateFormat("h:mm a")
                                      .format(
                                          DateTime.parse(hP.currentPrayer.time)
                                              .toLocal())
                                      .split(' ')[1],
                                  style: TextStyle(
                                    height: 1.2,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                )
                              ],
                            ),
                            Text(
                              'Next ${hP.nextPrayer.name}',
                              style: TextStyle(
                                height: 1.2,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.justify,
                            )
                          ],
                        )
                      ]),
                    ), //Container
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: FractionallySizedBox(
                        child: Container(

                            //height: 200,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.transparent,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return Search();
                                    }));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Theme.of(context)
                                          .canvasColor
                                          .withOpacity(0.8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: 60,
                                          child: Center(
                                            child: Text(
                                              'Search Any Surah by Words',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      //color: Colors.grey,
                                                      ),
                                            ),
                                          ),
                                        ),
                                        Icon(CupertinoIcons.search),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ), //Container
                    //
                  ],
                ),
              ),
              Column(
                children: [
                  ListTile(
                    horizontalTitleGap: 0.0,
                    leading: IconTheme(
                      data: Theme.of(context).iconTheme,
                      child: Icon(
                        Icons.book,
                      ),
                    ),
                    title: Text(
                      'Ayat of the Day',
                    ),
                    trailing: SizedBox(
                      width: 90,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              hP.bookmarkAyah();
                            },
                            child: IconTheme(
                              data: Theme.of(context).iconTheme,
                              child: Icon(
                                hP.todayAyahTranslation?.bookmarked ?? false
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StatusMaker(
                                    ayahNumber: hP.todayAyah?.number ?? 90);
                              }));
                            },
                            child: IconTheme(
                              data: Theme.of(context).iconTheme,
                              child: Icon(Icons.share),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              hP.reciteAyah(
                                  context: context,
                                  ref: ref,
                                  ayah: hP.todayAyahTranslation!);
                            },
                            child: IconTheme(
                              data: Theme.of(context).iconTheme,
                              child: Icon(hP.isRecitingAyah
                                  ? Icons.pause
                                  : Icons.play_arrow),
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Text(
                      'Surah ${hP.todaySurah?.englishName ?? ''} Ayah ${hP.todayAyah?.numberInSurah ?? ''}',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      hP.todayAyah?.text ?? '',
                      textDirection: hP.todayAyah?.direction == 'rtl'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      hP.todayAyahTranslation?.text ?? '',
                      textDirection: hP.todayAyahTranslation?.direction == 'rtl'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontFamily: "NotoNastaliqUrdu-Regular",
                          ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Prayer Timings',
                            style: TextStyle(
                              height: 2.2,
                              fontSize: 20,
                              // color: Colors.white,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView.builder(
                        itemCount: hP.todayCalender.timings.prayers.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return PrayerTimeBox(
                              time: DateFormat("h:mm a").format(DateTime.parse(
                                      hP.todayCalender.timings.prayers[index]
                                          .time)
                                  .toLocal()),
                              name:
                                  hP.todayCalender.timings.prayers[index].name,
                              image: kAIAdhanBackgrounds[index]);
                        }),
                  ),
                ],
              ),
              OpenContainer(
                closedBuilder: (context, action) => PlayerClose(),
                closedElevation: 0.0,
                /*   closedShape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(50.0),
                                            topRight: Radius.circular(50.0),
                                            bottomLeft: Radius.circular(50.0),
                                            bottomRight: Radius.circular(50.0),
                                          )), */
                closedColor: Colors.transparent, //CColors.green,

                openBuilder: (context, action) => PlayerOpen(),
                //    transitionType: ContainerTransitionType.fadeThrough,
              ),
              hP.lastReadTextAyahs.isNotEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Recently Read Surahs',
                                  style: TextStyle(
                                    height: 2.2,
                                    fontSize: 20,
                                    // color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.separated(
                              itemCount: hP.lastReadTextAyahs.length,
                              separatorBuilder: ((context, index) {
                                return SizedBox(width: 10.0);
                              }),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) => EachQuranText(
                                            chapterNo: hP
                                                .lastReadTextSurahs[index]
                                                .number)),
                                      ),
                                    );
                                    await hP.generateLastReadValues();
                                  },
                                  child: LastReadSurah(
                                    surah: hP.lastReadTextSurahs[index],
                                    ayah: hP.lastReadTextAyahs[index],
                                  ),
                                );
                              }),
                        ),
                      ],
                    )
                  : SizedBox(),
              hP.lastRecitedSurahs.isNotEmpty
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Recently Recited Surahs',
                                  style: TextStyle(
                                    height: 2.2,
                                    fontSize: 20,
                                    // color: Colors.white,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Icon(Icons.arrow_forward)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                              itemCount: hP.lastRecitedSurahs.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return RecentlyRecitedSurah(
                                    name: hP.lastRecitedSurahs[index].name,
                                    description: hP.lastRecitedSurahs[index]
                                        .lastRecited!.currentTime,
                                    progress: (hP.lastRecitedSurahs[index]
                                                .currentDuration ??
                                            0) /
                                        (hP.lastRecitedSurahs[index]
                                                    .totalDuration ??
                                                1)
                                            .toDouble(),
                                    image: kSurahBackgrounds[Random()
                                        .nextInt(kSurahBackgrounds.length)]);
                              }),
                        ),
                      ],
                    )
                  : const SizedBox(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Explore',
                        style: TextStyle(
                          height: 2.2,
                          fontSize: 20,
                          //color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EachExploreTab(
                        index: 0,
                        iconData: Icons.book,
                        title: 'Full Quran',
                        description: 'Read Surahs',
                      ),
                      EachExploreTab(
                        index: 1,
                        iconData: Icons.headphones,
                        title: 'Audio Quran',
                        description: '139 Reciters',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EachExploreTab(
                        index: 2,
                        iconData: Icons.book_outlined,
                        title: 'Quran Translation',
                        description: 'Ayah By Ayah',
                      ),
                      EachExploreTab(
                        index: 3,
                        iconData: Icons.settings,
                        title: 'Settings',
                        description: '',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EachExploreTab(
                        index: 4,
                        iconData: Icons.book_outlined,
                        title: 'Bookmarks',
                        description: 'All you liked',
                      ),
                    ],
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class EachExploreTab extends ConsumerWidget {
  final IconData iconData;
  final int index;
  final String title;
  final String description;

  const EachExploreTab({
    Key? key,
    required this.index,
    required this.iconData,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              maximumSize: MaterialStateProperty.all(
                Size(
                  MediaQuery.of(context).size.width / 2 - 30,
                  70,
                ),
              ),
            ),
        onPressed: () async {
          switch (index) {
            case 0:
              await Navigator.pushNamed(context, QuranFull.id);

              break;
            case 1:
              await Navigator.pushNamed(context, QuranAudio.id);
              break;
            case 2:
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuranFull(
                    textSurah: false,
                  ),
                ),
              );
              break;
            case 3:
              await Navigator.pushNamed(context, SettingsScreen.id);
              break;
            case 4:
              await Navigator.pushNamed(context, BookmarkScreen.id);
              break;
            default:
              break;
          }
          ref.read(homeProvider).generateLastReadValues();
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2 - 40,
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                iconData,
                size: 30,
                color: Theme.of(context).iconTheme.color,
              ),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    description != ""
                        ? Text(
                            description,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )
                        : SizedBox(),
                  ])
            ],
          ),
        ),
      ),
    );
  }
}

class PrayerTimeBox extends StatelessWidget {
  final String time;
  final String name;
  final String image;
  const PrayerTimeBox({
    Key? key,
    required this.time,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 150,
        width: 70,
        child: Column(
          children: [
            Container(
              height: 100,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.yellow.withOpacity(0.2), BlendMode.darken),
                  image: CachedNetworkImageProvider(image),
                ),
              ),
              child: Center(
                child: Text(
                  '${time.split(' ')[0]}\n${time.split(' ')[1]}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                fontSize: 17,
                //height: 1.2,
                //color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecentlyRecitedSurah extends StatelessWidget {
  final String name;
  final String description;
  final String image;
  final double progress;
  const RecentlyRecitedSurah({
    Key? key,
    required this.description,
    required this.name,
    required this.image,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: 230,
        width: 100,
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          colorFilter: ColorFilter.mode(
                              Colors.yellow.withOpacity(0.2), BlendMode.darken),
                          image: CachedNetworkImageProvider(image))),
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        //height: 1.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                LinearProgressIndicator(
                  value: progress,
                  color: Colors.red,
                  backgroundColor: Colors.red.withOpacity(0.3),
                )
              ],
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: 10,
                //height: 1.2,
                //color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LastReadSurah extends StatelessWidget {
  final Surah surah;
  final Ayah ayah;
  const LastReadSurah({Key? key, required this.surah, required this.ayah})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: CachedNetworkImageProvider(kSurahBackgrounds[
                    Random().nextInt(kSurahBackgrounds.length)]),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: GlassMorphism(
                  start: 0.1,
                  end: 0.2,
                  color: Colors.green,
                  child: Container(
                    margin: const EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          'Read ${surah.lastRead!.currentTime}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        Column(
                          children: [
                            AutoSizeText(
                              '﴾${surah.name}﴿',
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            AutoSizeText(
                              '${surah.number} ${surah.englishName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            AutoSizeText(
                              "Read ${ayah.numberInSurah} of ${surah.numberOfAyahs} Ayahs",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
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
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            child: LinearProgressIndicator(
              value: ayah.numberInSurah / surah.numberOfAyahs,
              color: Colors.green,
              backgroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
