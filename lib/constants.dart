import 'package:flutter/material.dart';
import 'package:quran/functions/audiostate.dart';

const kHiveBox = 'kMainHiveBox';
const kAppThemeMode = "kAppThemeMode";
const kLastText = 'kLastText';
const kInitializedVersion = 'initializedVersion';
const kEnglishText = 'en.sahih';
const kArabicText = 'quran-uthmani';
const kSelectedAudioTranslation = 'kSelectedAudioTranslation';
const kDefaultSelectedAudioTranslation = 'English';
const kSelectedArabicFontSize = 'kSelectedArabicFontSize';
const kSelectedTranslationFontSize = 'kSelectedTranslationFontSize';
const kDefaultArabicSelectedFontSize = 30.0;
const kDefaultTranslationSelectedFontSize = 20.0;
const kSelectedAudioType = 'kSelectedAudioType';
const kDefaultAudioType = AudioType.arabic;
const kYearlyPrayerTimings = 'kYearlyPrayerTimings';
const kAdhanNotificationSound = 'adhan';
const kAdhanNotificationSet = 'kAdhanNotificationSet';
const kDailyAyahNotification = 'kDailyAyahNotification';
const kGetDailyAyahNotification = 'kGetDailyAyahNotification';
const kGetAdhanNotification = 'kGetAdhanNotification';
const kUserPrayerPrefencees = 'kUserPrayerPrefencees';
const kPrayerSchoolDefault = 1;
const kPrayerMethodDefault = 3;

const kCurrentVersion = 3;
const kPrimaryColor1 = Color(0XFF1C2C3B);
const kPrimaryColor2 = Color(0XFF006C72);
const kPrimaryColor3 = Color(0XFF39E1EB);
const kPrimaryColor4 = Color(0XFFECF5F5);

const kCommonTextStyle = TextStyle(
  color: Colors.black,
  //Theme.of(context).iconTheme.color,
  //fontSize: 20,

  fontFamily: "ScheherazadeNew-Bold",
);

const kCommonTextStyleDark = TextStyle(
  color: Colors.white,
  fontFamily: "ScheherazadeNew-Bold",
);

const kRadioText = TextStyle(
  fontSize: 17.0,
  fontWeight: FontWeight.bold,
);

const kLightColor = Color(0XFF289672);
const kTextColor = Colors.white;

const kQuranTextColor = Color(0XFFe5da2d);
final kAladhanImages = List.generate(52,
    (index) => 'https://cdn.aladhan.com/images/backgrounds/${index + 1}.jpg');

// const kPrayerTimeImages = [
//   'https://media.istockphoto.com/vectors/black-mosque-before-sunrise-on-blue-background-vector-illustration-vector-id681200342?k=20&m=681200342&s=170667a&w=0&h=Cwb7NRcgdXFw8qeZ2mnAOwVBhfURaEB0XvQnh1HJO7k=',
//   'https://www.rosecastlefoundation.org/hubfs/Untitled%20design%20%289%29.png',
//   'https://thumbs.dreamstime.com/b/crescent-moon-beautiful-sunset-background-generous-ramadan-crescent-moon-beautiful-sunset-background-generous-ramadan-176734096.jpg',
//   'https://thumbs.dreamstime.com/b/turkish-mosque-sunset-violet-sky-light-minara-silhouette-minaret-big-muslim-high-minarets-city-istanbul-82704873.jpg',
//   //'https://static.vecteezy.com/system/resources/previews/007/242/781/non_2x/background-of-mosque-in-the-dessert-free-vector.jpg'
//   'https://static.vecteezy.com/system/resources/previews/006/083/370/original/mosque-on-the-desert-background-free-vector.jpg'
// ];

