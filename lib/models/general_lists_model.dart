import 'package:flutter/material.dart';
import 'package:highway_weight/models/stations_model.dart';
import 'package:highway_weight/models/users_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:json_annotation/json_annotation.dart';

part 'general_lists_model.g.dart';

class IssueCategory {
  static const int overWeight = 1;
  static const int improperStaff = 2;

  static String getTitle(int type) {
    switch (type) {
      case 1:
        return "รถบรรทุกน้ำหนักเกิน";
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

@JsonSerializable()
class GeneralReportsModel {
  @JsonKey(name: 'id')
  final int id;

  // @JsonKey(name: "who_created")
  // final UsersModel? whoCreated;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "issue_type")
  final int category;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'edited_at')
  final DateTime? updatedAt;

  @JsonKey(name: 'status')
  final int status;

  @JsonKey(name: 'station')
  final StationsModel station;

  @JsonKey(name: 'detail')
  final String description;

  @JsonKey(name: "image")
  final String? image;

  @JsonKey(name: 'imageUrl')
  final String imageUrl;

  @JsonKey(name: 'is_active')
  final bool isActive;

  GeneralReportsModel({
    required this.id,
    // this.whoCreated,
    required this.name,
    required this.category,
    required this.createdAt,
    required this.description,
    required this.status,
    required this.station,
    required this.isActive,
    this.updatedAt,
    this.image,
    required this.imageUrl,
  });

  factory GeneralReportsModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralReportsModelFromJson(json);

  Map<String, dynamic> toJson() => _$GeneralReportsModelToJson(this);
}
