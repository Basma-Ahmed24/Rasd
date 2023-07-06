
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ChangeLocaleState {
 final Locale locale;
 ChangeLocaleState({
  required this.locale,
 });
}


abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {

}

class LanguageError extends LanguageState {
 final String errorMessage;

 LanguageError(this.errorMessage);
}
