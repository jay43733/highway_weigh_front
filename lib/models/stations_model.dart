import 'package:json_annotation/json_annotation.dart';

part 'stations_model.g.dart';

@JsonSerializable()
class StationsModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'lat')
  final double lat;
  @JsonKey(name: 'long')
  final double long;

  StationsModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
  });

  factory StationsModel.fromJson(Map<String, dynamic> json) =>
      _$StationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$StationsModelToJson(this);
}
