// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'general_lists_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeneralReportsModel _$GeneralReportsModelFromJson(Map<String, dynamic> json) =>
    GeneralReportsModel(
      id: (json['id'] as num).toInt(),
      whoCreated:
          json['who_created'] == null
              ? null
              : UsersModel.fromJson(
                json['who_created'] as Map<String, dynamic>,
              ),
      name: json['name'] as String,
      category: (json['issue_type'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      description: json['detail'] as String,
      status: (json['status'] as num).toInt(),
      station: StationsModel.fromJson(json['station'] as Map<String, dynamic>),
      isActive: json['is_active'] as bool,
      updatedAt:
          json['edited_at'] == null
              ? null
              : DateTime.parse(json['edited_at'] as String),
      image: json['image'] as String?,
      imageUrl: json['imageUrl'] as String,
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$GeneralReportsModelToJson(
  GeneralReportsModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'who_created': instance.whoCreated,
  'name': instance.name,
  'issue_type': instance.category,
  'created_at': instance.createdAt.toIso8601String(),
  'edited_at': instance.updatedAt?.toIso8601String(),
  'status': instance.status,
  'station': instance.station,
  'detail': instance.description,
  'image': instance.image,
  'comment': instance.comment,
  'imageUrl': instance.imageUrl,
  'is_active': instance.isActive,
};
