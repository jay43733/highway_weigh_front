// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationsModel _$StationsModelFromJson(Map<String, dynamic> json) =>
    StationsModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      lat: (json['lat'] as num).toDouble(),
      long: (json['long'] as num).toDouble(),
    );

Map<String, dynamic> _$StationsModelToJson(StationsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'lat': instance.lat,
      'long': instance.long,
    };
