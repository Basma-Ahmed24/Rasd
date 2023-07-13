import 'dart:convert';


import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
  dynamic path1;


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
  Future<void> updateUserImage(String google_id,String image) async {
    try {
      emit(UserLoading());

      final response = await DioHelper.postData(
          endpoint: "user/update_user_info",
          token: CacheHelper.getData(key: "apiToken"),
          data:{"google_id":google_id,"profile_img":image}
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


  Future<void> getNewsData(String lang) async {
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
      await func(n, lang);
      print(n.toString());

      emit(UserLoaded());

    } catch (e) {
      emit(UserError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> getProjrctData(String lang) async {
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
      await func(projects, lang);

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
  Future<dynamic> translation(String k1,
      String lang) async {
    try {
      final response = await DioHelper.postData(
        endpoint: "translation/translate_json",
        data: {
          "target_language": lang,
          "key_1": k1,

        },
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) {
        return TranslationResponse(
            key1: responseData["key_1"].toString(),

        );
      } else {
        throw Exception(responseData.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<void> func(List<dynamic> m, String l) async {
    List<Future<void>> translationFutures = [];

    for (var item in m) {
      translationFutures.add(translateItem(item, l));
    }

    await Future.wait(translationFutures);
  }

  Future<void> translateItem(Map<String, dynamic> item, String language) async {
    try {
      TranslationResponse translated = await translation(
        item["title"],

        language,
      );

      item["title"] = translated.key1;


      print(item["title"]);
    } catch (e) {
      print(e.toString());
      // Handle translation error, if needed
    }
  }
  Future<void> uploadImage(String image) async {emit(UserLoading());

    try {
      final file = await MultipartFile.fromFile(image);
      final formData = FormData.fromMap({'photos': file});
      final response = await DioHelper.postData(
        endpoint: 'image/upload_image',
        data: formData,
      );

      final responseData = json.decode(response.data);

      if (responseData != null && responseData.length > 0) {
        emit(UserLoaded());
        path1 = responseData[0]['path'].toString();
        print(response.data);
        print(path1);
        debugPrint('Image uploaded successfully');
      }

    } catch (e) {
      emit(UserError(e.toString()));
      debugPrint('Error uploading image: $e');
    }
  }
}

class TranslationResponse {
  final String key1;


  TranslationResponse({required this.key1});
}



