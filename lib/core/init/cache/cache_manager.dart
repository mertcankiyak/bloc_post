import 'package:bloc_post/product/enums/preferences_key.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static final CacheManager _instance = CacheManager._init();

  SharedPreferences? _preferences;
  static CacheManager get instance => _instance;

  CacheManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static Future prefrencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setStringValue(
      {required PreferencesKey key, required String value}) async {
    await _preferences!.setString(key.toString(), value);
  }

  String getStringValue({required PreferencesKey key}) =>
      _preferences?.getString(key.toString()) ?? '';
}
