import 'package:highway_weight/models/general_lists_model.dart';

class StatusType {
  static int pending = 1;
  static int approved = 2;
  static int rejected = 3;

  static String getTitle(int type) {
    switch (type) {
      case 1:
        return "Pending";
      case 2:
        return "Approved";
      case 3:
        return "Rejected";
      default:
        return "";
    }
  }
}

class MainListsModel {
  final int id;
  final GeneralReportsModel generalListReport;
  final String? comment;
  final bool isActive;
  final DateTime createdAt;
  final int status;

  MainListsModel({
    required this.id,
    required this.generalListReport,
    required this.isActive,
    required this.createdAt,
    required this.status,
    this.comment,
  });
}
