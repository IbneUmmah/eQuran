// To parse this JSON data, do
//
//     final quranText = quranTextFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

QuranText quranTextFromJson(String str) => QuranText.fromJson(json.decode(str));

String quranTextToJson(QuranText data) => json.encode(data.toJson());

class QuranText {
  QuranText({
    this.code,
    this.status,
    this.data,
  });

  int? code;
  String? status;
  Data? data;

  factory QuranText.fromJson(Map<String, dynamic> json) => QuranText(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.surahs,
    this.edition,
  });

  List<SurahModel>? surahs;
  Edition? edition;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surahs: List<SurahModel>.from(
            json["surahs"].map((x) => SurahModel.fromJson(x))),
        edition: Edition.fromJson(json["edition"]),
      );

  Map<String, dynamic> toJson() => {
        "surahs": List<dynamic>.from(surahs!.map((x) => x.toJson())),
        "edition": edition!.toJson(),
      };
}

class Edition {
  Edition({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
  });

  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;

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

class SurahModel {
  SurahModel({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.ayahs,
  });

  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  RevelationType? revelationType;
  List<AyahModel>? ayahs;

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        revelationType: revelationTypeValues.map[json["revelationType"]],
        ayahs: List<AyahModel>.from(
            json["ayahs"].map((x) => AyahModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "revelationType": revelationTypeValues.reverse![revelationType!],
        "ayahs": List<dynamic>.from(ayahs!.map((x) => x.toJson())),
      };
}

class AyahModel {
  AyahModel({
    this.number,
    this.audio,
    this.audioSecondary,
    this.text,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  int? number;
  String? audio;
  List<String>? audioSecondary;
  String? text;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  dynamic sajda;

  factory AyahModel.fromJson(Map<String, dynamic> json) => AyahModel(
        number: json["number"],
        audio: json["audio"],
        audioSecondary: List<String>.from(json["audioSecondary"].map((x) => x)),
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
        "audio": audio,
        "audioSecondary": List<dynamic>.from(audioSecondary!.map((x) => x)),
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
