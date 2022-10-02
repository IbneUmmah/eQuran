// To parse this JSON data, do
//
//     final eachChapterDetailInfo = eachChapterDetailInfoFromJson(jsonString);

import 'dart:convert';

// To parse this JSON data, do
//
//     final eachReciterInfo = eachReciterInfoFromJson(jsonString);

EachReciterInfo eachReciterInfoFromJson(String str) =>
    EachReciterInfo.fromJson(json.decode(str));

String eachReciterInfoToJson(EachReciterInfo data) =>
    json.encode(data.toJson());

class EachReciterInfo {
  EachReciterInfo({
    required this.reciterNo,
    required this.reciterName,
    required this.server,
  });

  int reciterNo;
  String reciterName;
  String server;
  bool? isFavourite;

  factory EachReciterInfo.fromJson(Map<String, dynamic> json) =>
      EachReciterInfo(
        reciterNo: json["reciterNo"],
        reciterName: json["reciterName"],
        server: json["server"],
      );

  Map<String, dynamic> toJson() => {
        "reciterNo": reciterNo,
        "reciterName": reciterName,
        "server": server,
      };
}

// To parse this JSON data, do
//
//     final eachTranslationInfo = eachTranslationInfoFromJson(jsonString);

EachTranslationInfo eachTranslationInfoFromJson(String str) =>
    EachTranslationInfo.fromJson(json.decode(str));

String eachTranslationInfoToJson(EachTranslationInfo data) =>
    json.encode(data.toJson());

class EachTranslationInfo {
  EachTranslationInfo({
    required this.translationNo,
    required this.translationNameEn,
    required this.translationNameL,
    required this.server,
  });

  int translationNo;
  String translationNameEn;
  String translationNameL;
  String server;

  factory EachTranslationInfo.fromJson(Map<String, dynamic> json) =>
      EachTranslationInfo(
        translationNo: json["translationNo"],
        translationNameEn: json["translationNameEn"],
        translationNameL: json["translationNameL"],
        server: json["server"],
      );

  Map<String, dynamic> toJson() => {
        "translationNo": translationNo,
        "translationNameEn": translationNameEn,
        "translationNameL": translationNameL,
        "server": server,
      };
}

// To parse this JSON data, do
//
//     final eachVerseInfo = eachVerseInfoFromJson(jsonString);

EachVerseInfo eachVerseInfoFromJson(String str) =>
    EachVerseInfo.fromJson(json.decode(str));

String eachVerseInfoToJson(EachVerseInfo data) => json.encode(data.toJson());

class EachVerseInfo {
  EachVerseInfo({
    this.order,
    this.chapterNo,
    this.verseNo,
    this.arabic,
    this.translation,
    this.textDirection,
    this.sajda,
    this.link,
  });

  int? order;
  int? chapterNo;
  int? verseNo;
  String? arabic;
  String? translation;
  String? textDirection;
  String? sajda;
  String? link;

  factory EachVerseInfo.fromJson(Map<String, dynamic> json) => EachVerseInfo(
        order: json["order"],
        chapterNo: json["chapterNo"],
        verseNo: json["verseNo"],
        arabic: json["arabic"],
        translation: json["translation"],
        textDirection: json["textDirection"],
        sajda: json["sajda"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "order": order,
        "chapterNo": chapterNo,
        "verseNo": verseNo,
        "arabic": arabic,
        "translation": translation,
        "textDirection": textDirection,
        "sajda": sajda,
        "link": link,
      };
}
