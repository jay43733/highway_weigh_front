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

class UsersModel {
  final int id;
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final int role;

  UsersModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.role,
  });
}
