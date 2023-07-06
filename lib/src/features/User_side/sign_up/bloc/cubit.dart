import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rasd_app/src/features/User_side/sign_up/bloc/state.dart';

import '../../../../core/network/api_service.dart';
import 'SignUpModel.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void signUp(SignUpModel signUpModel) async {
    emit(const SignUpState(isLoading: true));

    try {
      final response = await DioHelper.postData(
          endpoint: "user/signup_user", data: signUpModel.toJson());


        final responseData = json.decode(response.data);
if( responseData != null && responseData['fieldCount'] == 0){

        emit(SignUpState(
            isLoading: false, isSuccess: true, signUpModel: signUpModel));
      } else {
        final errorMessage = response.data['message'];
        emit(SignUpState(
            isLoading: false, isSuccess: false, errorMessage: "This user may already exist or the connection Faild "));
      }
      print(response.data);
    } catch (error) {
      emit(SignUpState(
          isLoading: false, isSuccess: false, errorMessage: "This user may already exist or the connection Faild"));
    }
  }
}
