import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  bool showPassword = false;
  String email = '';
  String password = '';
  Map<String, String> errorMessage = {};
  void setShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void setFieldValue(String field, String value) {
    if (field == 'email') {
      email = value;
    }

    if (field == 'password') {
      password = value;
    }
  }

  String? validateField(String field, String value) {
    Map<String, String> error = Map.from(errorMessage);
    if (field == "email" && value == '') {
      error['email'] = "Email is required";
    }
    if (field == "password" && value == '') {
      error['password'] = "Password is required";
    }
    return null;
  }
}
