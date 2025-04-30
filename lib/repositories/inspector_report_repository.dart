import 'package:highway_weight/models/inspector_reports_model.dart';
import 'package:highway_weight/services/inspector_report_service.dart';

class InspectorReportRepository {
  final InspectorReportService _service = InspectorReportService();
  Future<List<InspectorReportsModel>> getAll() async {
    try {
      final jsonData = await _service.getAll();
      final result =
          jsonData.map((json) => InspectorReportsModel.fromJson(json)).toList();
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }

  Future<InspectorReportsModel> create(int mainReportId) async {
    try {
      final jsonData = await _service.create(mainReportId);
      final result = InspectorReportsModel.fromJson(jsonData);
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }

  Future<InspectorReportsModel> bookInspectorReport(
    int id,
    int status,
    String visitDate,
    String comment,
  ) async {
    try {
      final jsonData = await _service.bookInspectorReport(
        id,
        status,
        visitDate,
        comment,
      );
      final result = InspectorReportsModel.fromJson(jsonData);
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }
}
