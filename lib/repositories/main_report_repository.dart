import 'package:highway_weight/models/main_reports_model.dart';
import 'package:highway_weight/services/main_report_service.dart';

class MainReportRepository {
  final MainReportService _service = MainReportService();
  Future<List<MainReportsModel>> getAll() async {
    try {
      final jsonData = await _service.getAllMainReports();
      final result =
          jsonData.map((json) => MainReportsModel.fromJson(json)).toList();
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }

  Future<MainReportsModel> create(int generalReportId) async {
    try {
      final jsonData = await _service.createMainReport(generalReportId);
      final result = MainReportsModel.fromJson(jsonData);
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }

  Future<MainReportsModel> changeStatus(
    int mainReportId,
    int status,
    String comment,
  ) async {
    try {
      final jsonData = await _service.changeStatus(
        mainReportId,
        status,
        comment,
      );
      final result = MainReportsModel.fromJson(jsonData);
      return result;
    } catch (e) {
      throw Exception("Failed to fetch $e");
    }
  }
}
