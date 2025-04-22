import 'package:highway_weight/models/general_reports_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'main_reports_model.g.dart';

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

@JsonSerializable()
class MainReportsModel {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'general_report')
  final GeneralReportsModel generalListReport;

  @JsonKey(name: 'comment', includeIfNull: true)
  final String? comment;

  @JsonKey(name: "is_active")
  final bool isActive;

  @JsonKey(name: "created_at")
  final DateTime createdAt;

  @JsonKey(name: "status")
  final int status;

  MainReportsModel({
    required this.id,
    required this.generalListReport,
    required this.isActive,
    required this.createdAt,
    required this.status,
    this.comment,
  });

  factory MainReportsModel.fromJson(Map<String, dynamic> json) =>
      _$MainReportsModelFromJson(json);

  Map<String, dynamic> toJson()=> _$MainReportsModelToJson(this);
}
