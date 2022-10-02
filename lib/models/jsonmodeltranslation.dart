// To parse this JSON data, do
//
//     final quranTextTranslation = quranTextTranslationFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

QuranTextTranslation? quranTextTranslationFromJson(String str) {
  try {
    dynamic data = json.decode(str);

    return QuranTextTranslation.fromJson(data);
  } catch (e) {
    return null;
  }
}

String quranTextTranslationToJson(QuranTextTranslation data) =>
    json.encode(data.toJson());

class QuranTextTranslation {
  QuranTextTranslation({
    required this.code,
    required this.status,
    required this.data,
  });

  int code;
  String status;
  Data data;

  factory QuranTextTranslation.fromJson(Map<String, dynamic> json) =>
      QuranTextTranslation(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.surahs,
    required this.edition,
  });

  List<SurahTranslation> surahs;
  Edition edition;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surahs: List<SurahTranslation>.from(
            json["surahs"].map((x) => SurahTranslation.fromJson(x))),
        edition: Edition.fromJson(json["edition"]),
      );

  Map<String, dynamic> toJson() => {
        "surahs": List<dynamic>.from(surahs.map((x) => x.toJson())),
        "edition": edition.toJson(),
      };
}

class Edition {
  Edition({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
  });

  String identifier;
  String language;
  String name;
  String englishName;
  String format;
  String type;

  factory Edition.fromJson(Map<String, dynamic> json) => Edition(
        identifier: json["identifier"],
        language: json["language"],
        name: json["name"],
        englishName: json["englishName"],
        format: json["format"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "language": language,
        "name": name,
        "englishName": englishName,
        "format": format,
        "type": type,
      };
}

class SurahTranslation {
  SurahTranslation({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    this.revelationType,
    required this.ayahs,
  });

  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  RevelationType? revelationType;
  List<AyahTranslation> ayahs;

  factory SurahTranslation.fromJson(Map<String, dynamic> json) =>
      SurahTranslation(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        revelationType: revelationTypeValues.map[json["revelationType"]],
        ayahs: List<AyahTranslation>.from(
            json["ayahs"].map((x) => AyahTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "revelationType": revelationTypeValues.reverse![revelationType],
        "ayahs": List<dynamic>.from(ayahs.map((x) => x.toJson())),
      };
}

class AyahTranslation {
  AyahTranslation({
    required this.number,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
    this.sajda,
  });

  int number;
  String text;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  dynamic sajda;

  factory AyahTranslation.fromJson(Map<String, dynamic> json) =>
      AyahTranslation(
        number: json["number"],
        text: json["text"],
        numberInSurah: json["numberInSurah"],
        juz: json["juz"],
        manzil: json["manzil"],
        page: json["page"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: json["sajda"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "text": text,
        "numberInSurah": numberInSurah,
        "juz": juz,
        "manzil": manzil,
        "page": page,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda,
      };
}

class SajdaClass {
  SajdaClass({
    this.id,
    this.recommended,
    this.obligatory,
  });

  int? id;
  bool? recommended;
  bool? obligatory;

  factory SajdaClass.fromJson(Map<String, dynamic> json) => SajdaClass(
        id: json["id"],
        recommended: json["recommended"],
        obligatory: json["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "recommended": recommended,
        "obligatory": obligatory,
      };
}

enum RevelationType { MECCAN, MEDINAN }

final revelationTypeValues = EnumValues(
    {"Meccan": RevelationType.MECCAN, "Medinan": RevelationType.MEDINAN});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
