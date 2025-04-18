import 'package:json_annotation/json_annotation.dart';
// dart run build_runner watch --delete-conflicting-outputs
part 'users_model.g.dart';

class UserRole {
  static int director = 1;
  static int headStations = 2;
  static int stationStaff = 3;
  static int inspector = 4;
  static int admin = 5;

  static getTitle(int type) {
    switch (type) {
      case 1:
        return "Director";
      case 2:
        return "Head of stations";
      case 3:
        return "Station staff";
      case 4:
        return "Inspector";
      case 5:
        return "Administer";
    }
  }
}

@JsonSerializable()
class UsersModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  final String? email;
  final String? password;
  final String? phoneNumber;
  @JsonKey(name: 'role')
  final int role;

  UsersModel({
    required this.id,
    required this.name,
    this.email,
    this.password,
    this.phoneNumber,
    required this.role,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) =>
      _$UsersModelFromJson(json);

  Map<String, dynamic> toJson() => _$UsersModelToJson(this);
}
