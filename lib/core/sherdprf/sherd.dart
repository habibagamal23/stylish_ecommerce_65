import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<String?> getLanguage() async {
    debugPrint('SharedPrefHelper :  get data  language');

    return _preferences.getString("language");
  }

  static Future<void> setLanguage(String languageCode) async {
    debugPrint('SharedPrefHelper :set  data : language ');

    await _preferences.setString("language", languageCode);
  }

  static Future<int> getTheme() async {
    debugPrint('SharedPrefHelper : get  data them :');

    return _preferences.getInt("them") ?? 0;
  }

  static Future<void> setTheme(int themeindex) async {
    debugPrint('SharedPrefHelper : set data them');
    await _preferences.setInt("them", themeindex);
  }

  static Future<void> setToken(String token) async {
    debugPrint('SharedPrefHelper : set data token');

    await _preferences.setString('auth_token', token);
  }

  static int? getid() {
    return _preferences.getInt('user_id');
  }

  static Future<void> setid(int id) async {
    debugPrint('SharedPrefHelper : set data token');

    await _preferences.setInt('user_id', id);
  }

  static String? getToken() {
    return _preferences.getString('auth_token');
  }

  static Future<void> clearToken() async {
    await _preferences.remove('auth_token');
  }

  static clearAllData() async {
    debugPrint('SharedPrefHelper : all data has been cleared');
    await _preferences.clear();
  }
}
