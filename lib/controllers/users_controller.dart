import 'package:flutter/material.dart';
import 'package:highway_weight/models/users_model.dart';

class UsersController extends ChangeNotifier {
  List<UsersModel> users = [
    UsersModel(
      id: 1,
      name: "Jay Director",
      email: "user1@gmail.com",
      password: "12345678",
      phoneNumber: "0812345678",
      role: 1,
    ),

    UsersModel(
      id: 2,
      name: "Sarah Head Stations",
      email: "user2@gmail.com",
      password: "12345678",
      phoneNumber: "0823456789",
      role: 2,
    ),

    UsersModel(
      id: 3,
      name: "Mike Staff",
      email: "user3@gmail.com",
      password: "12345678",
      phoneNumber: "0834567890",
      role: 3,
    ),
    UsersModel(
      id: 4,
      name: "Lisa Inspector",
      email: "user4@gmail.com",
      password: "12345678",
      phoneNumber: "0845678901",
      role: 4,
    ),

    UsersModel(
      id: 5,
      name: "Robert Admin",
      email: "user5@gmail.com",
      password: "12345678",
      phoneNumber: "0856789012",
      role: 5,
    ),
    UsersModel(
      id: 6,
      name: "Emma Davis",
      email: "emma.d@highway.com",
      password: "inspect456",
      phoneNumber: "0867890123",
      role: 4,
    ),
    UsersModel(
      id: 7,
      name: "James Rodriguez",
      email: "james.r@highway.com",
      password: "inspect789",
      phoneNumber: "0878901234",
      role: 4,
    ),

    UsersModel(
      id: 8,
      name: "Alex Smith",
      email: "alex.admin@highway.com",
      password: "admin1234",
      phoneNumber: "0889012345",
      role: 5,
    ),

    UsersModel(
      id: 9,
      name: "Olivia Brown",
      email: "olivia.b@highway.com",
      password: "staffpass3",
      phoneNumber: "0890123456",
      role: 3,
    ),
    UsersModel(
      id: 10,
      name: "Daniel Lee",
      email: "daniel.l@highway.com",
      password: "headpass123",
      phoneNumber: "0801234567",
      role: 2,
    ),
  ];
}
