import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:isar/isar.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:http/http.dart';
import 'package:quran/main.dart';
import 'package:quran/models/jsonmodeltranslation.dart';
import 'package:quran/models/yearlyprayertiming.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

Duration initialDelay() {
  DateTime now = DateTime.now();
  DateTime tomorrow = now.add(const Duration(days: 1));
  DateTime morning = DateTime(
    tomorrow.year,
    tomorrow.month,
    tomorrow.day,
    7,
    50,
  );

  return morning.difference(now);
}

// @pragma(
//     'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void dailyAyahDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     FlutterLocalNotificationsPlugin pluging = FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ic_launcher');
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     pluging.initialize(
//       initializationSettings,
//     );
//     List<dynamic> response = await compute(getRandomAyah, true);
//     Ayah translation = response[1];
//     Surah surah = response[2];

//     pluging.show(
//         0,
//         '${surah.englishName} Ayah ${translation.numberInSurah}',
//         translation.text,
//         const NotificationDetails(
//             android: AndroidNotificationDetails(
//                 'eQuran Ayah Notifications', 'Ayah Notifications',
//                 channelDescription: 'Daily Ayah Notifications',
//                 styleInformation: BigTextStyleInformation(''),
//                 importance: Importance.max,
//                 priority: Priority.high)));
//     //simpleTask will be emitted here.
//     return true;
//   });
// }

// @pragma(
//     'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void oneTimeDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     FlutterLocalNotificationsPlugin pluging = FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('ic_launcher');
//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: initializationSettingsAndroid,
//     );
//     pluging.initialize(
//       initializationSettings,
//     );
//     List<dynamic> response = await compute(getRandomAyah, true);
//     Ayah translation = response[1];
//     Surah surah = response[2];

//     pluging.show(
//         0,
//         '${surah.englishName} Ayah ${translation.numberInSurah}',
//         translation.text,
//         const NotificationDetails(
//             android: AndroidNotificationDetails(
//                 'eQuran Ayah Notifications', 'Ayah Notifications',
//                 channelDescription: 'Daily Ayah Notifications',
//                 styleInformation: BigTextStyleInformation(''),
//                 importance: Importance.max,
//                 priority: Priority.high)));
//     //simpleTask will be emitted here.
//     return true;
//   });
// }

Future<List<List<Ayah>>> getTextAndTranslationAyahsBySurahNo(
    int surahNo) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );
  List<Ayah> surahTranslationText = isar.ayahs
      .filter()
      .chapterNoEqualTo(surahNo)
      .and()
      .languageEqualTo(isar.textTranslations
          .filter()
          .isSelectedEqualTo(true)
          .findFirstSync()!
          .identifier)
      .findAllSync();

  List<Ayah> surahText = isar.ayahs
      .filter()
      .chapterNoEqualTo(surahNo)
      .and()
      .languageEqualTo(kArabicText)
      .findAllSync();
  return [surahText, surahTranslationText];
}

Future<List<Ayah>> getTextBySurahNo(int surahNo) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  List<Ayah> surahText = await isar.ayahs
      .filter()
      .chapterNoEqualTo(surahNo)
      .and()
      .languageEqualTo(kArabicText)
      .findAll();
  return surahText;
}

Future<List<dynamic>> getRandomAyah(bool _) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  int randomNumber = Random().nextInt(6236);

  Ayah translation = isar.ayahs
      .filter()
      .numberEqualTo(randomNumber)
      .and()
      .languageEqualTo(isar.textTranslations
          .filter()
          .isSelectedEqualTo(true)
          .findFirstSync()!
          .identifier)
      .findFirstSync()!;
  Ayah arabic = isar.ayahs
      .filter()
      .numberEqualTo(randomNumber)
      .and()
      .languageEqualTo(kArabicText)
      .findFirstSync()!;

  Surah surah =
      isar.surahs.filter().numberEqualTo(arabic.chapterNo).findFirstSync()!;
  return [arabic, translation, surah];
}

Future<List<Surah>> getAllSurahs(bool value) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  return isar.surahs.where().sortByNumber().findAllSync();
}

