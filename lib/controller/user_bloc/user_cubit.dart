// ignore_for_file: avoid_print, empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd/controller/user_bloc/user_state.dart';
import 'package:rasd/models/auth_models.dart';
import 'package:rasd/models/complains_models.dart';

class AuthCubit extends Cubit {
  AuthCubit() : super(AuthInitialStatus());
  static AuthCubit get(context) => BlocProvider.of(context);
  String? userId;
  Future authWithEmail(String? email, String? pass) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email!,
        password: pass!,
      )
          .then(
        (value) {
          if (value.user != null) {
            userId = value.user!.uid;
          } else {
            print(value.user!.uid);
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future addUserInfo({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? nationalId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .set(AuthModels().toJson());
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
