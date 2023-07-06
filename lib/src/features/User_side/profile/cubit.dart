import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/features/User_side/profile/state.dart';

import '../../../core/network/api_service.dart';
import '../../../core/network/shared_preferences.dart';
import 'Profile_model.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
dynamic p=[];
  dynamic n=[];
  dynamic projects=[];
  static UserCubit get(context) => BlocProvider.of(context);
  Future<void> getUserData(String google_id) async {
    try {
      emit(UserLoading());

      final response = await DioHelper.getData(
        endpoint: "user/get_user_info",
        token: CacheHelper.getData(key: "apiToken"),
        queryParams: {'google_id':google_id},
      );

      final responseData = json.decode(response.data);
      p=responseData[0];
      print(p['fname']);

      emit(UserLoaded());
    } catch (e) {

      emit(UserError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> deleteUser(String google_id) async {
    try {
      emit(UserLoading());

      final response = await DioHelper.postData(
        endpoint: "user/delete_user",
        token: CacheHelper.getData(key: "apiToken"),
       data:{"google_id":google_id}
      );

      final responseData = json.decode(response.data);
      if( responseData != null && responseData['fieldCount'] == 0){
        emit(UserLoaded());
}else{
        final errorMessage = response.data['message'];
        emit(UserError(errorMessage));

      }
    } catch (e) {
      emit(UserError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> updateUserGmail(String google_id,String email) async {
    try {
      emit(UserLoading());

      final response = await DioHelper.postData(
          endpoint: "user/update_user_info",
          token: CacheHelper.getData(key: "apiToken"),
          data:{"google_id":google_id,"email":email}
      );

      final responseData = json.decode(response.data);
      if( responseData != null && responseData['fieldCount'] == 0){
        emit(UserLoaded());
      }else{
        final errorMessage = response.data['message'];
        emit(UserError(errorMessage));

      }
    } catch (e) {
      emit(UserError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> updateUserphone(String google_id,String phone) async {
    try {
      emit(UserLoading());

      final response = await DioHelper.postData(
          endpoint: "user/update_user_info",
          token: CacheHelper.getData(key: "apiToken"),
          data:{"google_id":google_id,"mobile_number":phone}
      );

      final responseData = json.decode(response.data);
      if( responseData != null && responseData['fieldCount'] == 0){
        emit(UserLoaded());
      }else{
        final errorMessage = response.data['message'];
        emit(UserError(errorMessage));

      }
    } catch (e) {
      emit(UserError(e.toString()));
      print(e.toString());
    }
  }

// emit(UserError(Error.toString()));
      // print(e.toString());
  Future<void> getNewsData() async {
    try {
      emit(UserLoading());


      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {
        "proj_or_news":"news"
      },

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
        n=responseData;
      print(n.toString());

      emit(UserLoaded());

    } catch (e) {
      emit(UserError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> getProjrctData() async {
    try {
      emit(UserLoading());

      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {
        "proj_or_news":"proj"
      },

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
        projects=responseData;
      print(projects.toString());

      emit(UserLoaded());
    } catch (e) {
      emit(UserError(e.toString()));
      print(e.toString());
    }
  }
  void func1(){
    for(int i=0;i<n.length;i++){

      n[i]["start_date"]=n[i]["start_date"]?.substring(0,10);
    }}
  void func2(){
    for(int i=0;i<projects.length;i++){

      projects[i]["start_date"]=projects[i]["start_date"]?.substring(0,10);
    }}
  }

