// To parse this JSON data, do
//
//     final quranMeta = quranMetaFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

QuranMeta quranMetaFromJson(String str) => QuranMeta.fromJson(json.decode(str));

String quranMetaToJson(QuranMeta data) => json.encode(data.toJson());

class QuranMeta {
  QuranMeta({
    this.code,
    this.status,
    this.data,
  });

  int? code;
  String? status;
  Data? data;

  factory QuranMeta.fromJson(Map<String, dynamic> json) => QuranMeta(
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
    this.ayahs,
    this.surahs,
    this.sajdas,
    this.rukus,
    this.pages,
    this.manzils,
    this.hizbQuarters,
    this.juzs,
  });

  Ayahs? ayahs;
  Surahs? surahs;
  Sajdas? sajdas;
  HizbQuarters? rukus;
  HizbQuarters? pages;
  HizbQuarters? manzils;
  HizbQuarters? hizbQuarters;
  HizbQuarters? juzs;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        ayahs: Ayahs.fromJson(json["ayahs"]),
        surahs: Surahs.fromJson(json["surahs"]),
        sajdas: Sajdas.fromJson(json["sajdas"]),
        rukus: HizbQuarters.fromJson(json["rukus"]),
        pages: HizbQuarters.fromJson(json["pages"]),
        manzils: HizbQuarters.fromJson(json["manzils"]),
        hizbQuarters: HizbQuarters.fromJson(json["hizbQuarters"]),
        juzs: HizbQuarters.fromJson(json["juzs"]),
      );

  Map<String, dynamic> toJson() => {
        "ayahs": ayahs!.toJson(),
        "surahs": surahs!.toJson(),
        "sajdas": sajdas!.toJson(),
        "rukus": rukus!.toJson(),
        "pages": pages!.toJson(),
        "manzils": manzils!.toJson(),
        "hizbQuarters": hizbQuarters!.toJson(),
        "juzs": juzs!.toJson(),
      };
}

class Ayahs {
  Ayahs({
    this.count,
  });

  int? count;

  factory Ayahs.fromJson(Map<String, dynamic> json) => Ayahs(
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
      };
}

class HizbQuarters {
  HizbQuarters({
    this.count,
    this.references,
  });

  int? count;
  List<HizbQuartersReference>? references;

  factory HizbQuarters.fromJson(Map<String, dynamic> json) => HizbQuarters(
        count: json["count"],
        references: List<HizbQuartersReference>.from(
            json["references"].map((x) => HizbQuartersReference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "references": List<dynamic>.from(references!.map((x) => x.toJson())),
      };
}

class HizbQuartersReference {
  HizbQuartersReference({
    this.surah,
    this.ayah,
  });

  int? surah;
  int? ayah;

  factory HizbQuartersReference.fromJson(Map<String, dynamic> json) =>
      HizbQuartersReference(
        surah: json["surah"],
        ayah: json["ayah"],
      );

  Map<String, dynamic> toJson() => {
        "surah": surah,
        "ayah": ayah,
      };
}

class Sajdas {
  Sajdas({
    this.count,
    this.references,
  });

  int? count;
  List<SajdasReference>? references;

  factory Sajdas.fromJson(Map<String, dynamic> json) => Sajdas(
        count: json["count"],
        references: List<SajdasReference>.from(
            json["references"].map((x) => SajdasReference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "references": List<dynamic>.from(references!.map((x) => x.toJson())),
      };
}

class SajdasReference {
  SajdasReference({
    this.surah,
    this.ayah,
    this.recommended,
    this.obligatory,
  });

  int? surah;
  int? ayah;
  bool? recommended;
  bool? obligatory;

  factory SajdasReference.fromJson(Map<String, dynamic> json) =>
      SajdasReference(
        surah: json["surah"],
        ayah: json["ayah"],
        recommended: json["recommended"],
        obligatory: json["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "surah": surah,
        "ayah": ayah,
        "recommended": recommended,
        "obligatory": obligatory,
      };
}

class Surahs {
  Surahs({
    this.count,
    this.references,
  });

  int? count;
  List<SurahsReference>? references;

  factory Surahs.fromJson(Map<String, dynamic> json) => Surahs(
        count: json["count"],
        references: List<SurahsReference>.from(
            json["references"].map((x) => SurahsReference.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "references": List<dynamic>.from(references!.map((x) => x.toJson())),
      };
}

class SurahsReference {
  SurahsReference({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  int numberOfAyahs;
  RevelationType revelationType;

  factory SurahsReference.fromJson(Map<String, dynamic> json) =>
      SurahsReference(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        numberOfAyahs: json["numberOfAyahs"],
        revelationType: revelationTypeValues.map[json["revelationType"]]!,
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "numberOfAyahs": numberOfAyahs,
        "revelationType": revelationTypeValues.reverse![revelationType],
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
