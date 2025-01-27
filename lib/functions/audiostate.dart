// ignore_for_file: unused_catch_clause, empty_catches

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran/database/isarschema.dart';
import 'package:quran/functions/fastfunctions.dart';
import 'package:quran/main.dart';

final audioStateProvider = ChangeNotifierProvider((_) => AudioManager());

class AudioManager with ChangeNotifier {
  AudioPlayer player = AudioPlayer();
  String albumName = '';
  bool isReciting = false;
  Duration? currentDuration;
  Duration? totalDuration;
  RecitingType recitingType = RecitingType.ayah;
  int currentRecitingAyah = 0;
  Surah? currentRecitingSurah;
  String? currentRecitingAlbum;
  List<Surah> allSurahs = [];
  Future<Duration?> reciteAyah({required Ayah ayah}) async {
    try {
      recitingType = RecitingType.ayah;
      currentRecitingAyah = ayah.number;
      String link =
          "https://cdn.islamic.network/quran/audio/192/ar.abdulbasitmurattal/${ayah.number}.mp3";
      Duration? duration = await player.setAudioSource(
        LockCachingAudioSource(
          Uri.parse(link),
          cacheFile: File(
              '${UC.uv.appDirectoryPath}/ar.abdulbasitmurattal/${ayah.chapterNo}_${ayah.numberInSurah}'),
          tag: MediaItem(
            id: ayah.number.toString(),
            title: 'Verse ${ayah.numberInSurah + 1}',
            album: ayah.text,
          ),
        ),
      );
      if (duration != null) {
        player.play();

        return duration;
      } else {
        await player.play();

        return null;
      }
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web: a generic message
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
    } catch (e) {
      // Fallback for all errors
    }
    return null;
  }

  reciteSurah(List<AudioSource> chapters, Surah surah, String album,
      {bool startReciting = true}) async {
    try {
      recitingType = RecitingType.surah;
      player.setAudioSource(
        ConcatenatingAudioSource(
          // Start loading next item just before reaching it.
          useLazyPreparation: true, // default
          // Customise the shuffle algorithm.
          shuffleOrder: DefaultShuffleOrder(), // default
          // Specify the items in the playlist.
          children: chapters,
        ),
        preload: false,

        // Playback will be prepared to start from track1.mp3
        initialIndex: surah.number - 1, // default
        // Playback will be prepared to start from position zero.
        initialPosition:
            Duration(seconds: surah.currentDuration ?? 0), // default
      );
      currentRecitingAlbum = album;

      notifyListeners();

      startReciting ? player.play() : null;
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web: a generic message
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
    } catch (e) {
      // Fallback for all errors
    }
  }

  Future<Duration> reciteThisChapter(AudioSource audio) async {
    try {
      Duration? duration = await player.setAudioSource(
        audio,
      );
      player.play();
      return duration ?? Duration.zero;
    } on PlayerException catch (e) {
      // iOS/macOS: maps to NSError.code
      // Android: maps to ExoPlayerException.type
      // Web: maps to MediaError.code
      // iOS/macOS: maps to NSError.localizedDescription
      // Android: maps to ExoPlaybackException.getMessage()
      // Web: a generic message
      return Duration.zero;
    } on PlayerInterruptedException catch (e) {
      // This call was interrupted since another audio source was loaded or the
      // player was stopped or disposed before this audio source could complete
      // loading.
      return Duration.zero;
    } catch (e) {
      // Fallback for all errors
      return Duration.zero;
    }
  }

