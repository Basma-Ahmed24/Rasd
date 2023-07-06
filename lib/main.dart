import 'package:intl_translation/generate_localized.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/core/localization/bloc.dart';
import 'package:rasd_app/src/core/localization/language_event.dart';
import 'package:rasd_app/src/core/localization/language_localization.dart';
import 'package:rasd_app/src/core/localization/language_state.dart';
import 'package:rasd_app/src/core/localization/localization_constant.dart';
import 'package:rasd_app/src/core/network/api_service.dart';
import 'package:rasd_app/src/core/network/observer_bloc.dart';
import 'package:rasd_app/src/core/network/shared_preferences.dart';
import 'package:rasd_app/src/features/Admin_side/home/home_screen.dart';
import 'package:rasd_app/src/features/User_side/onboardingscreens/screens/screen1.dart';
import 'package:rasd_app/src/features/User_side/onboardingscreens/screens/screen3.dart';
void main() async {
  BlocOverrides.runZoned(() {}, blocObserver: MyBlocObserver());

  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioHelper.init();

  // Initialize LanguageBloc and register event handlers


  // Create MyApp widget and pass the initialized LanguageBloc instance
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override

  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return MaterialApp(
            locale: state.locale,
            supportedLocales: const [Locale('en'), Locale('ar')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocale != null &&
                    deviceLocale.languageCode == locale.languageCode) {
                  return deviceLocale;
                }
              }

              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            home:  Boarding1(),
          );
        },
      ),
    );
  }
}