import 'package:firebase_database/firebase_database.dart';

class Driver {
  String name;
  String phone;
  String email;
  String id;
  String car_color;
  String car_model;
  String license_plate;

  Driver(
      {required this.name,
      required this.phone,
      required this.email,
      required this.id,
      required this.car_color,
      required this.car_model,
      required this.license_plate});

  factory Driver.fromSnapshot(DataSnapshot snapshot) {
    if (snapshot.value != null) {
      var data = snapshot.value as Map;
      return Driver(
          car_color: data["provider_details"]["car_color"],
          car_model: data["provider_details"]["car_model"],
          license_plate: data["provider_details"]["license_plate"],
          email: data["email"],
          phone: data["phone"],
          id: snapshot.key.toString(),
          name: data["name"]);
    }
    throw Exception("Driver not found");
  }
}
