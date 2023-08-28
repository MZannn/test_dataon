import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/database_helper.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  Future<bool> changePassword(String email, String newPassword) async {
    try {
      await databaseHelper.updatePasswordByEmail(email, newPassword);
      return true;
    } catch (error) {
      return false;
    }
  }
}
