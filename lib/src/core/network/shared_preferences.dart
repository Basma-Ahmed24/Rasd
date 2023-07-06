import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolan(
      {required String key, required bool value}) async {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences!.get(key);
  }static Future setBoolean(String key, bool value) async => await sharedPreferences!.setBool(key, value);

  static Future<bool> setDouble(String key, double value) async => await sharedPreferences!.setDouble(key, value);

  static Future<bool> setInt(String key, int value) async => await sharedPreferences!.setInt(key, value);

  static Future<bool> setString(String key, String value) async => await sharedPreferences!.setString(key, value);

  static Future<bool> setStringList(String key, List<String> value) async => await sharedPreferences!.setStringList(key, value);

  //gets

  static bool getBoolean(String key) => sharedPreferences!.getBool(key) ?? false;

  static double getDouble(String key) => sharedPreferences!.getDouble(key) ?? 0.0;

  static int getInt(String key) => sharedPreferences!.getInt(key) ?? 0;

  static String getString(String key) => sharedPreferences!.getString(key) ?? 'N/A';

  static List<String> getStringList(String key) => sharedPreferences!.getStringList(key) ?? [];

  //deletes..
  static Future<bool> remove(String key) async => await sharedPreferences!.remove(key);

  static void clearPref() {
    sharedPreferences!.clear();
  }



static Future<bool> savedata(
      {required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

}