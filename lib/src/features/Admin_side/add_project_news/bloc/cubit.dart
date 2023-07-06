
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/features/Admin_side/add_project_news/bloc/Projectnewsmodel.dart';
import 'package:rasd_app/src/features/Admin_side/add_project_news/bloc/state.dart';

import '../../../../core/network/api_service.dart';
import '../../../../core/network/shared_preferences.dart';

class ProjNewsCubit extends Cubit<ProjNewsState> {
  ProjNewsCubit() : super(projnewsInitial());
dynamic p;
dynamic projects;
dynamic project;
dynamic news;
dynamic t;
  dynamic comments;
  var k=0;

  Future<void> addProjNewsData(Projectnewsmodel projnewsmodel) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.postData(endpoint: "projnews/add_projnews",
          data:
      projnewsmodel.toJson());
      final responseData = json.decode(response.data);
      if( responseData != null && responseData['fieldCount'] == 0)


      emit(projnewsLoaded());
else {
  emit(projnewsError(response.data));
}
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }
  static   ProjNewsCubit get(context) => BlocProvider.of(context);
  Future<void> getNewsData() async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {
          "proj_or_news":"news"
      },

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
        p=responseData;
      print(p.toString());

      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> getNewsDataWithId(int id) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {
        "proj_or_news":"news",
        "proj_news_id":id
      },

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
        news=responseData;
      print(news.toString());

      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> getProjrctData() async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {
        "proj_or_news":"proj",

      },

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
        projects=responseData;
      print(projects.toString());

      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }
// emit(UserError(Error.toString()));
// print(e.toString());
  Future<void> getProjrctDataWithId(int id) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "projnews/get_projnews_info",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {
        "proj_or_news":"proj",
        "proj_news_id":id

      },

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
        project=responseData;
      print(project.toString());

      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> PostComment(int cid,var rid,String comment) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.postData(
        endpoint: "comments/add_comment",
        data: {
          "user_id":CacheHelper.getData(key: "apiToken") ,
          "proj_news_id": cid,
          "reply_to_comment_id": rid,
          "comment_body": comment
        },
      );

      final responseData = json.decode(response.data);
      if( responseData != null && responseData['fieldCount'] == 0){

print(responseData.toString());
        emit(projnewsLoaded());}
      else {
        emit(projnewsError(response.data.toString()));
      }
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> getAllComments(int id) async {
    try {
      emit(projnewsLoading());

      final response = await DioHelper.getData(
        endpoint: "comments/get_comments_on_projnews",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {
        "proj_news_id":id
      },

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
        comments=responseData;
      print(comments.toString());

      emit(projnewsLoaded());
    } catch (e) {
      emit(projnewsError(e.toString()));
      print(e.toString());
    }
  }


  Future<dynamic> translation(String k1, String k2, String lang) async {
    try {
      final response = await DioHelper.postData(
        endpoint: "translation/translate_json",
        data: {
          "target_language": lang,
          "key_1": k1,
          "key_2": k2,
        },
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) {
        return TranslationResponse(
          key1: responseData["key_1"].toString(),
          key2: responseData["key_2"].toString(),
        );
      } else {
        throw Exception(responseData.toString());
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void func(dynamic m, String l) async {

    for (var item in m) {

        try {
          TranslationResponse translatedDescription =
          await translation(item["title"], item["description"], l);
          item["description"] = translatedDescription.key2;
          item["title"] = translatedDescription.key1;
          print(item["description"]);
          print(item["title"]);
        } catch (e) {
          print(e.toString());
          // Handle translation error, if needed
        }



    }
  }
}
class TranslationResponse {
  final String key1;
  final String key2;

  TranslationResponse({required this.key1, required this.key2});
}