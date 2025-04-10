import 'package:flutter/material.dart';
import 'package:highway_weight/models/main_lists_model.dart';

class MainListsController extends ChangeNotifier {
  List<MainListsModel> mainReportLists = [];

  void onPageChanged(int newPage) {
    currentPage = newPage;
    notifyListeners();
  }

  int currentPage = 0;
  int itemsPerPage = 5;
  List<MainListsModel> getPaginatedMainLists() {
    int startIndex = currentPage * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    return mainReportLists.sublist(
      startIndex,
      endIndex.clamp(0, mainReportLists.length),
    );
  }
}
