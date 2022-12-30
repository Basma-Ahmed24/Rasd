import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rasd/additional_info.dart';
import 'package:rasd/sign_in.dart';

class Auth extends StatelessWidget{
  const Auth({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot){
          if (snapshot.hasData){
            return AdditionalInfoScreen();
          } else {
            return SignInScreen();
            }
          }
        ),
      ),
    );
  }
}


