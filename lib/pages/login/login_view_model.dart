import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/database_helper.dart';

class LoginViewModel extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Future<bool> login(String email, String password) async {
    final registration = await _databaseHelper.loginByEmail(email);
    if (registration != null && registration.password == password) {
      final preferences = await prefs;
      await preferences.setString('userEmail', email);
      return true;
    } else {
      return false;
    }
  }

  bool isValidEmail(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }
}
