import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AppUser {
  String id;
  String email;
  String name;
  String phone;
  String type;

  AppUser(
      {required this.id,
      required this.email,
      required this.name,
      required this.phone,
      required this.type});

  factory AppUser.fromSnapshot(DataSnapshot dataSnapshot) {
    if (dataSnapshot != null) {
      var data = dataSnapshot.value as Map;
      if (data != null) {
        return AppUser(
            id: dataSnapshot.key!,
            email: data["email"],
            name: data["name"],
            phone: data["phone"],
            type: data["type"]);
      }
    }
    throw Exception("AppUser not found");
  }
}
