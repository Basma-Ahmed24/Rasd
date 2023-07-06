import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:rasd_app/src/core/localization/language_state.dart';

import '../network/api_service.dart';

class TranslateCubit extends Cubit<LanguageState> {
  TranslateCubit() : super(LanguageInitial());
  Future<dynamic> translation(String k1,String k2,String lang) async {
    try {
      emit(LanguageLoading());

      final response = await DioHelper.postData(
          endpoint: "translation/translation_json",
          data:{"target_language":
          lang,"key_1":k1,
            "key_2":k2
          }
      );

      final responseData = json.decode(response.data);
      if(!responseData['error']){

        print(responseData.toString());
        emit(LanguageLoaded());}
      else {
        emit(LanguageError(response.data.toString()));
      }
    } catch (e) {
      emit(LanguageError(e.toString()));
      print(e.toString());
    }
  }
}