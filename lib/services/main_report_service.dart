import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class MainReportService {
  final storage = FlutterSecureStorage();
  Future<List<dynamic>> getAllMainReports() async {
    final token = await storage.read(key: 'accessToken');
    final url = Uri.parse("$baseUrl/main_reports");
    final headers = {
      "Content-Type": 'application/json',
      if (token != null) "Authorization": "Bearer $token",
    };
    try {
      print("Fetching data : $url");
      final response = await http.get(url, headers: headers);
      print("Response Status : ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        print("Erorr Status : ${response.statusCode}");
        print("Erorr Body : ${response.body}");
        final error = jsonDecode(response.body);
        return error;
      }
    } catch (e) {
      throw Exception("Failed : $e");
    }
  }

  Future<Map<String, dynamic>> createMainReport(int generalReportId) async {
    final token = await storage.read(key: 'accessToken');
    final url = Uri.parse("$baseUrl/main_reports");
    final headers = {
      "Content-Type": 'application/json',
      if (token != null) "Authorization": "Bearer $token",
    };
    final body = jsonEncode({"general_report_id": generalReportId});
    try {
      print("Fetching data : $url");
      final response = await http.post(url, headers: headers, body: body);
      print("Response Status : ${response.statusCode}");
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        print("Erorr Status : ${response.statusCode}");
        print("Erorr Body : ${response.body}");
        final error = jsonDecode(response.body);
        return error;
      }
    } catch (e) {
      throw Exception("Failed : $e");
    }
  }
}
