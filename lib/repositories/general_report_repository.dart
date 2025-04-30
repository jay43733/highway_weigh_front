import 'dart:typed_data';
import 'package:highway_weight/models/general_reports_model.dart';
import 'package:highway_weight/services/general_report_service.dart';

class GeneralReportRepository {
  final GeneralReportService _service = GeneralReportService();

  Future<List<GeneralReportsModel>> getAll() async {
    try {
      final jsonData = await _service.getAllGeneralReports();
      final result =
          jsonData.map((json) => GeneralReportsModel.fromJson(json)).toList();
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }

  Future<GeneralReportsModel> create(
    String name,
    String detail,
    String issueType,
    String stationId,
    Uint8List image,
    String imageFileName,
    String reportedDate,
  ) async {
    try {
      final jsonData = await _service.createGeneralReport(
        name,
        detail,
        issueType,
        stationId,
        image,
        imageFileName,
        reportedDate,
      );
      final result = GeneralReportsModel.fromJson(jsonData);
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }

  Future<GeneralReportsModel> deactivate(int reportId) async {
    try {
      final jsonData = await _service.deactivateGeneralReport(reportId);
      final result = GeneralReportsModel.fromJson(jsonData);
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }

  Future<GeneralReportsModel> update(
    int reportId,
    String name,
    String detail,
    String issueType,
    String stationId,
    Uint8List? image,
    String? imageFileName,
  ) async {
    try {
      final jsonData = await _service.updateGeneralReport(
        reportId,
        name,
        detail,
        issueType,
        stationId,
        image,
        imageFileName,
      );
      final result = GeneralReportsModel.fromJson(jsonData);
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }

  Future<GeneralReportsModel> changeStatus(
    int reportId,
    int status,
    String comment,
    String? visitDate,
  ) async {
    try {
      final jsonData = await _service.changeReportStatus(
        reportId,
        status,
        comment,
        visitDate,
      );
      final result = GeneralReportsModel.fromJson(jsonData);
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }
}