Future<List<Surah>> getLastRecitedSurahs(bool value) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  return isar.surahs
      .filter()
      .lastRecitedIsNotNull()
      .sortByLastRecitedDesc()
      .findAllSync();
}

Future<List<Surah>> getBookmarkedSurahs(bool value) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  return isar.surahs.filter().bookmarkedEqualTo(true).findAllSync();
}

Future<List<Reciter>> getBookmarkedReciters(bool value) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  return isar.reciters.filter().bookmarkedEqualTo(true).findAllSync();
}

Future<List<TextTranslation>> getBookmarkedTextTranslations(bool value) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  return isar.textTranslations.filter().bookmarkedEqualTo(true).findAllSync();
}

Future<List<List<Ayah>>> getBookmarkedAyahs(bool value) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );
  List<Ayah> translationAyahs =
      isar.ayahs.filter().bookmarkedEqualTo(true).findAllSync();
  List<Ayah> arabicAyahs = [];
  for (Ayah ayah in translationAyahs) {
    Ayah foundAyah = isar.ayahs
        .filter()
        .languageEqualTo(kArabicText)
        .and()
        .numberEqualTo(ayah.number)
        .findFirstSync()!;

    arabicAyahs.add(foundAyah);
  }
  return [arabicAyahs, translationAyahs];
}

Future<List<dynamic>> getAyahByNumber(int number) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  Ayah translation = isar.ayahs
      .filter()
      .numberEqualTo(number)
      .and()
      .languageEqualTo(isar.textTranslations
          .filter()
          .isSelectedEqualTo(true)
          .findFirstSync()!
          .identifier)
      .findFirstSync()!;
  Ayah arabic = isar.ayahs
      .filter()
      .numberEqualTo(number)
      .and()
      .languageEqualTo(kArabicText)
      .findFirstSync()!;

  Surah surah =
      isar.surahs.filter().numberEqualTo(arabic.chapterNo).findFirstSync()!;
  return [arabic, translation, surah];
}

Future<List<List<Ayah>>> finAyahsByWord(String query) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  List<Ayah> foundAyahs =
      isar.ayahs.where().ayahWordsElementEqualTo(query).findAllSync();
  List<Ayah> arabicAyahs = [];
  for (Ayah ayah in foundAyahs) {
    Ayah foundAyah = isar.ayahs
        .filter()
        .languageEqualTo(kArabicText)
        .and()
        .numberEqualTo(ayah.number)
        .findFirstSync()!;

    arabicAyahs.add(foundAyah);
  }
  return [arabicAyahs, foundAyahs];
}

Future<List<List<Ayah>>> finAyahsBySentence(String query) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  List<Ayah> foundAyahs = isar.ayahs
      .filter()
      .textContains(query, caseSensitive: false)
      .findAllSync();
  List<Ayah> arabicAyahs = [];
  for (Ayah ayah in foundAyahs) {
    Ayah foundAyah = isar.ayahs
        .filter()
        .languageEqualTo(kArabicText)
        .and()
        .numberEqualTo(ayah.number)
        .findFirstSync()!;

    arabicAyahs.add(foundAyah);
  }
  return [arabicAyahs, foundAyahs];
}

Future<bool> downloadAyahTranslation(String identifier) async {
  try {
    Response response =
        await get(Uri.parse('http://api.alquran.cloud/v1/quran/$identifier'));
    if (response.statusCode == 200) {
      await addNewTranslation(response.body);
      return true;
    } else {
      return false;
    }
  } catch (e) {
    return false;
  }
}

Future<bool> addNewTranslation(String translation) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );

  final translationQuranTextJson = quranTextTranslationFromJson(translation);
  TextTranslation textTranslation = isar.textTranslations
      .filter()
      .identifierEqualTo(translationQuranTextJson!.data.edition.identifier)
      .findFirstSync()!;
  List<Ayah> newEnglishAyahs = [];
  List<SurahTranslation> translationsurahModels =
      translationQuranTextJson.data.surahs;
  for (SurahTranslation surah in translationsurahModels) {
    List<AyahTranslation> ayahs = surah.ayahs;
    for (AyahTranslation ayah in ayahs) {
      String? sajda;
      if (ayah.sajda.toString() != 'false') {
        if (ayah.sajda['recommended']) {
          sajda = 'Sajda Recommended';
        } else {
          sajda = 'Sajda Obligatory';
        }
      }
      newEnglishAyahs.add(Ayah(
          chapterNo: surah.number,
          language: translationQuranTextJson.data.edition.identifier,
          number: ayah.number,
          text: ayah.text,
          numberInSurah: ayah.numberInSurah,
          juz: ayah.juz,
          manzil: ayah.manzil,
          page: ayah.page,
          ruku: ayah.ruku,
          hizbQuarter: ayah.hizbQuarter,
          sajda: sajda,
          direction: textTranslation.direction));
    }
  }

  isar.writeTxnSync(() {
    isar.ayahs.putAllSync(
      newEnglishAyahs,
    );
  });

  return true;
}

