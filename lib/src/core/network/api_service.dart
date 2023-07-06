
import 'package:dio/dio.dart';
import 'package:rasd_app/src/core/network/shared_preferences.dart';
class DioHelper{
  static Dio ?dio;
  static init(){
    dio=Dio(BaseOptions(
        baseUrl:"http://18.197.86.8/",
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json'
        }


    ));
  }

  // static Future <Response>patchData({}){

//}
  static Future<Response> getData({
    required String endpoint,
    required String token,
    required Map<String, dynamic> queryParams,
  }) async {
    dio?.options.headers = {
      'Authorization': token,
    };
    return dio!.get(endpoint, queryParameters:queryParams);
  }
  static Future <Response>postData({
    required String endpoint,
    String ?token,
    dynamic data,

  })async{
    dio?.options.headers={
      'Authorization': token,

    };
    return dio!.post(endpoint,data:data);
  }

  static Future <Response>patchData({
    required String endpoint,
    String ?token,
    required Map<String,dynamic>data
  })async{
    dio?.options.headers={
      'Authorization': "Bearer ${CacheHelper.getData(key: "apiToken")}",

    };
    return dio!.patch(endpoint,data: data);
  }
}