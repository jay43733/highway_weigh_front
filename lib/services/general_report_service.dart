import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:highway_weight/constants/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

class GeneralReportService {
  final storage = FlutterSecureStorage();
  Future<List<dynamic>> getAllGeneralReports() async {
    final token = await storage.read(key: 'accessToken');
    final url = Uri.parse("$baseUrl/general_reports");
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
        final errorBody = jsonDecode(response.body);
        print("Error from ${errorBody}");
      }
    } catch (e) {
      throw Exception("Failed: $e");
    }
    throw Exception("Failed to fetch $url");
  }

  String generateUniqueImageName(String file) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final random = Random().nextInt(1000000000);
    final extension = p.extension(file).toLowerCase();
    print('New name :$timestamp-$random$extension');
    return '$timestamp-$random$extension';
  }

  Future<Map<String, dynamic>> createGeneralReport(
    String name,
    String detail,
    String issueType,
    String stationId,
    Uint8List image,
    String imageFileName,
  ) async {
    final token = await storage.read(key: "accessToken");
    if (token == null) {
      throw Exception("No access token found");
    }
    final url = Uri.parse("$baseUrl/general_reports");
    print("Fetching data $url");
    final mimeType = lookupMimeType(imageFileName, headerBytes: image);
    final mediaType = MediaType.parse(mimeType ?? "application/octet-stream");
    try {
      final request = http.MultipartRequest("POST", url);

      request.headers['Authorization'] = 'Bearer $token';

      final generatedName = generateUniqueImageName(imageFileName);
      request.files.add(
        http.MultipartFile.fromBytes(
          'image',
          image,
          filename: generatedName,
          contentType: mediaType,
        ),
      );
      request.fields['name'] = name;
      request.fields['detail'] = detail;
      request.fields['issue_type'] = issueType;
      request.fields['station_id'] = stationId;

      final fields = await request.send();
      final response = await http.Response.fromStream(fields);
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        print("Create Status code : ${response.statusCode}");
        print("Create Body: ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed: $e");
    }
    throw Exception("Failed to fetch $url");
  }

  Future<Map<String, dynamic>> updateGeneralReport(
    int reportId,
    String name,
    String detail,
    String issueType,
    String stationId,
    Uint8List? image,
    String? imageFileName,
  ) async {
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      throw Exception("No access token found");
    }
    final url = Uri.parse("$baseUrl/general_reports/$reportId");

    print("Fetching data $url");
    try {
      final request = http.MultipartRequest("PATCH", url);
      request.headers['Authorization'] = 'Bearer $token';

      if (image != null && imageFileName != null && image.isNotEmpty) {
        final mimeType = lookupMimeType(imageFileName, headerBytes: image);
        final mediaType = MediaType.parse(
          mimeType ?? "application/octet-stream",
        );
        final generatedName = generateUniqueImageName(imageFileName);

        request.files.add(
          http.MultipartFile.fromBytes(
            'image',
            image,
            filename: generatedName,
            contentType: mediaType,
          ),
        );
      }

      request.fields['name'] = name;
      request.fields['detail'] = detail;
      request.fields['issue_type'] = issueType;
      request.fields['station_id'] = stationId;

      final fields = await request.send();
      final response = await http.Response.fromStream(fields);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        return jsonData;
      } else {
        print("Update Status code : ${response.statusCode}");
        print("Update Body: ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed: $e");
    }
    throw Exception("Failed to fetch $url");
  }

  Future<Map<String, dynamic>> deactivateGeneralReport(int reportId) async {
    final token = await storage.read(key: 'accessToken');
    if (token == null) {
      throw Exception("No access token found");
    }
    final url = Uri.parse("$baseUrl/general_reports/$reportId");
    final headers = {
      "Content-Type": 'application/json',
      "Authorization": "Bearer $token",
    };
    final body = jsonEncode({'is_active': false});
    print("Fetching Url : $url ");
    try {
      final response = await http.patch(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final jsonData = await jsonDecode(response.body);
        print("Status: ${response.statusCode}");
        print("Body: ${response.body}");
        return jsonData;
      } else {
        print("Status: ${response.statusCode}");
        throw Exception("Error Body: ${response.body}");
      }
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }
}
