import 'package:isar/isar.dart';

part 'isarschema.g.dart';

@Collection()
class Ayah {
  Id id;

  String language;

  short number;

  String text;
  int numberInSurah;
  @Index(composite: [CompositeIndex('numberInSurah')])
  byte chapterNo;
  byte juz;
  byte manzil;
  short page;
  short ruku;
  short hizbQuarter;
  String direction;
  String? sajda;
  int? lastRead;
  bool? bookmarked;
  @Index(type: IndexType.value, caseSensitive: false)
  List<String> get ayahWords => text.split(' ');

  Ayah({
    this.id = Isar.autoIncrement,
    required this.chapterNo,
    required this.language,
    required this.number,
    required this.text,
    required this.direction,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    this.bookmarked,
    this.lastRead,
    this.sajda,
  });
}

@Collection()
class Surah {
  Id id;

  @Index()
  byte number;
  String name;
  String englishName;
  String englishNameTranslation;
  short numberOfAyahs;
  String revelationType;
  short? currentDuration;
  short? totalDuration;
  bool? isReciting;
  int? lastRecited;
  int? lastRead;
  bool? bookmarked;
  Surah({
    this.id = Isar.autoIncrement,
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
    this.isReciting,
    this.lastRecited,
    this.lastRead,
    this.bookmarked,
    this.currentDuration,
    this.totalDuration,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        bookmarked: json["bookmarked"],
        currentDuration: json["currentDuration"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        isReciting: json["isReciting"],
        lastRead: json["lastRead"],
        lastRecited: json["lastRecited"],
        name: json["name"],
        number: json["number"],
        numberOfAyahs: json["numberOfAyahs"],
        revelationType: json["revelationType"],
        totalDuration: json["totalDuration"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "bookmarked": bookmarked,
        "currentDuration": currentDuration,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "isReciting": isReciting,
        "lastRead": lastRead,
        "lastRecited": lastRecited,
        "name": name,
        "number": number,
        "numberOfAyahs": numberOfAyahs,
        "revelationType": revelationType,
        "totalDuration": totalDuration,
        "id": id
      };
}

@Collection()
class Reciter {
  Id id;
  String name;
  short serverNo;
  String identifier;
  bool isSelected;
  bool bookmarked;
  int? lastRecited;
  short listenCount = 0;

  Reciter({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.identifier,
    required this.serverNo,
    this.isSelected = false,
    this.lastRecited,
    this.bookmarked = false,
    this.listenCount = 0,
  });
}

@Collection()
class TextTranslation {
  Id id = Isar.autoIncrement;
  String name;
  String englishName;
  String identifier;
  String format;
  String type;
  String direction;
  String language;
  bool isDownloaded;
  bool isSelected;
  bool bookmarked;
  int? lastRead;

  TextTranslation({
    required this.name,
    required this.englishName,
    required this.identifier,
    required this.format,
    required this.type,
    required this.direction,
    required this.language,
    required this.isDownloaded,
    this.isSelected = false,
    this.lastRead,
    this.bookmarked = false,
  });
}
