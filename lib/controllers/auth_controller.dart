import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:highway_weight/repositories/auth_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthRepository _authRepos = AuthRepository();
  final storage = FlutterSecureStorage();

  bool _isLoading = false;
  String? _user;
  String? _id;
  String? get id => _id;
  String? role;
  bool get isLoading => _isLoading;
  String? get user => _user;
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

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _authRepos.login(email, password);
      _user = response.name;
      _id = response.id.toString();
      role = response.role.toString();
      alertMessage = 'Welcome to Highway Weigh !';
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      String errorMsg = e.toString();
      if (errorMsg.contains('Message:')) {
        alertMessage = errorMsg.split("Message:").last.trim();
      } else {
        alertMessage = "Login failed. Please try again.";
      }
      _isLoading = false;
      notifyListeners();
    }
  }

  String? getStorage(String field, String data) {
    if (field == "role") {
      role = data;
    }
    if (field == "user") {
      _user = data;
    }
    if (field == "id") {
      _id = data;
    }
    notifyListeners();
    return null;
  }

  Future<void> logout() async {
    _isLoading = true;
    _user = '';
    role = '';
    await storage.deleteAll();
    notifyListeners();
  }
}
