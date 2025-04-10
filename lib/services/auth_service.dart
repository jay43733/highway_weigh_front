import 'dart:convert';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/auths/login");
    final headers = {"Content-Type": 'application/json'};
    final body = jsonEncode({'email': email, 'password': password});
    try {
      print("Fetching Url : $url ");
      final response = await http.post(url, headers: headers, body: body);
      print("Response Body: ${response.statusCode}");
      if (response.statusCode == 201) {
        print("Response Body: ${response.body}");
        final data = jsonDecode(response.body);
        print("Return data : $data ");
        return data;
      } else {
        final errorBody = jsonDecode(response.body);
        throw Exception(
          "Failed: ${response.statusCode}, Message: ${errorBody['message'] ?? 'Unknown'}",
        );
      }
    } catch (e) {
      throw Exception("Failed to fetch : $e");
    }
  }
}
