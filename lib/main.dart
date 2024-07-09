import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:path_provider/path_provider.dart';

import 'package:quran/constants.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/audiostate.dart';
import 'package:quran/functions/initialization.dart';

import 'package:quran/screens/audioquran.dart';
import 'package:quran/screens/bookmark.dart';
import 'package:quran/screens/prayersettings.dart';
import 'package:quran/screens/startup.dart';
import 'package:quran/screens/surahlist.dart';
import 'package:quran/screens/home.dart';
import 'package:quran/screens/reciters.dart';
import 'package:quran/screens/settings.dart';
import 'package:quran/screens/audiotranslations.dart';
import 'package:quran/screens/texttranslations.dart';
import 'package:quran/widgets/reuseablewidgets.dart';

class UC {
  //static GetStorage gs = GetStorage();
  static late Box hive;
  static late Isar isar;
  static late ImageProvider quranjpg;
  static late UniversalVariables uv;
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
}

final controllerProvider = ChangeNotifierProvider((_) => Controller());

class Controller with ChangeNotifier {
  int appThemeMode = UC.hive.get(kAppThemeMode, defaultValue: 0);
  int initializedVersion = UC.hive.get(kInitializedVersion, defaultValue: 2);

  void updateAppTheme(int value) {
    appThemeMode = value;

    UC.hive.put(kAppThemeMode, value);
    notifyListeners();
  }
}

class UniversalVariables with ChangeNotifier {
  UniversalVariables() {
    initializeClass();
  }
  Reciter selectedReciter =
      UC.isar.reciters.filter().isSelectedEqualTo(true).findFirstSync()!;

  updateSelectedReciter(Reciter newSelectedReciter) {
    selectedReciter = newSelectedReciter;
  }

  TextTranslation selectedTextTranslation = UC.isar.textTranslations
      .filter()
      .isSelectedEqualTo(true)
      .findFirstSync()!;

  updateSelectedTextTranslation(TextTranslation newSelectedTextTranslation) {
    selectedTextTranslation = newSelectedTextTranslation;
  }

  String selectedAudioTranslation = UC.hive.get(kSelectedAudioTranslation,
      defaultValue: kDefaultSelectedAudioTranslation);

  updateSelectedAudioTranslation(String newSelectedAudioTranslation) {
    selectedAudioTranslation = newSelectedAudioTranslation;
    UC.hive.put(kSelectedAudioTranslation, newSelectedAudioTranslation);
  }

  double selectedArabicFontSize = UC.hive.get(kSelectedArabicFontSize,
      defaultValue: kDefaultArabicSelectedFontSize);

  updateSelectedArabicFontSize(double newSelectedFontSize) {
    selectedArabicFontSize = newSelectedFontSize;
    UC.hive.put(kSelectedArabicFontSize, newSelectedFontSize);
  }

  double selectedTranslationFontSize = UC.hive.get(kSelectedTranslationFontSize,
      defaultValue: kDefaultTranslationSelectedFontSize);

  updateSelectedTranslationFontSize(double newSelectedFontSize) {
    selectedTranslationFontSize = newSelectedFontSize;
    UC.hive.put(kSelectedTranslationFontSize, newSelectedFontSize);
  }

  AudioType selectedAudioType = UC.hive.get(kSelectedAudioType,
              defaultValue: kDefaultAudioType.toString()) ==
          AudioType.arabic.toString()
      ? kDefaultAudioType
      : AudioType.translation;
  late final Directory appDirectory;
  late final String appDirectoryPath;
  initializeClass() async {
    appDirectory = await getApplicationDocumentsDirectory();
    appDirectoryPath = appDirectory.path;
  }

  updateSelectedAudioType(AudioType newSelectedAudioType) {
    selectedAudioType = newSelectedAudioType;
    UC.hive.put(kSelectedAudioType, newSelectedAudioType.toString());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  UC.hive = await Hive.openBox(kHiveBox);
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.maqsoodahmadtech.quran.channel.audio',
    androidNotificationChannelName: 'Recitation',
    androidNotificationOngoing: true,
    notificationColor: const Color(0XFF29BB89),
  );
  UC.flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await UC.flutterLocalNotificationsPlugin?.initialize(
    initializationSettings,
  );
  final dir = await getApplicationSupportDirectory();
  UC.isar = await Isar.open(
    [AyahSchema, SurahSchema, ReciterSchema, TextTranslationSchema],
    directory: dir.path,
    name: 'main',
    inspector: false,
  );

