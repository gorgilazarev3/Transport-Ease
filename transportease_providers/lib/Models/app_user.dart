import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AppUser {
  String id;
  String email;
  String name;
  String phone;
  String role;

  AppUser(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      required this.role});

  factory AppUser.fromSnapshot(DataSnapshot dataSnapshot) {
    if (dataSnapshot != null) {
      var data = dataSnapshot.value as Map;
      if (data != null) {
        return AppUser(
            id: dataSnapshot.key!,
            email: data["email"],
            name: data["name"],
            phone: data["phone"],
            role: data["role"]);
      }
    }
    throw Exception("AppUser not found");
  }
}