const kALLBackgrounds = [
  //ALADHAN//

  "https://i.ibb.co/SnnC2Zx/DALL-E-2022-09-30-23-21-17-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/vJQLdBP/DALL-E-2022-09-30-23-20-40-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/RgyFPrP/DALL-E-2022-10-01-15-16-59-Sun-is-rising-with-the-dew-drops-are-on-the-grass-shining-in-the-village.png",
  "https://i.ibb.co/BPpVf2X/DALL-E-2022-09-30-23-25-34-Mosque-in-arabian-oasis-and-sun-on-the-horizon-with-deer-walking-in-the-f.png",
  "https://i.ibb.co/gDLQv5P/DALL-E-2022-09-30-23-28-08-Mosque-in-jungle-and-sun-is-after-the-horizon-with-birds-flying.png",
  "https://i.ibb.co/56WkDSC/DALL-E-2022-09-30-23-43-11-Sunset-almost-completely-in-the-arabian-desert.png",
  "https://i.ibb.co/fv78pWs/DALL-E-2022-09-30-23-31-41-Blueish-color-Mosque-few-moments-after-the-sunset-and-people-are-going-to.png",
  "https://i.ibb.co/CwML1GN/DALL-E-2022-09-30-23-34-55-White-color-Mosque-at-night-and-people-wearing-kurta-shalwar-are-going-to.png",
  "https://i.ibb.co/wKtCGcx/DALL-E-2022-09-30-23-46-49-Blueish-mosque-at-the-first-third-of-the-night-with-crescent-moon-and-sta.png",
  "https://i.ibb.co/HCpmSqv/DALL-E-2022-09-30-23-37-18-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-raining.png",
  "https://i.ibb.co/xDVSgwK/DALL-E-2022-09-30-23-40-26-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-snowing.png",
//Beautifual Backgrounds//

  "https://i.ibb.co/d6XKLMS/islamic-7093979-960-720.jpg"
      "https://i.ibb.co/hY5jFQT/travel-4604499-340.jpg",
  "https://i.ibb.co/FX4Vw97/eid-mubarak-7229139-960-720.png",
  "https://i.ibb.co/3c0PG2V/mosque-5075059-960-720.jpg",
  "https://i.ibb.co/3T2xdRn/muslim-5032905-960-720.jpg",
  "https://i.ibb.co/pX6TKW3/islamic-7093978-960-720.jpg",
  "https://i.ibb.co/FX4Vw97/eid-mubarak-7229139-960-720.png",
//Surah Backgrounds//
  "https://i.ibb.co/ftGq0pK/abstract-4752869-960-720.jpg",
  "https://i.ibb.co/s3B2ckg/abstract-4752871-960-720.jpg",
  "https://i.ibb.co/XXHmc0B/abstract-4752877-960-720.jpg",
  "https://i.ibb.co/qmX1x1B/abstract-4752872-960-720.jpg",
  "https://i.ibb.co/4dZkhd6/background-7093977-960-720.jpg",
  "https://i.ibb.co/J5489Sp/abstract-7357100-960-720.png",
];
const kAIAdhanBackgrounds = [
//Organized//
  "https://i.ibb.co/SnnC2Zx/DALL-E-2022-09-30-23-21-17-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/vJQLdBP/DALL-E-2022-09-30-23-20-40-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/RgyFPrP/DALL-E-2022-10-01-15-16-59-Sun-is-rising-with-the-dew-drops-are-on-the-grass-shining-in-the-village.png",
  "https://i.ibb.co/BPpVf2X/DALL-E-2022-09-30-23-25-34-Mosque-in-arabian-oasis-and-sun-on-the-horizon-with-deer-walking-in-the-f.png",
  "https://i.ibb.co/gDLQv5P/DALL-E-2022-09-30-23-28-08-Mosque-in-jungle-and-sun-is-after-the-horizon-with-birds-flying.png",
  "https://i.ibb.co/56WkDSC/DALL-E-2022-09-30-23-43-11-Sunset-almost-completely-in-the-arabian-desert.png",
  "https://i.ibb.co/fv78pWs/DALL-E-2022-09-30-23-31-41-Blueish-color-Mosque-few-moments-after-the-sunset-and-people-are-going-to.png",
  "https://i.ibb.co/CwML1GN/DALL-E-2022-09-30-23-34-55-White-color-Mosque-at-night-and-people-wearing-kurta-shalwar-are-going-to.png",

  "https://i.ibb.co/wKtCGcx/DALL-E-2022-09-30-23-46-49-Blueish-mosque-at-the-first-third-of-the-night-with-crescent-moon-and-sta.png",
  "https://i.ibb.co/HCpmSqv/DALL-E-2022-09-30-23-37-18-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-raining.png",
  "https://i.ibb.co/xDVSgwK/DALL-E-2022-09-30-23-40-26-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-snowing.png",
];

