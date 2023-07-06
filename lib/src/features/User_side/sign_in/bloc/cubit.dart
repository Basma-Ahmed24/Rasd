import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import '../../../../core/network/api_service.dart';
import 'User.dart';



class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super( SignInState());

  void signIn(User user) async {
    emit(SignInState(isLoading: true));

    // Create a Dio instance and set the headers for the request
    Map<dynamic, dynamic> data = {"is_existing_user": true};

    // Send the request to the API endpoint
    try {
      final response = await DioHelper.postData(
          endpoint: "user/login_user", data: user.toJson());

      // Check the response status code
      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        final isExistingUser = responseData['is_existing_user'];
        if (isExistingUser is bool) {
          if (isExistingUser == true) {
            emit(SignInState(
                isLoading: false,
                isSuccess: true,
                signinModel: user,
                errorMessage: 'Sign In Successfully'));
          } else {
            final errorMessage = 'User does not exist';
            emit(SignInState(
                isLoading: false,
                isSuccess: false,
                errorMessage: errorMessage));
          }
        } else {
          final errorMessage = 'NID or Password not correct';
          emit(SignInState(
              isLoading: false, isSuccess: false, errorMessage: errorMessage));
        }
      } else {
        final errorMessage = 'NID or Password not correct';
        emit(SignInState(
            isLoading: false, isSuccess: false, errorMessage: errorMessage));
      }
    } catch (e) {
      emit(SignInState(
          isLoading: false, isSuccess: false, errorMessage: "Open Your Network to Sign In"));
    }print(state.errorMessage);
  }}

