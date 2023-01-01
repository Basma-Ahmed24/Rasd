// ignore_for_file: avoid_print, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd/controller/user_bloc/user_state.dart';
import 'package:rasd/models/auth_models.dart';
import 'package:rasd/models/complains_models.dart';
import 'package:rasd/models/constants.dart';
import 'package:rasd/sign_in.dart';

class UserCubit extends Cubit<UserStatus> {
  UserCubit() : super(UserInitialStatus());
  static UserCubit get(context) => BlocProvider.of(context);
  String? _userId;
  String? get userId => _userId;
  Future<UserCredential?> authWithEmail(
    String? email,
    String? pass,
    BuildContext? context,
  ) async {
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email!,
        password: pass!,
      )
          .then(
        (value) {
          print(value);
          if (value.user != null) {
            _userId = value.user!.uid;
          } else {
            print(value.user!.uid);
          }
          return value;
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('erroe is $e');
    }
    return credential!;
  }

  Future addUserInfo(BuildContext context, AuthModels user) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.user)
          .doc(userId)
          .set(
            user.toJson(),
          )
          .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignInScreen(),
              ),
            ),
          );
    } catch (e) {}
  }

  Future addComplains({
    String? complainsName,
    String? complainDetails,
    DateTime? complainsDate,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('Complains')
          .doc()
          .set(
            ComplainsModels().toJson(),
          );
    } catch (e) {}
  }
}
