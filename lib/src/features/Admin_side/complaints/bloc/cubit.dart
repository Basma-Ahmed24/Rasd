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
  Future<void> getComplaintsData() async {
    try {
      emit(ComplaintLoading());

      final response = await DioHelper.getData(
        endpoint: "complaint/get_complaint_info",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {},

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
      p=responseData;
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
  dynamic localization(dynamic loc,String lang){


      loc=Intl.message(loc,name:'fname',locale:lang);



    return loc;
  }

  Future<void> translation(String k1, String k2, String k3, String lang) async {
    try {
      emit(ComplaintLoading());

      final response = await DioHelper.postData(
        endpoint: "translation/translate_json",
        data: {
          "target_language": lang,
          "key_1": k1,
          "key_2": k2,
          "key_3": k3,
        },
      );

      final responseData = json.decode(response.data);
      if (!responseData.toString().contains("error")) {
        print(responseData.toString());
        t = responseData.toString();
        print(t);
        emit(ComplaintLoaded());

      } else {
        emit(ComplaintsError(response.data.toString()));
      }
    } catch (e) {
      emit(ComplaintsError(e.toString()));
      print(e.toString());
    }
  }

  void func(dynamic m, String l) {
    p.forEach((item) {
      // Update only the "description" and "location" fields
      if (item.containsKey("description")) {
        t = translation(item["type"], item["description"], item["location"], l);
      }
      if (item.containsKey("location")) {
        t = translation(item["type"], item["description"], item["location"], l);
      }
      if (item.containsKey("type")) {
        t = translation(item["type"], item["description"], item["location"], l);
      }
    });



  }

// emit(UserError(Error.toString()));
// print(e.toString());

}