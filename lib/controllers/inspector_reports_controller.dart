import 'package:flutter/material.dart';
import 'package:highway_weight/models/inspector_reports_model.dart';
import 'package:highway_weight/repositories/inspector_report_repository.dart';

class InspectorReportsController extends ChangeNotifier {
  final InspectorReportRepository _repository = InspectorReportRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<InspectorReportsModel> inspectorReportsLists = [];

  Future<void> fetchInspectorReport() async {
    _isLoading = true;
    notifyListeners();
    try {
      inspectorReportsLists = await _repository.getAll();
    } catch (e) {
      throw Exception("Fail to fetch get Inspec $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void onPageChanged(int newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  int currentPage = 0;
  int itemsPerPage = 5;
  List<InspectorReportsModel> getPaginatedMainLists() {
    List<InspectorReportsModel> pendingMainLists =
        inspectorReportsLists
          ..sort((a, b) => (b.status == 1 ? 1 : 0) - (a.status == 1 ? 1 : 0));
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return pendingMainLists.sublist(
      startIndex,
      endIndex.clamp(0, pendingMainLists.length),
    );
  }
}
