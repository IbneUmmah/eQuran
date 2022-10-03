import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:quran/assets/quranar.dart';
import 'package:quran/assets/quranEn.dart';
import 'package:quran/assets/quranmetas.dart';
import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';
import 'package:quran/models/chaptermodels.dart' hide RevelationType;
import 'package:quran/models/jsonmodeltranslation.dart';
import 'package:quran/models/qurantextformat.dart';
import 'package:quran/models/yearlyprayertiming.dart';
import 'package:quran/reciters/reciters.dart';
import 'package:quran/assets/quranformat.dart' as qurandata;

class Initialization {
  static checkPrayers() async {
    int? currentVersion = UC.hive.get(kInitializedVersion);

    if (currentVersion == null) {
      return;
    }

    if (UC.hive.get(kGetAdhanNotification, defaultValue: true) == false) {
      return;
    }

    DateTime dt = DateTime.now();
    if (UC.hive.get(kAdhanNotificationSet) != dt.month) {
      String userPreference = UC.hive.get(kUserPrayerPrefencees);
      UserPrayerPreference userPrayerPreference =
          UserPrayerPreference.fromJson(json.decode(userPreference));
      String? yearlyPrayerTimings = UC.hive.get(kYearlyPrayerTimings);
      if (yearlyPrayerTimings == null) {
        yearlyPrayerTimings ??=
            await compute(getYearlyPrayerTimings, userPrayerPreference);
        UC.hive.put(kYearlyPrayerTimings, yearlyPrayerTimings);
      }
      if (yearlyPrayerTimings != null &&
          YearlyPrayerTiming.fromJson(json.decode(yearlyPrayerTimings))
                  .data
                  .months
                  .first
                  .first
                  .date
                  .gregorian
                  .year !=
              dt.year.toString()) {
        String? yearlyPrayerTimings =
            await compute(getYearlyPrayerTimings, userPrayerPreference);
        UC.hive.put(kYearlyPrayerTimings, yearlyPrayerTimings);
        if (yearlyPrayerTimings != null) {
          generatePrayerNotifications(yearlyPrayerTimings);
        }
      } else if (yearlyPrayerTimings != null) {
        generatePrayerNotifications(yearlyPrayerTimings);
      }
    }
  }

  initialized() async {
    int currentVersion = UC.hive.get(kInitializedVersion, defaultValue: 2);

    if (currentVersion == kCurrentVersion) {
      return;
    }
    await compute(initializeAyahs, true);
    await compute(initializeReciters, true);
    await compute(initializeTextTranslations, true);
    String? location = await compute(getUserIPInfo, true);
    if (location != null) {
      LocationApi locationApi = locationApiFromJson(location);
      UserPrayerPreference userPrayerPreference = UserPrayerPreference(
          country: locationApi.country, city: locationApi.city);
      String userPrefString = json.encode(userPrayerPreference.toJson());
      UC.hive.put(kUserPrayerPrefencees, userPrefString);

      String? yearlyPrayerTimings =
          await compute(getYearlyPrayerTimings, userPrayerPreference);

      UC.hive.put(kYearlyPrayerTimings, yearlyPrayerTimings);
    }
    UC.hive.put(
      kInitializedVersion,
      kCurrentVersion,
    );

    // Workmanager().initialize(
    //   dailyAyahDispatcher, // The top level function, aka callbackDispatcher
    // );
    // // //Workmanager().registerOneOffTask("task-identifier", "simpleTask");
    // final DateTime now = DateTime.now();
    // final DateTime tomorrow = now.add(const Duration(days: 1));
    // final DateTime morning = DateTime(
    //   tomorrow.year,
    //   tomorrow.month,
    //   tomorrow.day,
    //   7,
    //   50,
    // );
    // Duration delay = morning.difference(now);
    // Workmanager().registerPeriodicTask(
    //   kDailyAyahNotification, "dailyAyahReminder",
    //   frequency: const Duration(minutes: 15),
    //   existingWorkPolicy: ExistingWorkPolicy.append,
    //   //initialDelay: delay, //initialDelay(),
    // );
  }

