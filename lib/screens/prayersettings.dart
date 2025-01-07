import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quran/commonutils.dart';

import 'package:quran/constants.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';
import 'package:quran/models/yearlyprayertiming.dart';
import 'package:quran/screens/home.dart';

import 'package:quran/screens/settings.dart';
import 'package:quran/widgets/reuseablewidgets.dart';

Map<int, String> methods = {
  1: "University of Islamic Sciences, Karachi",
  2: "Islamic Society of North America",
  3: "Muslim World League",
  4: "Umm Al-Qura University, Makkah",
  5: "Egyptian General Authority of Survey",
  7: "Institute of Geophysics, University of Tehran",
  8: "Gulf Region",
  9: "Kuwait",
  10: "Qatar",
  11: "Majlis Ugama Islam Singapura, Singapore",
  12: "Union Organization islamic de France",
  13: "Diyanet İşleri Başkanlığı, Turkey",
  14: "Spiritual Administration of Muslims of Russia",
  15: "Moonsighting Committee Worldwide (also requires shafaq paramteer)",
};

Map<int, String> schools = {0: 'Shafi', 1: 'Hanafi'};

final prayerProvider =
    ChangeNotifierProvider.autoDispose(((ref) => PrayerController()));

class PrayerController with ChangeNotifier {
  PrayerController() {
    UserPrayerPreference userPrayerPreference = UserPrayerPreference.fromJson(
        json.decode(UC.hive.get(kUserPrayerPrefencees)));
    countryName = userPrayerPreference.country;
    method = userPrayerPreference.method;
    methodName = methods[method]!;

    oldMethod = userPrayerPreference.method;
    school = userPrayerPreference.school;
    schoolName = schools[school]!;
    oldSchool = userPrayerPreference.school;
    cityName = userPrayerPreference.city;
    oldCityName = userPrayerPreference.city;
    notificationsOn = UC.hive.get(kGetAdhanNotification, defaultValue: true);
    oldNotificationsOn = notificationsOn;
    notifyListeners();
  }
  bool notificationsOn = true;
  bool oldNotificationsOn = true;
  bool canChangeCity = false;
  int method = 3;
  int oldMethod = 3;
  String methodName = "Muslim World League";
  int school = 1;
  int oldSchool = 1;
  String schoolName = "Hanafi";
  String countryName = "";
  String cityName = "";
  String oldCityName = "";
  FocusNode focusNode = FocusNode();
  bool focus = false;
  bool settingsChanged = false;

  void notificationsOnOFF(bool _) {
    notificationsOn = !notificationsOn;
    ifSettingsChanged();
  }

  ifSettingsChanged() {
    if (oldMethod != method ||
        oldSchool != school ||
        oldCityName != cityName ||
        notificationsOn != oldNotificationsOn) {
      settingsChanged = true;
    } else {
      settingsChanged = false;
    }
    notifyListeners();
  }

  updateCanChangeCity() {
    canChangeCity = true;
    focus = true;
    focusNode.requestFocus();
    notifyListeners();
  }

  checkCity(String city) {
    cityName = city;
    canChangeCity = false;
    focus = false;
    focusNode.unfocus();
    ifSettingsChanged();
  }

  Future<bool> saveSettings(BuildContext context) async {
    if (notificationsOn) {
      UserPrayerPreference preference = UserPrayerPreference(
          country: countryName, city: cityName, method: method, school: school);
      showToast(
          context: context,
          content: const Text('Getting Prayer Times'),
          color: Colors.blue);
      String? newPrayerTimings =
          await compute(getYearlyPrayerTimings, preference);
      if (newPrayerTimings != null) {
        showToast(
            context: context,
            content: const Text('Settings Updated'),
            color: Colors.green);
        UC.hive.put(kYearlyPrayerTimings, newPrayerTimings);
        UC.hive.put(kUserPrayerPrefencees, json.encode(preference.toJson()));
        oldCityName = cityName;
        oldMethod = method;
        oldSchool = school;
        oldNotificationsOn = notificationsOn;
        ifSettingsChanged();

        generatePrayerNotifications(newPrayerTimings);
        return true;
      } else {
        showToast(
            context: context,
            content: Text(newPrayerTimings ?? 'Something went wrong'),
            color: Colors.red);
        return false;
      }
    } else {
      await UC.flutterLocalNotificationsPlugin?.cancelAll();
      notificationsOn = false;
      oldNotificationsOn = false;
      UC.hive.put(kGetAdhanNotification, false);
      ifSettingsChanged();
      return true;
    }
  }

