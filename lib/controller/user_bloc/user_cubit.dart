// ignore_for_file: avoid_print, empty_catches

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd/complains_page.dart';
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
  Stream<QuerySnapshot<Map<String, dynamic>>>? complains;
  Future<DocumentSnapshot<Map<String, dynamic>>>? userInfo;
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
                builder: (context) => const ComplainsScreen(),
              ),
            ),
          );
    } catch (e) {}
  }

  Future addComplains({
    ComplainsModels? complains,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(Constants.user)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(Constants.complains)
          .doc()
          .set(
            complains!.toJson(),
          );
    } catch (e) {}
  }

  Stream<QuerySnapshot<Map<String, dynamic>>>? getComplains() async* {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      complains = FirebaseFirestore.instance
          .collection(Constants.user)
          .doc(uid)
          .collection(Constants.complains)
          .snapshots();
      yield* complains!;
    } catch (e) {}
  }

  Future<DocumentSnapshot<Map<String, dynamic>>>? getUserInfo() async {
    try {
      userInfo = FirebaseFirestore.instance
          .collection(Constants.user)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return userInfo!;
    } catch (e) {
      throw e;
    }
  }
}
