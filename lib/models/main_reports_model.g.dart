// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_reports_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainReportsModel _$MainReportsModelFromJson(Map<String, dynamic> json) =>
    MainReportsModel(
      id: (json['id'] as num).toInt(),
      generalListReport: GeneralReportsModel.fromJson(
        json['general_report'] as Map<String, dynamic>,
      ),
      isActive: json['is_active'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      status: (json['status'] as num).toInt(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$MainReportsModelToJson(MainReportsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'general_report': instance.generalListReport,
      'comment': instance.comment,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
      'status': instance.status,
    };