  initializeOldRecitingSurahsIfExist(Surah surah,
      {bool startReciting = false}) async {
    List<Surah> totalSurahs = allSurahs;
    if (totalSurahs.isEmpty) {
      allSurahs = await compute(getAllSurahs, true);
      totalSurahs = allSurahs;
    }
    Reciter selectedReciter = UC.uv.selectedReciter;
    String selectedTranslation = UC.uv.selectedAudioTranslation;
    AudioType currentAudioType = UC.uv.selectedAudioType;

    String? album;
    String reciterName = selectedReciter.name;

    String translationServer = selectedTranslation;
    String reciterUrl =
        'https://server${selectedReciter.serverNo}.mp3quran.net/${selectedReciter.identifier}/chapter.mp3';
    String translationUrl =
        'http://www.truemuslims.net/download.php?path=Quran/$translationServer/chapter.mp3';
    late String url;
    if (currentAudioType == AudioType.arabic) {
      url = reciterUrl;
      album = reciterName;
    } else {
      url = translationUrl;
      album = translationServer;
    }

    List<AudioSource> chapters = [];
    for (int i = 0; i < totalSurahs.length; i++) {
      int finalIndex = i + 1;
      String newIndex;

      if (finalIndex < 10) {
        newIndex = '00$finalIndex';
      } else if (finalIndex < 100 && finalIndex >= 10) {
        newIndex = '0$finalIndex';
      } else {
        newIndex = '$finalIndex';
      }

      chapters.add(LockCachingAudioSource(
        Uri.parse(url.replaceAll('chapter', newIndex)),
        cacheFile: File('${UC.uv.appDirectoryPath}/$album/$newIndex'),
        tag: MediaItem(
            // Specify a unique ID for each media item:
            id: '$i',
            // Metadata to display in the notification:
            album: album,
            title: totalSurahs[i].englishName,
            artist: album,
            extras: totalSurahs[i].toJson()),
      ));
    }

    reciteSurah(chapters, surah, album, startReciting: startReciting);
  }

  AudioManager() {
    currentRecitingSurah = UC.isar.surahs
        .filter()
        .lastRecitedIsNotNull()
        .sortByLastRecitedDesc()
        .findFirstSync();
    if (currentRecitingSurah != null) {
      currentDuration =
          Duration(seconds: currentRecitingSurah?.currentDuration ?? 0);
      totalDuration =
          Duration(seconds: currentRecitingSurah?.totalDuration ?? 1);
      initializeOldRecitingSurahsIfExist(
        currentRecitingSurah!,
      );
    }
    player.playbackEventStream.listen((playBack) async {
      int currentIndex = (playBack.currentIndex ?? -9) + 1;

      if (currentIndex == currentRecitingSurah?.number) {
        //print('CurrentIndexInfo $playBack');

        currentRecitingSurah?.lastRecited =
            DateTime.now().millisecondsSinceEpoch;
        await compute(updateSurah, currentRecitingSurah!);
      }
    });
    player.positionStream.listen((position) {
      currentDuration = position;
      notifyListeners();
      if (currentRecitingSurah != null && recitingType == RecitingType.surah) {
        Future.delayed(const Duration(seconds: 1)).then((value) {
          currentRecitingSurah?.currentDuration = position.inSeconds;
        });
      }
    }, onError: (e, s) {});
    player.durationStream.listen((duration) async {
      totalDuration = duration ?? const Duration(seconds: 1);
      notifyListeners();
      if (currentRecitingSurah != null && recitingType == RecitingType.surah) {
        await Future.delayed(const Duration(seconds: 1));
        currentRecitingSurah?.totalDuration = duration?.inSeconds ?? 1;
      }
    }, onError: (e, s) {});
    player.playerStateStream.listen((PlayerState state) {
      if (state.playing) {
        try {
          switch (state.processingState) {
            case ProcessingState.completed:
              if (recitingType == RecitingType.ayah) {
                player.stop();
                currentRecitingAyah = 0;
              } else {}
              break;

            case ProcessingState.buffering:
              break;
            default:
              break;
          }
        } catch (e) {}
      }
    });

    player.sequenceStateStream.listen((event) {
      if (event?.currentSource?.tag?.extras != null) {
        var extra = event!.currentSource!.tag.extras;

        currentRecitingSurah = Surah.fromJson(extra);
      }
      notifyListeners();
    });
    player.sequenceStream.listen((event) {});
    player.playingStream.listen((event) {
      isReciting = event;
      notifyListeners();
    });
  }
}

enum RecitingType { ayah, surah }

enum AudioType { arabic, translation }
