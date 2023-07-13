import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rasd_app/src/features/User_side/complaints_form/bloc/ComplaintModel.dart';
import 'package:rasd_app/src/features/User_side/complaints_form/bloc/state.dart';

import '../../../../core/network/api_service.dart';
import '../../../../core/network/shared_preferences.dart';

class ComplaintCubit extends Cubit<ComplaintState> {
  String? path;
  String? path1;
  dynamic data;
  int totalComplaint=0;


  ComplaintCubit() : super(ComplaintState());

  static ComplaintCubit get(context) => BlocProvider.of(context);

  void fileComplaint(ComplaintModel complaint) async {
    emit(const ComplaintState(isLoading: true));
    try {
      final response = await DioHelper.postData(
        endpoint: 'complaint/file_complaint',
        data: complaint.toJson(),
      );

      final responseData = json.decode(response.data);
      if (responseData != null && responseData['fieldCount'] == 0) {
        emit(ComplaintState(isLoading: false, isSuccess: true));
      } else {
        emit(ComplaintState(
          isLoading: false,
          isSuccess: false,
          errorMessage: responseData.toString(),
        ));
      }
    } catch (e) {
      emit(ComplaintState(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> getComplaintsCount() async {
    try {
      emit(const ComplaintState(isLoading: true));


      final response = await DioHelper.getData(
        endpoint: "complaint/get_complaint_count",
        token: CacheHelper.getData(key: "apiToken"), queryParams: {
        "user_id":CacheHelper.getData(key: "apiToken")
      },

      );

      final responseData = json.decode(response.data);
      if(!responseData.toString().contains("error"))
        data=responseData;
      totalComplaint=data.fold(0,(previousValue,element)
      =>previousValue+element['count']);
      print(data.toString());

      emit(ComplaintState(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(ComplaintState(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));      print(e.toString());
    }
  }
  Future<void> uploadImage(String image) async {
    emit(const ComplaintState(isLoading: true));
    try {
      final file = await MultipartFile.fromFile(image);
      final formData = FormData.fromMap({'photos': file});
      final response = await DioHelper.postData(
        endpoint: 'image/upload_image',
        data: formData,
      );

      final responseData = json.decode(response.data);

      if (responseData != null && responseData.length > 0) {
        emit(ComplaintState(isLoading: false, isSuccess: true));
        path1 = responseData[0]['path'].toString();
        print(response.data);
        print(path1);
        debugPrint('Image uploaded successfully');
      } else {
        emit(ComplaintState(
          isLoading: false,
          isSuccess: false,
          errorMessage: responseData.toString(),
        ));
      }

    } catch (e) {
      emit(ComplaintState(
        isLoading: false,
        isSuccess: false,
        errorMessage: e.toString(),
      ));
      debugPrint('Error uploading image: $e');
    }
  }

}