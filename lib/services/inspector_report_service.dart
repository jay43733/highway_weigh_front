import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class InspectorReportService {
  final storage = FlutterSecureStorage();
  Future<Map<String, dynamic>> create(int mainReportId) async {
    final token = await storage.read(key: "accessToken");
    final url = Uri.parse("$baseUrl/inspector_reports");
    final headers = {
      "Content-Type": 'application/json',
      if (token != null) "Authorization": "Bearer $token",
    };
    final body = {
      {"main_report_id": mainReportId},
    };
    print("Fetching data : $url");
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 201) {
        print("Response Status : ${response.statusCode}");
        final data = jsonDecode(response.body);
        return data;
      } else {
        print("Error Status : ${response.statusCode}");
        throw Exception("Error Body : ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed : $e");
    }
  }

  Future<List<dynamic>> getAll() async {
    final token = await storage.read(key: "accessToken");
    final url = Uri.parse("$baseUrl/inspector_reports");
    final headers = {
      "Content-Type": 'application/json',
      if (token != null) "Authorization": "Bearer $token",
    };

    print("Fetching data : $url");
    try {
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        print("Response Status : ${response.statusCode}");
        final data = jsonDecode(response.body);
        return data;
      } else {
        print("Error Status : ${response.statusCode}");
        throw Exception("Error Body : ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed : $e");
    }
  }
}