const kAIAdhanBackgroundsAll = [
//Organized//
  "https://i.ibb.co/SnnC2Zx/DALL-E-2022-09-30-23-21-17-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/vJQLdBP/DALL-E-2022-09-30-23-20-40-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/RgyFPrP/DALL-E-2022-10-01-15-16-59-Sun-is-rising-with-the-dew-drops-are-on-the-grass-shining-in-the-village.png",
  "https://i.ibb.co/BPpVf2X/DALL-E-2022-09-30-23-25-34-Mosque-in-arabian-oasis-and-sun-on-the-horizon-with-deer-walking-in-the-f.png",
  "https://i.ibb.co/gDLQv5P/DALL-E-2022-09-30-23-28-08-Mosque-in-jungle-and-sun-is-after-the-horizon-with-birds-flying.png",
  "https://i.ibb.co/56WkDSC/DALL-E-2022-09-30-23-43-11-Sunset-almost-completely-in-the-arabian-desert.png",
  "https://i.ibb.co/fv78pWs/DALL-E-2022-09-30-23-31-41-Blueish-color-Mosque-few-moments-after-the-sunset-and-people-are-going-to.png",
  "https://i.ibb.co/CwML1GN/DALL-E-2022-09-30-23-34-55-White-color-Mosque-at-night-and-people-wearing-kurta-shalwar-are-going-to.png",

  "https://i.ibb.co/wKtCGcx/DALL-E-2022-09-30-23-46-49-Blueish-mosque-at-the-first-third-of-the-night-with-crescent-moon-and-sta.png",
  "https://i.ibb.co/HCpmSqv/DALL-E-2022-09-30-23-37-18-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-raining.png",
  "https://i.ibb.co/xDVSgwK/DALL-E-2022-09-30-23-40-26-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-snowing.png",

  //ALL ///
  "https://i.ibb.co/vJQLdBP/DALL-E-2022-09-30-23-20-40-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/ZYX6mG3/DALL-E-2022-09-30-23-21-03-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/SnnC2Zx/DALL-E-2022-09-30-23-21-17-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/NC2zvmX/DALL-E-2022-09-30-23-21-35-Mosque-in-arabian-desert-before-sunrise.png",
  "https://i.ibb.co/RgyFPrP/DALL-E-2022-10-01-15-16-59-Sun-is-rising-with-the-dew-drops-are-on-the-grass-shining-in-the-village.png",
  "https://i.ibb.co/XLT3KBq/DALL-E-2022-10-01-15-17-19-Sun-is-rising-with-the-dew-drops-are-on-the-grass-shining-in-the-village.png",
  "https://i.ibb.co/DG4c7WW/DALL-E-2022-10-01-15-17-38-Sun-is-rising-with-the-dew-drops-are-on-the-grass-shining-in-the-village.png",
  "https://i.ibb.co/RhfNhkz/DALL-E-2022-10-01-15-17-56-Sun-is-rising-with-the-dew-drops-are-on-the-grass-shining-in-the-village.png",
  "https://i.ibb.co/GnzfsnL/DALL-E-2022-09-30-23-40-40-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-snowing.png",
  "https://i.ibb.co/Wt2JpgY/DALL-E-2022-09-30-23-40-52-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-snowing.png",
  "https://i.ibb.co/TbBmWTw/DALL-E-2022-09-30-23-42-49-Sunset-almost-completely-in-the-arabian-desert.png",
  "https://i.ibb.co/jG1LTYL/DALL-E-2022-09-30-23-43-01-Sunset-almost-completely-in-the-arabian-desert.png",
  "https://i.ibb.co/56WkDSC/DALL-E-2022-09-30-23-43-11-Sunset-almost-completely-in-the-arabian-desert.png",
  "https://i.ibb.co/jZknH7L/DALL-E-2022-09-30-23-46-14-Blueish-mosque-at-the-first-third-of-the-night-with-crescent-moon-and-sta.png",
  "https://i.ibb.co/QrDRR14/DALL-E-2022-09-30-23-46-26-Blueish-mosque-at-the-first-third-of-the-night-with-crescent-moon-and-sta.png",
  "https://i.ibb.co/5GR20sR/DALL-E-2022-09-30-23-46-36-Blueish-mosque-at-the-first-third-of-the-night-with-crescent-moon-and-sta.png",
  "https://i.ibb.co/wKtCGcx/DALL-E-2022-09-30-23-46-49-Blueish-mosque-at-the-first-third-of-the-night-with-crescent-moon-and-sta.png",
  "https://i.ibb.co/JxBY9x5/DALL-E-2022-09-30-23-25-22-Mosque-in-arabian-oasis-and-sun-on-the-horizon-with-deer-walking-in-the-f.png",
  "https://i.ibb.co/BPpVf2X/DALL-E-2022-09-30-23-25-34-Mosque-in-arabian-oasis-and-sun-on-the-horizon-with-deer-walking-in-the-f.png",
  "https://i.ibb.co/rG0N5sc/DALL-E-2022-09-30-23-25-49-Mosque-in-arabian-oasis-and-sun-on-the-horizon-with-deer-walking-in-the-f.png",
  "https://i.ibb.co/0C7JtQs/DALL-E-2022-09-30-23-26-03-Mosque-in-arabian-oasis-and-sun-on-the-horizon-with-deer-walking-in-the-f.png",
  "https://i.ibb.co/gDLQv5P/DALL-E-2022-09-30-23-28-08-Mosque-in-jungle-and-sun-is-after-the-horizon-with-birds-flying.png",
  "https://i.ibb.co/mJZ66Xp/DALL-E-2022-09-30-23-28-19-Mosque-in-jungle-and-sun-is-after-the-horizon-with-birds-flying.png",
  "https://i.ibb.co/tJZRntb/DALL-E-2022-09-30-23-28-31-Mosque-in-jungle-and-sun-is-after-the-horizon-with-birds-flying.png",
  "https://i.ibb.co/Yc7fCH5/DALL-E-2022-09-30-23-28-49-Mosque-in-jungle-and-sun-is-after-the-horizon-with-birds-flying.png",
  "https://i.ibb.co/fv78pWs/DALL-E-2022-09-30-23-31-41-Blueish-color-Mosque-few-moments-after-the-sunset-and-people-are-going-to.png",
  "https://i.ibb.co/tBMpTx9/DALL-E-2022-09-30-23-31-53-Blueish-color-Mosque-few-moments-after-the-sunset-and-people-are-going-to.png",
  "https://i.ibb.co/TttMqDF/DALL-E-2022-09-30-23-32-05-Blueish-color-Mosque-few-moments-after-the-sunset-and-people-are-going-to.png",
  "https://i.ibb.co/FHZSm1N/DALL-E-2022-09-30-23-32-19-Blueish-color-Mosque-few-moments-after-the-sunset-and-people-are-going-to.png",
  "https://i.ibb.co/xLrWz1b/DALL-E-2022-09-30-23-34-36-White-color-Mosque-at-night-and-people-wearing-kurta-shalwar-are-going-to.png",
  "https://i.ibb.co/CwML1GN/DALL-E-2022-09-30-23-34-55-White-color-Mosque-at-night-and-people-wearing-kurta-shalwar-are-going-to.png",
  "https://i.ibb.co/7pzw6F8/DALL-E-2022-09-30-23-35-16-White-color-Mosque-at-night-and-people-wearing-kurta-shalwar-are-going-to.png",
  "https://i.ibb.co/jM9ghmk/DALL-E-2022-09-30-23-35-30-White-color-Mosque-at-night-and-people-wearing-kurta-shalwar-are-going-to.png",
  "https://i.ibb.co/HCpmSqv/DALL-E-2022-09-30-23-37-18-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-raining.png",
  "https://i.ibb.co/DfGSg84/DALL-E-2022-09-30-23-37-31-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-raining.png",
  "https://i.ibb.co/Fq40bzK/DALL-E-2022-09-30-23-37-43-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-raining.png",
  "https://i.ibb.co/WsPKCtr/DALL-E-2022-09-30-23-37-57-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-raining.png",
  "https://i.ibb.co/Jn0dQqS/DALL-E-2022-09-30-23-40-15-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-snowing.png",
  "https://i.ibb.co/xDVSgwK/DALL-E-2022-09-30-23-40-26-Sky-blue-color-Mosque-over-the-mountains-in-arabian-desert-while-snowing.png",
];

