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
import 'package:workmanager/workmanager.dart';

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

  updateAyahNotifications(bool value) async {
    getAyahNotifications = value;
    notifyListeners();

    if (value) {
      await Workmanager().initialize(
        dailyAyahDispatcher, // The top level function, aka callbackDispatcher
      );

      await Workmanager().registerPeriodicTask(
        kDailyAyahNotification,
        "dailyAyahReminder",
        frequency: const Duration(hours: 24),
        initialDelay: initialDelay(),
      );
      UC.hive.put(kGetDailyAyahNotification, true);
      UC.hive.put('workManagerActivated', true);
    } else {
      await Workmanager().cancelByUniqueName(kDailyAyahNotification);
      UC.hive.put(kGetDailyAyahNotification, false);
      UC.hive.put('workManagerActivated', false);
    }
  }

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
          body: SingleChildScrollView(
            child: Column(
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
                ListTile(
                  leading: Icon(Icons.notifications_active),
                  title: Text('Daily Ayah Notifications'),
                  subtitle: Text(
                      'Get a daily notification of a random verse from the Quran'),
                  trailing: CupertinoSwitch(
                    value: sP.getAyahNotifications,
                    onChanged: sP.updateAyahNotifications,
                  ),
                ),
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
                Card(
                  color: Theme.of(context).canvasColor,
                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      Text(
                        'Font Size',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          '﴿بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ﴾',
                          style: TextStyle(
                            fontSize: sP.arabicFontSize,
                            fontFamily: "ScheherazadeNew-Bold",
                          ),
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "In the name of God, the Most Gracious, the Most Merciful.",
                          style: TextStyle(
                            fontSize: sP.translationFontSize,
                            fontFamily: "NotoNastaliqUrdu-Regular",
                          ),
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.ltr,
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Arabic ${sP.arabicFontSize}px',
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
                        divisions: 12,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Translation ${sP.translationFontSize}px',
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
                        divisions: 12,
                      ),
                    ]),
                  ),
                ),
              ],
            ),
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
              maximumSize: WidgetStateProperty.all(
                Size(
                  MediaQuery.of(context).size.width,
                  70,
                ),
              ),
              elevation: WidgetStateProperty.resolveWith<double>(
                  (Set<WidgetState> states) {
                if (states.contains(WidgetState.pressed)) return 0.0;
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
