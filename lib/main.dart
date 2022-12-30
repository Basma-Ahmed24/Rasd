import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rasd/additional_info.dart';
import 'package:rasd/auth.dart';
import 'package:rasd/sign_in.dart';
import 'package:flutter/widgets.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {


    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Auth()
    );
  }
}