const kBeautifulBackgrounds = [
  // 'https://cdn.pixabay.com/photo/2022/03/27/03/16/islamic-7093979_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2019/11/05/20/36/travel-4604499__340.jpg',
  // 'https://cdn.pixabay.com/photo/2020/07/22/06/25/mosque-5428208_960_720.png',
  // 'https://cdn.pixabay.com/photo/2022/05/29/13/12/eid-mubarak-7229139_960_720.png',
  // 'https://cdn.pixabay.com/photo/2020/04/22/00/06/mosque-5075059_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/04/12/06/02/muslim-5032905_960_720.jpg', //Man on camel
  // 'https://cdn.pixabay.com/photo/2022/03/27/03/16/islamic-7093978_960_720.jpg', //Curly desing
  "https://i.ibb.co/d6XKLMS/islamic-7093979-960-720.jpg"
      "https://i.ibb.co/hY5jFQT/travel-4604499-340.jpg",
  //"https://i.ibb.co/85fqRMQ/mosque-5428208-960-720.png",

  "https://i.ibb.co/3c0PG2V/mosque-5075059-960-720.jpg",
  "https://i.ibb.co/3T2xdRn/muslim-5032905-960-720.jpg",
  "https://i.ibb.co/pX6TKW3/islamic-7093978-960-720.jpg",
  "https://i.ibb.co/FX4Vw97/eid-mubarak-7229139-960-720.png"
];
const kSurahBackgrounds = [
  // 'https://cdn.pixabay.com/photo/2020/01/09/14/17/abstract-4752869_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/01/09/14/17/abstract-4752871_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/01/09/14/17/abstract-4752877_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2020/01/09/14/17/abstract-4752872_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2022/03/27/03/11/background-7093977_960_720.jpg',
  // 'https://cdn.pixabay.com/photo/2022/08/01/00/49/abstract-7357100_960_720.png',
  "https://i.ibb.co/ftGq0pK/abstract-4752869-960-720.jpg",
  "https://i.ibb.co/s3B2ckg/abstract-4752871-960-720.jpg",
  "https://i.ibb.co/XXHmc0B/abstract-4752877-960-720.jpg",
  "https://i.ibb.co/qmX1x1B/abstract-4752872-960-720.jpg",
  "https://i.ibb.co/4dZkhd6/background-7093977-960-720.jpg",
  "https://i.ibb.co/J5489Sp/abstract-7357100-960-720.png"
];

