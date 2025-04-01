import 'package:flutter/material.dart';
import 'package:highway_weight/controllers/general_lists_controller.dart';
import 'package:highway_weight/models/main_lists_model.dart';

class MainListsController extends ChangeNotifier {
  final GeneralListsController generalListsController;
  List<MainListsModel> mainReportLists = [];
  MainListsController({required this.generalListsController}) {
    _init();
  }

  void _init() {
    int id = 1;
    final approvedLists =
        generalListsController.generalReportLists
            .where((item) => item.status == 2)
            .toList();

    mainReportLists =
        approvedLists.map((item) {
          return MainListsModel(
            id: id++,
            generalListReport: item,
            isActive: true,
            createdAt: DateTime.now(),
            status: 1,
          );
        }).toList();

    notifyListeners();
  }

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
