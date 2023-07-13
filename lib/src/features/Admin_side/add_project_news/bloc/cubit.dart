import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/features/Admin_side/add_project_news/bloc/state.dart';
import '../../../../core/network/api_service.dart';
import '../../../../core/network/shared_preferences.dart';
import 'Projectsnewsmodel.dart';
class ProjNewsCubit extends Cubit<ProjNewsState> {
  ProjNewsCubit() : super(projnewsInitial());
  dynamic p;
  dynamic projects;
  dynamic project;
  dynamic news;
  dynamic t;
  dynamic comments;
  dynamic path1;
  var k = 0;
  Future<void> addProjNewsData(Projectsnewsmodel projnewsmodel) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.postData(
          endpoint: "projnews/add_projnews", data: projnewsmodel.toJson());
      final responseData = json.decode(response.data);
      if (responseData != null && responseData['fieldCount'] == 0)
        emit(projnewsLoaded());
      else {
        emit(projnewsError(response.data));
      }
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }

  static ProjNewsCubit get(context) => BlocProvider.of(context);

  Future<void> getNewsData(String lang) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"),
        queryParams: {"proj_or_news": "news"},
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) p = responseData;

      await func(p, lang);


      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }

  Future<void> getNewsDataWithId(int id, String lang) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"),
        queryParams: {"proj_or_news": "news", "proj_news_id": id},
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) news = responseData;
      await func(news, lang);
      print(news.toString());

      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> uploadImage(String image) async {
    emit(projnewsLoading());
    try {
      final file = await MultipartFile.fromFile(image);
      final formData = FormData.fromMap({'photos': file});
      final response = await DioHelper.postData(
        endpoint: 'image/upload_image',
        data: formData,
      );

      final responseData = json.decode(response.data);

      if (responseData != null && responseData.length > 0) {
        emit(projnewsLoaded());
        path1 = responseData[0]['path'].toString();
        print(response.data);
        print(path1);
        debugPrint('Image uploaded successfully');
      }

    } catch (e) {
      emit(projnewsError(e.toString()));

      debugPrint('Error uploading image: $e');
    }
  }
  Future<void> getProjrctData(String lang) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"),
        queryParams: {
          "proj_or_news": "proj",
        },
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) projects = responseData;
      await func(projects, lang);

      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
    }
  }

  Future<void> getProjrctDataWithId(int id, String lang) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"),
        queryParams: {"proj_or_news": "proj", "proj_news_id": id},
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) project = responseData;
      await func(project, lang);
      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
    }
  }

  Future<void> PostComment(int cid, var rid, String comment) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.postData(
        endpoint: "comments/add_comment",
        data: {
          "user_id": CacheHelper.getData(key: "apiToken"),
          "proj_news_id": cid,
          "reply_to_comment_id": rid,
          "comment_body": comment
        },
      );

      final responseData = json.decode(response.data);
      if (responseData != null && responseData['fieldCount'] == 0) {
        emit(projnewsLoaded());
      } else {
        emit(projnewsError(response.data.toString()));
      }
    } catch (e) {
      emit(projnewsError(e.toString()));
    }
  }

  Future<void> getAllComments(int id) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "comments/get_comments_on_projnews",
        token: CacheHelper.getData(key: "apiToken"),
        queryParams: {"proj_news_id": id},
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) comments = responseData;

      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
    }
  }

  Future<dynamic> translation(
      String k1, String k2, dynamic k3, String lang) async {
    try {
      final response = await DioHelper.postData(
        endpoint: "translation/translate_json",
        data: {"target_language": lang, "key_1": k1, "key_2": k2, "key_3": k3},
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) {
        return TranslationResponse(
            key1: responseData["key_1"].toString(),
            key2: responseData["key_2"].toString(),
            key3: responseData["key_3"].toString());
      } else {
        throw Exception(responseData.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> func(dynamic m, String l) async {
    List<Future<void>> translationFutures = [];
    if (m != null) {
      for (var item in m) {
        translationFutures.add(translateItem(item, l));
      }

      await Future.wait(translationFutures);
    }
  }
  Future<void> translateItem(Map<String, dynamic> item, String language) async {
    try {
      TranslationResponse translated = await translation(
        item["title"],
        item["description"],
        item["location"],
        language,
      );

      item["description"] = translated.key2;
      item["title"] = translated.key1;
      item["location"] = translated.key3;
    } catch (e) {
      print(e.toString());
      // Handle translation error, if needed
    }
  }
}

class TranslationResponse {
  final String key1;
  final String key2;
  String? key3;

  TranslationResponse({required this.key1, required this.key2, this.key3});
}
