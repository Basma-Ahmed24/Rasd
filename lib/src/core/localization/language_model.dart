import 'package:flutter/material.dart';

class Language {
  final String name;
  final Locale locale;

  Language(this.name, this.locale);

  static List<Language> getLanguages() {
    return [
      Language('English', Locale('en', 'US')),
      Language('Arabic', Locale('ar', 'SA')),
    ];
  }
}