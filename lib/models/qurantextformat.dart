// To parse this JSON data, do
//
//     final quranFormat = quranFormatFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

QuranFormat quranFormatFromJson(String str) =>
    QuranFormat.fromJson(json.decode(str));

String quranFormatToJson(QuranFormat data) => json.encode(data.toJson());

class QuranFormat {
  QuranFormat({
    this.code,
    this.status,
    this.data,
  });

  int? code;
  String? status;
  List<EachTranslation>? data;

  factory QuranFormat.fromJson(Map<String, dynamic> json) => QuranFormat(
        code: json["code"],
        status: json["status"],
        data: List<EachTranslation>.from(
            json["data"].map((x) => EachTranslation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EachTranslation {
  EachTranslation({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
    this.direction,
  });

  String? identifier;
  String? language;
  String? name;
  String? englishName;
  Format? format;
  Type? type;
  Direction? direction;

  factory EachTranslation.fromJson(Map<String, dynamic> json) =>
      EachTranslation(
        identifier: json["identifier"],
        language: json["language"],
        name: json["name"],
        englishName: json["englishName"],
        format: formatValues.map[json["format"]],
        type: typeValues.map[json["type"]],
        direction: directionValues.map[json["direction"]],
      );

  Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "language": language,
        "name": name,
        "englishName": englishName,
        "format": formatValues.reverse![format!],
        "type": typeValues.reverse![type!],
        "direction": directionValues.reverse![direction!],
      };
}

enum Direction { RTL, LTR }

final directionValues =
    EnumValues({"ltr": Direction.LTR, "rtl": Direction.RTL});

enum Format { TEXT }

final formatValues = EnumValues({"text": Format.TEXT});

enum Type { TAFSIR, TRANSLATION, TRANSLITERATION, QURAN }

final typeValues = EnumValues({
  "quran": Type.QURAN,
  "tafsir": Type.TAFSIR,
  "translation": Type.TRANSLATION,
  "transliteration": Type.TRANSLITERATION
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