const kStatusBackgrouds = [
  //Prayers Backgrounds//
  'https://media.istockphoto.com/vectors/black-mosque-before-sunrise-on-blue-background-vector-illustration-vector-id681200342?k=20&m=681200342&s=170667a&w=0&h=Cwb7NRcgdXFw8qeZ2mnAOwVBhfURaEB0XvQnh1HJO7k=',
  'https://www.rosecastlefoundation.org/hubfs/Untitled%20design%20%289%29.png',
  'https://thumbs.dreamstime.com/b/crescent-moon-beautiful-sunset-background-generous-ramadan-crescent-moon-beautiful-sunset-background-generous-ramadan-176734096.jpg',
  'https://thumbs.dreamstime.com/b/turkish-mosque-sunset-violet-sky-light-minara-silhouette-minaret-big-muslim-high-minarets-city-istanbul-82704873.jpg',
  //'https://static.vecteezy.com/system/resources/previews/007/242/781/non_2x/background-of-mosque-in-the-dessert-free-vector.jpg'
  'https://static.vecteezy.com/system/resources/previews/006/083/370/original/mosque-on-the-desert-background-free-vector.jpg',
//kBeautifulBackgrounds//

  "https://i.ibb.co/d6XKLMS/islamic-7093979-960-720.jpg"
      "https://i.ibb.co/hY5jFQT/travel-4604499-340.jpg",

  "https://i.ibb.co/FX4Vw97/eid-mubarak-7229139-960-720.png",
  "https://i.ibb.co/3c0PG2V/mosque-5075059-960-720.jpg",
  "https://i.ibb.co/3T2xdRn/muslim-5032905-960-720.jpg",
  "https://i.ibb.co/pX6TKW3/islamic-7093978-960-720.jpg",

//kSurahBackgrounds//
  "https://i.ibb.co/ftGq0pK/abstract-4752869-960-720.jpg",
  "https://i.ibb.co/s3B2ckg/abstract-4752871-960-720.jpg",
  "https://i.ibb.co/XXHmc0B/abstract-4752877-960-720.jpg",
  "https://i.ibb.co/qmX1x1B/abstract-4752872-960-720.jpg",
  "https://i.ibb.co/4dZkhd6/background-7093977-960-720.jpg",
  "https://i.ibb.co/J5489Sp/abstract-7357100-960-720.png",
];
