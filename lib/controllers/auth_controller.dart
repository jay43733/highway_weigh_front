import 'package:flutter/material.dart';
import 'package:highway_weight/controllers/users_controller.dart';

class AuthController extends ChangeNotifier {
  final UsersController usersController;
  AuthController({required this.usersController});
  bool showPassword = false;
  String username = '';
  String email = '';
  String password = '';
  Map<String, String> errorMessage = {};
  String alertMessage = '';
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

  bool checkEmailPassword() {
    if (email.trim() != '' && password.trim() != '') {
      final isEmailPasswordValid = usersController.users.where(
        (item) => item.email == email && item.password == password,
      );
      if (isEmailPasswordValid.isNotEmpty) {
        final selectedName = isEmailPasswordValid.single.name;
        print(selectedName);
        username = selectedName;
        alertMessage = 'Welcome to Highway Weigh !';
        notifyListeners();
        return true;
      } else {
        alertMessage = 'Email and Password are invalid';
        notifyListeners();
        return false;
      }
    } else {
      alertMessage = 'Please complete email and password before login';
      notifyListeners();
      return false;
    }
  }
}
