// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../network/shared_preferences.dart';
// import 'language_localization.dart';
// class Preferences {
//   static const String current_language_code = "current_language_code";
//
//   Preferences._();}
// String? getTranslated(BuildContext context, String key) {
//   return LanguageLocalization.of(context)!.getTranslateValue(key);
// }
//
// const String ENGLISH = "en";
// const String ARABIC = "ar";
//
// Future<Locale> setLocale(String languageCode) async {
//   CacheHelper.setString(
//       Preferences.current_language_code, languageCode);
//   return _locale(languageCode);
// }
//
// Locale _locale(String languageCode) {
//   Locale _temp;
//   switch (languageCode) {
//     case ENGLISH:
//       _temp = Locale(languageCode, 'US');
//       break;
//     case ARABIC:
//       _temp = Locale(languageCode, 'AE');
//       break;
//     default:
//       _temp = Locale(ENGLISH, 'US');
//   }
//   return _temp;
// }
//
// Future<Locale> getLocale() async {
//   String languageCode =
//   CacheHelper.getString(Preferences.current_language_code);
//   return _locale(languageCode);
// }
