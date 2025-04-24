// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspector_reports_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InspectorReportsModel _$InspectorReportsModelFromJson(
  Map<String, dynamic> json,
) => InspectorReportsModel(
  id: (json['id'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  status: (json['status'] as num).toInt(),
  isVerified: (json['is_verified'] as num).toInt(),
  mainReportsModel: MainReportsModel.fromJson(
    json['main_report'] as Map<String, dynamic>,
  ),
  cameraAddress: json['camera_address'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$InspectorReportsModelToJson(
  InspectorReportsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'created_at': instance.createdAt.toIso8601String(),
  'description': instance.description,
  'camera_address': instance.cameraAddress,
  'status': instance.status,
  'is_verified': instance.isVerified,
  'main_report': instance.mainReportsModel,
};
