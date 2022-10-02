// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/constants.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';
import 'package:quran/screens/prayersettings.dart';
import 'package:quran/screens/reciters.dart';
import 'package:quran/screens/audiotranslations.dart';
import 'dart:math' as math;

import 'package:quran/screens/texttranslations.dart';

final settingsProvider =
    ChangeNotifierProvider.autoDispose(((ref) => SettingsController()));

class SettingsController with ChangeNotifier {
  double arabicFontSize = UC.uv.selectedArabicFontSize;
  double translationFontSize = UC.uv.selectedTranslationFontSize;
  bool getAdhanNotifications =
      UC.hive.get(kGetAdhanNotification, defaultValue: true);
  bool getAyahNotifications =
      UC.hive.get(kGetDailyAyahNotification, defaultValue: true);

  updateAdhanNotifications(bool value) {
    getAdhanNotifications = value;
    UC.hive.put(kGetAdhanNotification, value);

    notifyListeners();
    if (value) {
      generatePrayerNotifications(UC.hive.get(kYearlyPrayerTimings));
    } else {
      UC.flutterLocalNotificationsPlugin?.cancelAll();
    }
  }

  // updateAyahNotifications(bool value) {
  //   getAyahNotifications = value;
  //   UC.hive.put(kGetDailyAyahNotification, value);
  //   notifyListeners();

  //   if (value) {
  //     // Workmanager().initialize(
  //     //   dailyAyahDispatcher, // The top level function, aka callbackDispatcher
  //     // );
  //     // //Workmanager().registerOneOffTask("task-identifier", "simpleTask");
  //     // Workmanager().registerPeriodicTask(
  //     //   kDailyAyahNotification,
  //     //   "dailyAyahReminder",
  //     //   frequency: const Duration(hours: 24),
  //     //   initialDelay: initialDelay(),
  //     // );
  //     // Workmanager().initialize(
  //     //   oneTimeDispatcher,
  //     //   isInDebugMode: true,
  //     //   // The top level function, aka callbackDispatcher
  //     // );
  //     // Workmanager().registerOneOffTask("test", "simpleTask");
  //   } else {
  //     Workmanager().cancelByUniqueName(kDailyAyahNotification);
  //   }
  // }

  updateArabicFontSize(double newFontSize) {
    newFontSize = newFontSize.floorToDouble();
    arabicFontSize = newFontSize;
    UC.uv.updateSelectedArabicFontSize(newFontSize);
    notifyListeners();
  }

  updateTranslationFontSize(double newFontSize) {
    newFontSize = newFontSize.floorToDouble();
    translationFontSize = newFontSize;
    UC.uv.updateSelectedTranslationFontSize(newFontSize);
    notifyListeners();
  }
}

class SettingsScreen extends ConsumerWidget {
  static const String id = 'settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final sP = ref.watch(settingsProvider);
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).canvasColor,
            centerTitle: true,
            title: Text('Settings'),
            //automaticallyImplyLeading: false, //true,
            foregroundColor: const Color(0XFF29BB89),
          ),
          body: Column(
            children: [
              InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, PrayerSettingScreen.id);
                },
                child: EachSettingTab(
                  title: 'Prayer Settings',
                  description: 'Change Location/Methods',
                  iconData: Icons.headphones,
                ),
              ),
              // EachSettingSwitchTab(
              //     iconData: CupertinoIcons.speaker_zzz,
              //     onOff: sP.updateAyahNotifications,
              //     value: sP.getAyahNotifications,
              //     title: 'Daily Ayah Notifications',
              //     description: "New Ayah every day"),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RecitersScreen.id);
                },
                child: EachSettingTab(
                  title: 'Change Reciters',
                  description: '139 Reciters Available',
                  iconData: Icons.person,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AudioTranslationsScreen.id);
                },
                child: EachSettingTab(
                  title: 'Change Audio Translations',
                  description: '39 Translations Available',
                  iconData: Icons.headphones,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, AyahTranslationsScreen.id);
                },
                child: EachSettingTab(
                  title: 'Change Verse Translations',
                  description: '114 Translations Available',
                  iconData: Icons.abc,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Change Arabic Font Size  ${sP.arabicFontSize}px',
                  style: TextStyle(
                    height: 2.2,
                    fontSize: 20,
                    // color: Colors.white,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Slider(
                value: sP.arabicFontSize,
                onChanged: sP.updateArabicFontSize,
                min: 10.0,
                max: 50.0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Change Translatio Font Size  ${sP.translationFontSize}px',
                  style: TextStyle(
                    height: 2.2,
                    fontSize: 20,
                    // color: Colors.white,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              Slider(
                value: sP.translationFontSize,
                onChanged: sP.updateTranslationFontSize,
                min: 10.0,
                max: 50.0,
              ),
            ],
          )),
    );
  }
}

class EachSettingTab extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String description;

  const EachSettingTab({
    Key? key,
    required this.iconData,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: ListTile(
            leading: Icon(
              iconData,
              size: 30,
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0), //Teme.of(context).iconTheme.color,
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            subtitle: description != ""
                ? Text(
                    description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : SizedBox(),
          )),
    );
  }
}

class EachSettingSwitchTab extends StatelessWidget {
  final IconData iconData;
  final String title;
  final String description;
  final bool value;
  final Function onOff;

  const EachSettingSwitchTab({
    Key? key,
    required this.iconData,
    required this.onOff,
    required this.title,
    required this.description,
    this.value = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: ElevatedButton(
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
              maximumSize: MaterialStateProperty.all(
                Size(
                  MediaQuery.of(context).size.width,
                  70,
                ),
              ),
              elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return 0.0;
                return 1.0;
              }),
            ),
        onPressed: () {},
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: ListTile(
              leading: Icon(
                iconData,
                size: 30,
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0), //Theme.of(context).iconTheme.color,
              ),
              title: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              subtitle: description != ""
                  ? Text(
                      description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                  : SizedBox(),
              trailing: CupertinoSwitch(
                value: value,
                onChanged: onOff as void Function(bool),
              ),
            )),
      ),
    );
  }
}
