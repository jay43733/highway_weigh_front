import 'package:flutter/material.dart';
import 'package:highway_weight/models/stations_model.dart';
import 'package:highway_weight/styles/colors.dart';

class IssueCategory {
  static const int overWeight = 1;
  static const int improperStaff = 2;

  static String getTitle(int type) {
    switch (type) {
      case 1:
        return "ร้องเรียนรถบรรทุกน้ำหนักเกิน";
      case 2:
        return "ร้องเรียนเจ้าหน้าที่";
      default:
        return '';
    }
  }
}

class StatusType {
  static const int pending = 1;
  static const int approved = 2;
  static const int rejected = 3;

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

  static Color getColor(int type) {
    switch (type) {
      case 1:
        return AppColors.yellowColor;
      case 2:
        return AppColors.greenColor;
      case 3:
        return AppColors.redColor;
      default:
        return AppColors.yellowColor;
    }
  }
}

class GeneralListsModel {
  final int id;
  final String name;
  final int category;
  final DateTime createdAt;
  final int status;
  final StationsModel station;
  final String description;

  GeneralListsModel({
    required this.id,
    required this.name,
    required this.category,
    required this.createdAt,
    required this.description,
    required this.status,
    required this.station,
  });
}