  await Initialization.checkPrayers();
  if (UC.hive.get(kInitializedVersion) != null) {
    UC.uv = UniversalVariables();
  }
  runApp(const ProviderScope(child: Quran()));
}

class Quran extends ConsumerWidget {
  const Quran({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(controllerProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eQuran',
      themeMode: controller.appThemeMode == 0
          ? ThemeMode.system
          : controller.appThemeMode == 1
              ? ThemeMode.light
              : ThemeMode.dark,
      theme: ThemeData.light().copyWith(
          primaryColor: const Color(0XFF29BB89),
          useMaterial3: true,
          canvasColor: Colors.white,
          cardColor: Colors.white,
          // borderColor: Color(0XFF29BB89),
          // accentColor: Color(0XFF29BB89),
          // variantColor: Colors.black, //Color(0XFF289672),

          iconTheme: const IconThemeData(color: Color(0XFF29BB89), size: 20.0),
          // intensity: 10.0,
          // disableDepth: false,
          // baseColor: Color(0xFFFFFFFF), //Color(0XFFF2F2F2),
          // //lightSource: LightSource.topLeft,
          // depth: 10,
          // defaultTextColor: Color(0XFF29BB89),
          textTheme: const TextTheme(
            displayLarge: kCommonTextStyle,
            displayMedium: kCommonTextStyle,
            displaySmall: kCommonTextStyle,
            headlineLarge: kCommonTextStyle,
            headlineMedium: kCommonTextStyle,
            headlineSmall: kCommonTextStyle,
            titleLarge: kCommonTextStyle,
            titleMedium: kCommonTextStyle,
            titleSmall: kCommonTextStyle,
            bodyLarge: kCommonTextStyle,
            bodyMedium: kCommonTextStyle,
            bodySmall: kCommonTextStyle,
            labelLarge: kCommonTextStyle,
            labelMedium: kCommonTextStyle,
            labelSmall: kCommonTextStyle,
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            color: Color(0XFF29BB89), //Color(0XFFECF5F5), //Color(0XFF29BB89),
            elevation: 0.0,
            surfaceTintColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              surfaceTintColor: MaterialStateProperty.all(Colors.white),
              shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  );
                } else if (states.contains(MaterialState.hovered)) {
                  return const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  );
                }
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                );
              }),
              foregroundColor: MaterialStateProperty.all(
                Theme.of(context).primaryColor,
              ),
              elevation: MaterialStateProperty.resolveWith<double>(
                  (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) return 0.0;
                return 5.0;
              }),
            ),
          )),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        iconTheme: const IconThemeData(
          color: Colors.white, //Color(0XFF29BB89),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            surfaceTintColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                );
              } else if (states.contains(MaterialState.hovered)) {
                return const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                );
              }
              return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              );
            }),
            foregroundColor: MaterialStateProperty.all(
              Theme.of(context).canvasColor,
            ),
            backgroundColor: MaterialStateProperty.all(
              Colors.grey[850],
            ),
            elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) return 0.0;
              return 10.0;
            }),
          ),
        ),

        textTheme: const TextTheme(
          displayLarge: kCommonTextStyleDark,
          displayMedium: kCommonTextStyleDark,
          displaySmall: kCommonTextStyleDark,
          headlineLarge: kCommonTextStyleDark,
          headlineMedium: kCommonTextStyleDark,
          headlineSmall: kCommonTextStyleDark,
          titleLarge: kCommonTextStyleDark,
          titleMedium: kCommonTextStyleDark,
          titleSmall: kCommonTextStyleDark,
          bodyLarge: kCommonTextStyleDark,
          bodyMedium: kCommonTextStyleDark,
          bodySmall: kCommonTextStyleDark,
          labelLarge: kCommonTextStyleDark,
          labelMedium: kCommonTextStyleDark,
          labelSmall: kCommonTextStyleDark,
        ),
        // depth: 6,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Theme.of(context).primaryColor,
        ),
      ),
      initialRoute: controller.initializedVersion == kCurrentVersion
          ? Home.id
          : StartupScreen.id,
      routes: {
        Home.id: (context) => Home(),
        QuranFull.id: (context) => const QuranFull(),
        BookmarkScreen.id: (context) => BookmarkScreen(),
        AudioTranslationsScreen.id: (context) => AudioTranslationsScreen(),
        RecitersScreen.id: (context) => RecitersScreen(),
        QuranAudio.id: (context) => QuranAudio(),
        AyahTranslationsScreen.id: (context) => AyahTranslationsScreen(),
        SettingsScreen.id: (context) => const SettingsScreen(),
        PrayerSettingScreen.id: (context) => PrayerSettingScreen(),
        StartupScreen.id: (context) => const StartupScreen(),
      },
    );
  }
}

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  const BottomNavigation({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        switch (value) {
          case 0:
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => Home(),
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: const Duration(milliseconds: 1000),
              ),
            );

            break;
          case 1:
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (c, a1, a2) => BookmarkScreen(),
                transitionsBuilder: (c, anim, a2, child) =>
                    FadeTransition(opacity: anim, child: child),
                transitionDuration: const Duration(milliseconds: 1000),
              ),
            );

            break;
          default:
        }
      },
      elevation: 20,
      backgroundColor: Theme.of(context).primaryColor,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
          ),
          activeIcon: Icon(Icons.home_filled, color: Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.heart),
          activeIcon: Icon(CupertinoIcons.heart_fill, color: Colors.white),
          label: '',
        ),
      ],
    );
  }
}

