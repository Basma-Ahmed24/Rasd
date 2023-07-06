import 'package:flutter/material.dart';

abstract class LanguageEvent{}
class LoadLanguage extends LanguageEvent{
  final Locale? locale;
  LoadLanguage({this.locale});
}