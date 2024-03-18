import 'package:flutter/material.dart';
import 'package:lipread/utilities/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider with ChangeNotifier {
  late SharedPreferences _preferences;

  late bool _isLoggedIn;
  String? _userId;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    _isLoggedIn =
        _preferences.getBool(SharedPreferencesKeys.isLoggedIn) ?? false;
    _userId = _preferences.getString(SharedPreferencesKeys.userId);
  }

  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _userId;

  Future<void> setLoggedIn(bool isLoggedIn) async {
    _isLoggedIn = isLoggedIn;
    await _preferences.setBool(SharedPreferencesKeys.isLoggedIn, isLoggedIn);
    notifyListeners();
  }

  Future<void> setUserId(String userId) async {
    _userId = userId;
    await _preferences.setString(SharedPreferencesKeys.userId, userId);
    notifyListeners();
  }
}
