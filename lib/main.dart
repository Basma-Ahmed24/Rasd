// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd/auth.dart';
import 'package:rasd/complains_page.dart';
import 'package:rasd/controller/user_bloc/user_cubit.dart';
import 'package:rasd/models/local_data_base/local_data_source.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (BuildContext context) {
        return UserCubit();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Auth(),
      ),
    );
  }
}