  changeMethod(BuildContext context, String type) {
    String title = type;
    List<Widget> children = [];
    switch (type) {
      case "Method":
        children = methods.entries
            .map(
              (e) => CupertinoActionSheetAction(
                //isDefaultAction: true,
                onPressed: () {
                  method = e.key;
                  methodName = e.value;

                  ifSettingsChanged();
                  Navigator.pop(context);
                },
                child: Text(
                  e.value,
                  style: const TextStyle(
                    color: Color(0XFF29BB89),
                  ),
                ),
              ),
            )
            .toList();

        break;
      case "School":
        children = schools.entries
            .map(
              (e) => CupertinoActionSheetAction(
                //isDefaultAction: true,
                onPressed: () {
                  school = e.key;
                  schoolName = e.value;
                  ifSettingsChanged();

                  Navigator.pop(context);
                },
                child: Text(
                  e.value,
                  style: const TextStyle(
                    color: Color(0XFF29BB89),
                  ),
                ),
              ),
            )
            .toList();
        break;
      default:
    }

    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: Text(title),
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
        actions: children,
      ),
    );
  }
}

class PrayerSettingScreen extends ConsumerWidget {
  static const id = "prayerSettingScreen";
  PrayerSettingScreen({Key? key}) : super(key: key);
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pP = ref.watch(prayerProvider);
    return PopScope(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Theme.of(context).canvasColor,
            centerTitle: true,
            title: const Text('Prayer Settings'),
            //automaticallyImplyLeading: false, //true,
            foregroundColor: const Color(0XFF29BB89),
          ),
          body: Column(
            children: [
              EachSettingSwitchTab(
                  iconData: Icons.notifications_active,
                  onOff: pP.notificationsOnOFF,
                  title: 'Prayer Notifications',
                  value: pP.notificationsOn,
                  description:
                      "Prayer Notifications ${pP.notificationsOn ? 'ON' : 'OFF'}"),
              Visibility(
                visible: pP.notificationsOn,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.flag),
                      title: Text(pP.countryName),
                    ),
                    ListTile(
                      leading: const Icon(Icons.location_city),
                      title: CupertinoTextField(
                        focusNode: pP.focusNode,
                        autofocus: pP.focus,
                        prefixMode: OverlayVisibilityMode.notEditing,
                        prefix: Text(
                          pP.cityName.titleCase,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        readOnly: !pP.canChangeCity,
                        suffix: pP.canChangeCity
                            ? TextButton(
                                onPressed: () {
                                  pP.checkCity(
                                      textEditingController.value.text);
                                },
                                child: const Text('Save'))
                            : TextButton(
                                onPressed: () {
                                  pP.updateCanChangeCity();
                                },
                                child: const Text('Change City')),
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
                          pP.checkCity(value);
                          //sP.searchByNameOrNumber(value);
                        },
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    ListTile(
                      onTap: () {
                        pP.changeMethod(context, "Method");
                      },
                      leading: const Icon(Icons.calculate),
                      title: const Text('Method'),
                      subtitle: Text(pP.methodName),
                    ),
                    ListTile(
                      onTap: () {
                        pP.changeMethod(context, "School");
                      },
                      leading: const Icon(Icons.school),
                      title: const Text('School'),
                      subtitle: Text(pP.schoolName),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: pP.settingsChanged
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                        color: Colors.red,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel')),
                    CupertinoButton(
                        color: Colors.green,
                        onPressed: () async {
                          bool isChanged = await pP.saveSettings(context);
                          isChanged ? ref.refresh(homeProvider) : null;
                        },
                        child: const Text('Save'))
                  ],
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
