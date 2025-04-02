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

  String? validateField(String field, String? value) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (field == 'email') {
      if (value!.trim().isEmpty) {
        return "Email is required";
      }
      if (!emailRegex.hasMatch(value)) {
        return "Please input email format.";
      }
    }
    if (field == 'password') {
      if (value!.trim().isEmpty) {
        return "Password is required.";
      }
      if (value.trim().length < 8) {
        return "Password must contain at least 8 characters.";
      }
    }
    return null;
  }
}
