import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rasd_app/src/features/Admin_side/complaints/bloc/state.dart';

import '../../../../core/network/api_service.dart';
import '../../../../core/network/shared_preferences.dart';
import 'Updatestatus.dart';

class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit() : super(ComplaintInitial());
  dynamic p,path,t;

  static   ComplaintsCubit get(context) => BlocProvider.of(context);
  Future<void> getComplaintsData(String lang) async {
    try {
      emit(ComplaintLoading());

      final response = await DioHelper.getData(
        endpoint: "complaint/get_complaint_info",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {},

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
      p=responseData;
      await func(p, lang);
      print(p.toString());

      emit(ComplaintLoaded());
    } catch (e) {
      emit(ComplaintsError(e.toString()));
      print(e.toString());
    }
  }
  Future<void> updateStatus(Updatestatus update) async {
    try {
      emit(ComplaintLoading());

      final response = await DioHelper.postData(endpoint: "complaint/update_complaint_status", data: update.toJson());




      if(response.statusCode==200)
        emit(ComplaintLoaded());
      else {
        emit(ComplaintsError(response.data));
      }
    } catch (e) {
      emit(ComplaintsError(e.toString()));
      print(e.toString());
    }
  }
 void fetchImage(String image) async {
    emit(ComplaintLoading());
    try {
      final response = await DioHelper.getData(
        endpoint: 'image/fetch_image',
        queryParams: {"file_path": image},
        token: CacheHelper.getData(key: "apiToken"),
      );



  path=json.decode(response.data) ;
      print(path);
      if (response.data is String) {
        emit(ComplaintLoaded());        return response.data;
      } else emit(ComplaintsError(response.data));

  } catch (e) {
  emit(ComplaintsError(e.toString()));
  print(e.toString());

    }
  }
  // Override the default locale with a specific locale


  Future<dynamic> translation( String k2, dynamic k3,
      String lang) async {
    try {
      final response = await DioHelper.postData(
        endpoint: "translation/translate_json",
        data: {
          "target_language": lang,
          "key_2": k2,
          "key_3": k3
        },
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) {
        return TranslationResponse(
            key2: responseData["key_2"].toString(),
            key3: responseData["key_3"].toString()
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
        item["description"],
        item["location"],
        language,
      );

      item["description"] = translated.key2;

      item["location"] = translated.key3;

      print(item["description"]);

    } catch (e) {
      print(e.toString());
      // Handle translation error, if needed
    }
  }}

class TranslationResponse {
  final String key2;
  String? key3;

  TranslationResponse({ required this.key2,required this.key3});
}


// emit(UserError(Error.toString()));
// print(e.toString());