Future<String?> getYearlyPrayerTimings(UserPrayerPreference userData) async {
  try {
    // UserPrayerPreference userData =
    //     UserPrayerPreference.fromJson(json.decode(userPrefernce));
    int year = DateTime.now().year;
    Response response = await get(Uri.parse(
        'https://api.aladhan.com/v1/calendarByCity?city=${userData.city}&country=${userData.country}&method=${userData.method}&annual=true&year=$year&iso8601=true&school=${userData.school}'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<String?> getUserIPInfo(bool _) async {
  try {
    Response response = await get(Uri.parse('http://ip-api.com/json'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<bool> updateSurah(Surah surah) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );
  //print(
  //  "SurahNameDuration: Inside ${surah.englishName} ${surah.totalDuration}");
  isar.writeTxnSync(() {
    isar.surahs.putSync(surah);
  });
  return true;
}

Future<bool> resetSurahsDurations(bool _) async {
  Isar isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    name: 'main',
    directory: '',
    inspector: false,
  );
  List<Surah> surahs = isar.surahs.where().findAllSync();
  for (Surah surah in surahs) {
    surah.currentDuration = 0;
    surah.totalDuration = 1;
  }
  isar.writeTxnSync(() {
    isar.surahs.putAllSync(surahs);
  });
  return true;
}

Future<int> generatePrayerNotifications(String prayerTimeData) async {
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();

  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('ic_launcher');
  // const InitializationSettings initializationSettings = InitializationSettings(
  //   android: initializationSettingsAndroid,
  // );
  // await flutterLocalNotificationsPlugin.initialize(
  //   initializationSettings,
  // );

  int currentId = 0;
  YearlyPrayerTiming yearlyPrayerTiming =
      YearlyPrayerTiming.fromJson(json.decode(prayerTimeData));
  tz.initializeTimeZones();
  tz.setLocalLocation(
      tz.getLocation(yearlyPrayerTiming.data.months[0][0].meta.timezone));

  for (Daily daily
      in yearlyPrayerTiming.data.months[DateTime.now().month - 1]) {
    for (Prayer prayer in daily.timings.prayers) {
      if (prayer.name != "Imsak" &&
          prayer.name != "Sunrise" &&
          prayer.name != "Sunset" &&
          prayer.name != "Midnight" &&
          prayer.name != "Firstthird" &&
          prayer.name != "Lastthird") {
        currentId = currentId + 1;
        DateTime prayerTime = DateTime.parse(prayer.time).toLocal();
        UC.flutterLocalNotificationsPlugin?.zonedSchedule(
          currentId,
          'Prayer Reminder',
          'It is time to offer ${prayer.name} prayer.',
          tz.TZDateTime(tz.local, prayerTime.year, prayerTime.month,
              prayerTime.day, prayerTime.hour, prayerTime.minute),
          const NotificationDetails(
            android: AndroidNotificationDetails(
                'eQuran Prayer Notifications', 'Prayer Notifications',
                channelDescription: 'Prayer Time Notifications',
                sound: RawResourceAndroidNotificationSound(
                    kAdhanNotificationSound),
                styleInformation: BigTextStyleInformation(''),
                importance: Importance.max,
                priority: Priority.high),
          ),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          matchDateTimeComponents: DateTimeComponents.dateAndTime,
        );
      }
    }
  }
  UC.hive.put(kAdhanNotificationSet, DateTime.now().month);
  return DateTime.now().month;
}