class PlayerClose extends ConsumerWidget {
  String image =
      'https://cdn.pixabay.com/photo/2022/03/27/03/16/islamic-7093979_960_720.jpg';

  PlayerClose({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    final _ = ref.watch(audioQuranProvider);
    final audioState = ref.watch(audioStateProvider);
    return Container(
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        //color: Theme.of(context).primaryColor,

        image: DecorationImage(
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
              Colors.yellow.withOpacity(0.2), BlendMode.darken),
          image: CachedNetworkImageProvider(image),
        ),
        // gradient: const LinearGradient(
        //   colors: [
        //     Color(0XFF1E6F5C),
        //     Color(0XFF289672),
        //     Color(0XFF29BB89),
        //     Color(0XFFE6DD3B)
        //   ],
        // ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
              child: Container(
            margin: const EdgeInsets.only(
              top: 5.0,
            ),
            width: 50.0,
            height: 5.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: Builder(builder: (context) {
                  // String? chapterNameAr = '';
                  // String? album = '';
                  // String? reciterName = '';
                  // String translationName = '';
                  // if (_.totalChapters!.isNotEmpty) {
                  //   chapterNameAr =
                  //       _.totalChapters![_.currentReciting].englishName;
                  //   reciterName = _.listofReciters[_.selectedReciter].name;
                  //   translationName =
                  //       _.listofTranslations[_.selectedTranslation].name;
                  //   if (_.currentAudioType == 0) {
                  //     album = reciterName;
                  //   } else {
                  //     album = translationName;
                  //   }
                  // }
                  return ListTile(
                    title: Text(
                      '${audioState.currentRecitingSurah?.number ?? ''} ${audioState.currentRecitingSurah?.englishName ?? ''}',
                      //audioState.chapterName,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white),
                    ),
                    subtitle: Text(
                      audioState.currentRecitingAlbum ??
                          'Start listening...', // audioState.albumName,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: Colors.white),
                    ),
                  );
                }),
              ),
              Builder(builder: (context) {
                IconData iconData = CupertinoIcons.play;
                AudioPlayer player = audioState.player;

                if (player.playing) {
                  iconData = CupertinoIcons.pause;
                }

                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        player.hasPrevious ? player.seekToPrevious() : null;
                      },
                      child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: Stack(
                              children: [
                                const Positioned(
                                  child: Card(
                                    shape: CircleBorder(),
                                  ),
                                ),
                                Positioned(
                                  left: 5.0,
                                  top: 5.0,
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: Card(
                                      shape: const CircleBorder(),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.back,
                                          size: 25.0,
                                          color: player.hasPrevious
                                              ? Theme.of(context).primaryColor
                                              : Colors
                                                  .grey, //Theme.of(context).textTheme.button.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (player.playing) {
                            player.pause();
                            //_.playing.toggle();
                            //_.update();
                          } else {
                            try {
                              await player.load();
                              await player.play();

                              //_.update();
                            } on PlayerException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: const [
                                      Icon(
                                        CupertinoIcons.wifi_slash,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Oops! Internet is required for first time.',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } on PlayerInterruptedException catch (e) {
                              // This call was interrupted since another audio source was loaded or the
                              // player was stopped or disposed before this audio source could complete
                              // loading.
                            } catch (e) {
                              Navigator.pushNamed(context, QuranAudio.id);
                            }

                            //_.playing.toggle();
                          }
                        },
                        child: SizedBox(
                          width: 80.0,
                          height: 80.0,
                          child: Stack(
                            children: [
                              const Positioned(
                                child: Card(
                                  shape: CircleBorder(),
                                ),
                              ),
                              Positioned(
                                left: 8.0,
                                top: 8.0,
                                child: SizedBox(
                                  width: 65.0,
                                  height: 65.0,
                                  child: Card(
                                    shape: const CircleBorder(),
                                    child: Center(
                                      child: Icon(
                                        iconData,
                                        size: 30.0,
                                        color: Theme.of(context)
                                            .primaryColor, //Theme.of(context).textTheme.button.color,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            player.hasNext ? player.seekToNext() : null;
                          },
                          child: SizedBox(
                            width: 60.0,
                            height: 60.0,
                            child: Stack(
                              children: [
                                const Positioned(
                                  child: Card(
                                    shape: CircleBorder(),
                                  ),
                                ),
                                Positioned(
                                  left: 5.0,
                                  top: 5.0,
                                  child: SizedBox(
                                    width: 50.0,
                                    height: 50.0,
                                    child: Card(
                                      shape: const CircleBorder(),
                                      child: Center(
                                        child: Icon(
                                          CupertinoIcons.forward,
                                          size: 25.0,
                                          color: player.hasNext
                                              ? Theme.of(context).primaryColor
                                              : Colors
                                                  .grey, //Theme.of(context).textTheme.button.color,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ],
                );
              }),
            ],
          ),
          LinearProgressIndicator(
            value: (audioState.currentDuration?.inSeconds ?? 0) /
                (audioState.totalDuration?.inSeconds ?? 1),
            color: Colors.red,
            backgroundColor: Colors.red.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

class PlayerOpen extends ConsumerWidget {
  //AudioPlayer player = SP.audioManager.player;

  String image =
      'https://cdn.pixabay.com/photo/2022/03/27/03/16/islamic-7093979_960_720.jpg'; //kBeautifulBackgrounds[Random().nextInt(kBeautifulBackgrounds.length)];

  @override
  Widget build(BuildContext context, ref) {
    final _ = ref.watch(audioQuranProvider);
    final audioState = ref.watch(audioStateProvider);
    AudioPlayer player = audioState.player;
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [
            0.1,
            0.4,
            0.6,
            // 1.5,
          ],
          colors: [
            Color(0XFF1E6F5C),
            Color(0XFF289672),
            Color(0XFF29BB89),
            // Color(0XFFE6DD3B)
          ],
        ),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: CachedNetworkImageProvider(image),
        ),
      ),
      child: GlassMorphism(
        start: 0.2,
        end: 0.8,
        color: Colors.green,
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Center(
                        child: Icon(
                          CupertinoIcons.down_arrow,
                          color: Colors.white,
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  const Flexible(
                    flex: 4,
                    child: Text(
                      'Now Reciting',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 4,
              child: Builder(builder: (context) {
                return Column(
                  children: [
                    Flexible(
                      flex: 4,
                      child: FractionallySizedBox(
                        widthFactor: 0.7,
                        child: Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width - 100,
                            height: MediaQuery.of(context).size.height - 100,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: CachedNetworkImageProvider(image),
                                ),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(20.0),
                                child: CircleGlassMorphism(
                                  start: 0.2,
                                  end: 0.7,
                                  color: Colors.black,
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${audioState.currentRecitingSurah?.number ?? ''} ${audioState.currentRecitingSurah?.englishName ?? 'Start...'}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium
                                              ?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                        Text(
                                          'Surah No. ${audioState.currentRecitingSurah?.number ?? ''}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                        Text(
                                          'Ayahs. ${audioState.currentRecitingSurah?.numberOfAyahs ?? ''}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                        Text(
                                          '${audioState.currentRecitingSurah?.revelationType ?? ''}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            audioState.currentRecitingAlbum ?? '',
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
            Flexible(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        audioState.currentDuration?.durationText ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Text(
                        audioState.totalDuration?.durationText ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    min: 0,
                    max: audioState.totalDuration?.inSeconds.toDouble() ?? 1.0,
                    value:
                        audioState.currentDuration?.inSeconds.toDouble() ?? 0.0,
                    onChanged: (value) {
                      audioState.player.seek(Duration(seconds: value.toInt()));
                    },
                    activeColor: Theme.of(context).primaryColor,
                    inactiveColor: Colors.white,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  player.seekToPrevious();
                                },
                                child: SizedBox(
                                  width: 60.0,
                                  height: 60.0,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        child: Card(
                                          color: Theme.of(context).primaryColor,
                                          shape: const CircleBorder(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 5.0,
                                        top: 5.0,
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: Card(
                                            shape: const CircleBorder(),
                                            child: Center(
                                              child: Icon(
                                                CupertinoIcons.back,
                                                size: 25.0,
                                                color: player.hasPrevious
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors
                                                        .grey, //Theme.of(context).textTheme.button.color,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 8.0,
                            ),
                            child: InkWell(
                              onTap: () {
                                if (player.playing) {
                                  player.pause();
                                  // _.playing.toggle();
                                  //_.update();
                                } else {
                                  try {
                                    player.play();
                                  } catch (e) {
                                    Navigator.pop(context);
                                  }
                                  //_.playing.toggle();
                                  //_.update();
                                }
                              },
                              child: SizedBox(
                                width: 80.0,
                                height: 80.0,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      child: Card(
                                        color: Theme.of(context).primaryColor,
                                        shape: const CircleBorder(),
                                      ),
                                    ),
                                    Positioned(
                                      left: 8.0,
                                      top: 8.0,
                                      child: SizedBox(
                                        width: 65.0,
                                        height: 65.0,
                                        child: Card(
                                          shape: const CircleBorder(),
                                          child: Center(
                                            child: Icon(
                                              player.playing
                                                  ? CupertinoIcons.pause
                                                  : CupertinoIcons.play,
                                              size: 30.0,
                                              color: Theme.of(context)
                                                  .primaryColor, //Theme.of(context).textTheme.button.color,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  player.hasNext
                                      ? player.seekToNext()
                                      : print('end of list');
                                },
                                child: SizedBox(
                                  width: 60.0,
                                  height: 60.0,
                                  child: Stack(
                                    children: [
                                      const Positioned(
                                        child: Card(
                                          shape: CircleBorder(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 5.0,
                                        top: 5.0,
                                        child: SizedBox(
                                          width: 50.0,
                                          height: 50.0,
                                          child: Card(
                                            shape: const CircleBorder(),
                                            child: Center(
                                              child: Icon(
                                                CupertinoIcons.forward,
                                                size: 25.0,
                                                color: player.hasNext
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : Colors
                                                        .grey, //Theme.of(context).textTheme.button.color,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}

///Write extension to convert Duration into readable text//
///
extension DurationIntoTexts on Duration {
  String get durationText {
    final int hours = inHours;
    final int minutes = inMinutes - hours * 60;
    final int seconds = inSeconds - hours * 60 * 60 - minutes * 60;
    return '$hours:$minutes:$seconds';
  }
}

///Write extension to convert Duration into readable text//
extension DurationIntoText on Duration {
  String get durationTexts {
    final int hours = inHours;
    final int minutes = inMinutes - hours * 60;
    final int seconds = inSeconds - hours * 60 * 60 - minutes * 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
