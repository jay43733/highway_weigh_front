import 'package:flutter/material.dart';
import 'package:highway_weight/models/main_reports_model.dart';

class MainReportsController extends ChangeNotifier {
  List<MainReportsModel> mainReportLists = [];

  void onPageChanged(int newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  int currentPage = 0;
  int itemsPerPage = 5;
  List<MainReportsModel> getPaginatedMainLists() {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return mainReportLists.sublist(
      startIndex,
      endIndex.clamp(0, mainReportLists.length),
    );
  }
}
