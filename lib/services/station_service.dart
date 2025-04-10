import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:highway_weight/constants/app_constants.dart';
import "package:http/http.dart" as http;

class StationService {
  final storage = FlutterSecureStorage();
  Future<List<dynamic>> getAllStations() async {
    final token = await storage.read(key: 'accessToken');
    final url = Uri.parse('$baseUrl/stations');
    final headers = {
      "Content-Type": 'application/json',
      if (token != null) "Authorization": "Bearer $token",
    };
    try {
      print("Fetching data : $url");
      final response = await http.get(url, headers: headers);
      print("Status Code : ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        print("Error Message : ${response.body}");
        print("Error code : ${response.statusCode}");
        throw Exception("Error code : ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to featch $e");
    }
  }
}
