// ignore_for_file: non_constant_identifier_names, no_leading_underscores_for_local_identifiers
import 'dart:convert';

import 'package:quran/constants.dart';

class UserPrayerPreference {
  UserPrayerPreference({
    required this.country,
    required this.city,
    this.method = kPrayerMethodDefault,
    this.school = kPrayerSchoolDefault,
  });
  String country;
  String city;
  int method;
  int school;
  factory UserPrayerPreference.fromJson(Map<String, dynamic> json) {
    return UserPrayerPreference(
        country: json['country'],
        city: json['city'],
        method: json['method'],
        school: json['school']);
  }

  Map<String, dynamic> toJson() =>
      {'country': country, 'city': city, 'method': method, 'school': school};
}

class YearlyPrayerTiming {
  YearlyPrayerTiming({
    required this.code,
    required this.status,
    required this.data,
  });
  late final int code;
  late final String status;
  late final Data data;

  YearlyPrayerTiming.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['status'] = status;
    //_data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.months,
  });
  late final List<List<Daily>> months;

  Data.fromJson(Map<String, dynamic> json) {
    List<Daily> january =
        List.from(json['1']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> february =
        List.from(json['2']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> march =
        List.from(json['3']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> april =
        List.from(json['4']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> may =
        List.from(json['5']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> june =
        List.from(json['6']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> july =
        List.from(json['7']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> august =
        List.from(json['8']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> september =
        List.from(json['9']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> october =
        List.from(json['10']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> november =
        List.from(json['11']).map((e) => Daily.fromJson(e)).toList();
    List<Daily> december =
        List.from(json['12']).map((e) => Daily.fromJson(e)).toList();
    months = [
      january,
      february,
      march,
      april,
      may,
      june,
      july,
      august,
      september,
      october,
      november,
      december
    ];
    // months.sort(((a, b) => a[0].date.timestamp.compareTo(b[0].date.timestamp)));
  }

  // Map<String, dynamic> toJson() {
  //   final _data = <String, dynamic>{};
  //   _data['1'] = january.map((e) => e.toJson()).toList();
  //   _data['2'] = february.map((e) => e.toJson()).toList();
  //   _data['3'] = march.map((e) => e.toJson()).toList();
  //   _data['4'] = april.map((e) => e.toJson()).toList();
  //   _data['5'] = may.map((e) => e.toJson()).toList();
  //   _data['6'] = june.map((e) => e.toJson()).toList();
  //   _data['7'] = july.map((e) => e.toJson()).toList();
  //   _data['8'] = august.map((e) => e.toJson()).toList();
  //   _data['9'] = september.map((e) => e.toJson()).toList();
  //   _data['10'] = october.map((e) => e.toJson()).toList();
  //   _data['11'] = november.map((e) => e.toJson()).toList();
  //   _data['12'] = december.map((e) => e.toJson()).toList();
  //   return _data;
  // }
}

class Daily {
  Daily({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  Daily.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Prayer {
  Prayer({required this.name, required this.time});
  late final String name;
  late final String time;
  Prayer.fromJson(String prayerName, String prayerTime) {
    name = prayerName;
    time = prayerTime.split(' ')[0];
  }
}

class Timings {
  Timings(
      {
      // {required this.Fajr,
      // required this.Sunrise,
      // required this.Dhuhr,
      // required this.Asr,
      // required this.Sunset,
      // required this.Maghrib,
      // required this.Isha,
      // required this.Imsak,
      // required this.Midnight,
      // required this.Firstthird,
      // required this.Lastthird,
      required this.prayers});
  // late final String Fajr;
  // late final String Sunrise;
  // late final String Dhuhr;
  // late final String Asr;
  // late final String Sunset;
  // late final String Maghrib;
  // late final String Isha;
  // late final String Imsak;
  // late final String Midnight;
  // late final String Firstthird;
  // late final String Lastthird;
  late final List<Prayer> prayers;

  Timings.fromJson(Map<String, dynamic> json) {
    // Fajr = json['Fajr'];
    // Sunrise = json['Sunrise'];
    // Dhuhr = json['Dhuhr'];
    // Asr = json['Asr'];
    // Sunset = json['Sunset'];
    // Maghrib = json['Maghrib'];
    // Isha = json['Isha'];
    // Imsak = json['Imsak'];
    // Midnight = json['Midnight'];
    // Firstthird = json['Firstthird'];
    // Lastthird = json['Lastthird'];

    prayers = json.entries.map((e) => Prayer.fromJson(e.key, e.value)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    // _data['Fajr'] = Fajr;
    // _data['Sunrise'] = Sunrise;
    // _data['Dhuhr'] = Dhuhr;
    // _data['Asr'] = Asr;
    // _data['Sunset'] = Sunset;
    // _data['Maghrib'] = Maghrib;
    // _data['Isha'] = Isha;
    // _data['Imsak'] = Imsak;
    // _data['Midnight'] = Midnight;
    // _data['Firstthird'] = Firstthird;
    // _data['Lastthird'] = Lastthird;
    return _data;
  }
}

class Date {
  Date({
    required this.readable,
    required this.timestamp,
    required this.gregorian,
    required this.hijri,
  });
  late final String readable;
  late final String timestamp;
  late final Gregorian gregorian;
  late final Hijri hijri;

  Date.fromJson(Map<String, dynamic> json) {
    readable = json['readable'];
    timestamp = json['timestamp'];
    gregorian = Gregorian.fromJson(json['gregorian']);
    hijri = Hijri.fromJson(json['hijri']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['readable'] = readable;
    _data['timestamp'] = timestamp;
    _data['gregorian'] = gregorian.toJson();
    _data['hijri'] = hijri.toJson();
    return _data;
  }
}

class Gregorian {
  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });
  late final String date;
  late final String format;
  late final String day;
  late final Weekday weekday;
  late final Month month;
  late final String year;
  late final Designation designation;

  Gregorian.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    day = json['day'];
    weekday = Weekday.fromJson(json['weekday']);
    month = Month.fromJson(json['month']);
    year = json['year'];
    designation = Designation.fromJson(json['designation']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['format'] = format;
    _data['day'] = day;
    _data['weekday'] = weekday.toJson();
    _data['month'] = month.toJson();
    _data['year'] = year;
    _data['designation'] = designation.toJson();
    return _data;
  }
}

class Weekday {
  Weekday({
    required this.en,
  });
  late final String en;

  Weekday.fromJson(Map<String, dynamic> json) {
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['en'] = en;
    return _data;
  }
}

class Month {
  Month({
    required this.number,
    required this.en,
  });
  late final int number;
  late final String en;

  Month.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['number'] = number;
    _data['en'] = en;
    return _data;
  }
}

class Designation {
  Designation({
    required this.abbreviated,
    required this.expanded,
  });
  late final String abbreviated;
  late final String expanded;

  Designation.fromJson(Map<String, dynamic> json) {
    abbreviated = json['abbreviated'];
    expanded = json['expanded'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['abbreviated'] = abbreviated;
    _data['expanded'] = expanded;
    return _data;
  }
}

class Hijri {
  Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
  });
  late final String date;
  late final String format;
  late final String day;
  late final Weekday weekday;
  late final Month month;
  late final String year;
  late final Designation designation;
  late final List<dynamic> holidays;

  Hijri.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    format = json['format'];
    day = json['day'];
    weekday = Weekday.fromJson(json['weekday']);
    month = Month.fromJson(json['month']);
    year = json['year'];
    designation = Designation.fromJson(json['designation']);
    holidays = List.castFrom<dynamic, dynamic>(json['holidays']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['date'] = date;
    _data['format'] = format;
    _data['day'] = day;
    _data['weekday'] = weekday.toJson();
    _data['month'] = month.toJson();
    _data['year'] = year;
    _data['designation'] = designation.toJson();
    _data['holidays'] = holidays;
    return _data;
  }
}

class Meta {
  Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });
  late final double latitude;
  late final double longitude;
  late final String timezone;
  late final Method method;
  late final String latitudeAdjustmentMethod;
  late final String midnightMode;
  late final String school;
  late final Offset offset;

  Meta.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    timezone = json['timezone'];
    method = Method.fromJson(json['method']);
    latitudeAdjustmentMethod = json['latitudeAdjustmentMethod'];
    midnightMode = json['midnightMode'];
    school = json['school'];
    offset = Offset.fromJson(json['offset']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['timezone'] = timezone;
    _data['method'] = method.toJson();
    _data['latitudeAdjustmentMethod'] = latitudeAdjustmentMethod;
    _data['midnightMode'] = midnightMode;
    _data['school'] = school;
    _data['offset'] = offset.toJson();
    return _data;
  }
}

class Method {
  Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });
  late final int id;
  late final String name;
  late final Params params;
  late final Location location;

  Method.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    params = Params.fromJson(json['params']);
    location = Location.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['params'] = params.toJson();
    _data['location'] = location.toJson();
    return _data;
  }
}

class Params {
  Params({
    required this.Fajr,
    required this.Isha,
  });
  late final int Fajr;
  late final int Isha;

  Params.fromJson(Map<String, dynamic> json) {
    Fajr = json['Fajr'];
    Isha = json['Isha'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Fajr'] = Fajr;
    _data['Isha'] = Isha;
    return _data;
  }
}

class Location {
  Location({
    required this.latitude,
    required this.longitude,
  });
  late final double latitude;
  late final double longitude;

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    return _data;
  }
}

class Offset {
  Offset({
    required this.Imsak,
    required this.Fajr,
    required this.Sunrise,
    required this.Dhuhr,
    required this.Asr,
    required this.Maghrib,
    required this.Sunset,
    required this.Isha,
    required this.Midnight,
  });
  late final int Imsak;
  late final int Fajr;
  late final int Sunrise;
  late final int Dhuhr;
  late final int Asr;
  late final int Maghrib;
  late final int Sunset;
  late final int Isha;
  late final int Midnight;

  Offset.fromJson(Map<String, dynamic> json) {
    Imsak = json['Imsak'];
    Fajr = json['Fajr'];
    Sunrise = json['Sunrise'];
    Dhuhr = json['Dhuhr'];
    Asr = json['Asr'];
    Maghrib = json['Maghrib'];
    Sunset = json['Sunset'];
    Isha = json['Isha'];
    Midnight = json['Midnight'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Imsak'] = Imsak;
    _data['Fajr'] = Fajr;
    _data['Sunrise'] = Sunrise;
    _data['Dhuhr'] = Dhuhr;
    _data['Asr'] = Asr;
    _data['Maghrib'] = Maghrib;
    _data['Sunset'] = Sunset;
    _data['Isha'] = Isha;
    _data['Midnight'] = Midnight;
    return _data;
  }
}

class February {
  February({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  February.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class March {
  March({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  March.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class April {
  April({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  April.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class May {
  May({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  May.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class June {
  June({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  June.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class July {
  July({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  July.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class August {
  August({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  August.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class September {
  September({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  September.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class October {
  October({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  October.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class November {
  November({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  November.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class December {
  December({
    required this.timings,
    required this.date,
    required this.meta,
  });
  late final Timings timings;
  late final Date date;
  late final Meta meta;

  December.fromJson(Map<String, dynamic> json) {
    timings = Timings.fromJson(json['timings']);
    date = Date.fromJson(json['date']);
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['timings'] = timings.toJson();
    _data['date'] = date.toJson();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

// To parse this JSON data, do
//
//     final locationApi = locationApiFromJson(jsonString);

LocationApi locationApiFromJson(String str) =>
    LocationApi.fromJson(json.decode(str));

String locationApiToJson(LocationApi data) => json.encode(data.toJson());

class LocationApi {
  LocationApi({
    required this.status,
    required this.country,
    required this.countryCode,
    required this.region,
    required this.regionName,
    required this.city,
    required this.zip,
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.isp,
    required this.org,
    required this.locationApiAs,
    required this.query,
  });

  String status;
  String country;
  String countryCode;
  String region;
  String regionName;
  String city;
  String zip;
  double lat;
  double lon;
  String timezone;
  String isp;
  String org;
  String locationApiAs;
  String query;

  factory LocationApi.fromJson(Map<String, dynamic> json) => LocationApi(
        status: json["status"],
        country: json["country"],
        countryCode: json["countryCode"],
        region: json["region"],
        regionName: json["regionName"],
        city: json["city"],
        zip: json["zip"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        timezone: json["timezone"],
        isp: json["isp"],
        org: json["org"],
        locationApiAs: json["as"],
        query: json["query"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "country": country,
        "countryCode": countryCode,
        "region": region,
        "regionName": regionName,
        "city": city,
        "zip": zip,
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "isp": isp,
        "org": org,
        "as": locationApiAs,
        "query": query,
      };
}
