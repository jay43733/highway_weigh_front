import 'package:flutter/material.dart';
import 'package:highway_weight/models/main_reports_model.dart';
import 'package:highway_weight/repositories/main_report_repository.dart';

class MainReportsController extends ChangeNotifier {
  final MainReportRepository _repository = MainReportRepository();
  bool isLoading = false;
  List<MainReportsModel> mainReportLists = [];

  Future<void> fetchMainReports() async {
    isLoading = true;
    notifyListeners();
    try {
      mainReportLists = await _repository.getAll();
    } catch (e) {
      throw Exception("Fail to fetch get main $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createMainReports(int generalReportId) async {
    isLoading = true;
    notifyListeners();
    try {
      final newMainReport = await _repository.create(generalReportId);
      mainReportLists.add(newMainReport);
      await fetchMainReports();
    } catch (e) {
      throw Exception("Fail to fetch get main $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> approveMainReports(int mainReportId, String comment) async {
    isLoading = true;
    notifyListeners();
    try {
      if (mainReportId != 0) {
        final updateMainReport = await _repository.changeStatus(
          mainReportId,
          2,
          comment,
        );
        final index = mainReportLists.indexWhere(
          (item) => item.id == mainReportId,
        );
        if (index != -1) {
          mainReportLists[index] = updateMainReport;
        }
        await fetchMainReports();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("Fail to fetch get main $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> rejectMainReports(int mainReportId, String comment) async {
    isLoading = true;
    notifyListeners();
    try {
      if (mainReportId != 0) {
        final updateMainReport = await _repository.changeStatus(
          mainReportId,
          3,
          comment,
        );
        final index = mainReportLists.indexWhere(
          (item) => item.id == mainReportId,
        );
        if (index != -1) {
          mainReportLists[index] = updateMainReport;
        }
        await fetchMainReports();
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      throw Exception("Fail to fetch get main $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  String? validateField(String field, dynamic value) {
    if (field == 'comment') {
      if (value == '') {
        return "Please fill your comment.";
      }
    }
    return null;
  }

  void onPageChanged(int newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  int currentPage = 0;
  int itemsPerPage = 5;
  List<MainReportsModel> getPaginatedMainLists() {
    List<MainReportsModel> pendingMainLists =
        mainReportLists
          ..sort((a, b) => (b.status == 1 ? 1 : 0) - (a.status == 1 ? 1 : 0));
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return pendingMainLists.sublist(
      startIndex,
      endIndex.clamp(0, pendingMainLists.length),
    );
  }
}