  Future<bool> initializeReciters(bool _) async {
    List<Reciters> totalReciters = Reciters.listofReciters;

    List<Reciter> isarReciters = [];
    for (Reciters reciter in totalReciters) {
      isarReciters.add(Reciter(
        name: reciter.name,
        identifier: reciter.server.split(":")[1],
        serverNo: int.parse(reciter.server.split(":")[0]),
      ));
    }
    isarReciters.first.isSelected = true;
    Isar isar = await Isar.open(
      [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
      name: 'main',
      directory: '',
      inspector: false,
    );
    isar.writeTxnSync(() {
      isar.reciters.putAllSync(isarReciters);
    });
    return _;
  }

  Future<bool> initializeTextTranslations(bool _) async {
    QuranFormat quranFormat = quranFormatFromJson(qurandata.quranFormat);
    quranFormat.data!.sort((a, b) => a.identifier!.compareTo(b.identifier!));
    List<EachTranslation> totalTranslations = quranFormat.data!;

    List<TextTranslation> isarTranslations = [];
    for (EachTranslation translation in totalTranslations) {
      bool isDownloaded = false;
      bool isSelected = false;
      if (translation.identifier == kEnglishText) {
        isDownloaded = true;
        isSelected = true;
      }
      isarTranslations.add(
        TextTranslation(
          name: translation.name!,
          englishName: translation.englishName!,
          identifier: translation.identifier!,
          format:
              translation.format!.toString().split('Format.')[1].toLowerCase(),
          type: translation.type!.toString().split('Type.')[1].toLowerCase(),
          direction: translation.direction!
              .toString()
              .split('Direction.')[1]
              .toLowerCase(),
          language: translation.language!,
          isDownloaded: isDownloaded,
          isSelected: isSelected,
        ),
      );
    }
    Isar isar = await Isar.open(
      [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
      name: 'main',
      directory: '',
      inspector: false,
    );
    isar.writeTxnSync(() {
      isar.textTranslations.putAllSync(
        isarTranslations,
      );
    });
    return _;
  }

  Future<bool> initializeAyahs(bool _) async {
    QuranMeta meta = quranMetaFromJson(quranMetas);
    List<SurahsReference> surahs = meta.data!.surahs!.references!;
    List<Surah> newSurahs = [];
    List<Ayah> newAyahs = [];
    List<Ayah> newEnglishAyahs = [];
    for (SurahsReference surah in surahs) {
      newSurahs.add(Surah(
        number: surah.number,
        name: surah.name,
        englishName: surah.englishName,
        englishNameTranslation: surah.englishNameTranslation,
        numberOfAyahs: surah.numberOfAyahs,
        revelationType: surah.revelationType == RevelationType.MECCAN
            ? "Meccan"
            : "Medinan",
      ));
    }

    final arabicQuranTextJson = quranTextTranslationFromJson(quranAr);

    List<SurahTranslation> arabicsurahModels = arabicQuranTextJson!.data.surahs;
    for (SurahTranslation surah in arabicsurahModels) {
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
        newAyahs.add(Ayah(
            chapterNo: surah.number,
            language: arabicQuranTextJson.data.edition.identifier,
            number: ayah.number,
            text: ayah.text,
            numberInSurah: ayah.numberInSurah,
            juz: ayah.juz,
            manzil: ayah.manzil,
            page: ayah.page,
            ruku: ayah.ruku,
            hizbQuarter: ayah.hizbQuarter,
            sajda: sajda,
            direction: 'rtl'));
      }
    }
    final translationQuranTextJson = quranTextTranslationFromJson(quranEnn);

    List<SurahTranslation> translationsurahModels =
        translationQuranTextJson!.data.surahs;
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
            direction: 'ltr'));
      }
    }

    Isar isar = await Isar.open(
      [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
      name: 'main',
      directory: '',
      inspector: false,
    );
    isar.writeTxnSync(() {
      isar.surahs.putAllSync(
        newSurahs,
      );
      isar.ayahs.putAllSync(newAyahs);
      isar.ayahs.putAllSync(newEnglishAyahs);
    });
    return _;
  }
}
