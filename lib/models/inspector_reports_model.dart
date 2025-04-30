import 'package:flutter/material.dart';
import 'package:highway_weight/models/main_reports_model.dart';
import 'package:highway_weight/models/users_model.dart';
import 'package:highway_weight/styles/colors.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inspector_reports_model.g.dart';

class InspectorReportStatusType {
  static int pending = 1;
  static int booked = 2;
  static int inProgress = 3;
  static int completed = 4;

  static String getTitle(int type) {
    switch (type) {
      case 1:
        return "Pending";
      case 2:
        return "Booked";
      case 3:
        return "In progress";
      case 4:
        return "Completed";
      default:
        return "";
    }
  }

  static Color getColor(int type) {
    switch (type) {
      case 1:
        return AppColors.yellowColor;
      case 2:
        return AppColors.brandPrimary;
      case 3:
        return AppColors.greyPrimary;
      case 4:
        return AppColors.greenColor;
      default:
        return AppColors.greyPrimary;
    }
  }
}

class VerifiedType {
  static int pending = 1;
  static int verified = 2;
  static int failed = 3;

  static String getTitle(int type) {
    switch (type) {
      case 1:
        return "Pending";
      case 2:
        return "Verified";
      case 3:
        return "Failed";
      default:
        return "";
    }
  }
}

@JsonSerializable()
class InspectorReportsModel {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "created_at")
  final DateTime createdAt;
  @JsonKey(name: "description", includeIfNull: true)
  final String? description;
  @JsonKey(name: "camera_address", includeIfNull: true)
  final String? cameraAddress;
  @JsonKey(name: "status")
  final int status;
  @JsonKey(name: "is_verified")
  final int isVerified;
  @JsonKey(name: "main_report")
  final MainReportsModel mainReportsModel;

  @JsonKey(name: "who_inspect", includeIfNull: true)
  final UsersModel? whoInspect;

  InspectorReportsModel({
    required this.id,
    required this.createdAt,
    required this.status,
    required this.isVerified,
    required this.mainReportsModel,
    this.cameraAddress,
    this.description,
    this.whoInspect,
  });

  factory InspectorReportsModel.fromJson(Map<String, dynamic> json) =>
      _$InspectorReportsModelFromJson(json);

  Map<String, dynamic> toJson() => _$InspectorReportsModelToJson(this);
}
