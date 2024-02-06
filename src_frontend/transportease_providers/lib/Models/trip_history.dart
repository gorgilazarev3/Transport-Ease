import 'package:firebase_database/firebase_database.dart';

class TripHistory {
  String paymentMethod;
  String createdOn;
  String status;
  String fare;
  String destination;
  String pickup;

  TripHistory(
      {required this.paymentMethod,
      required this.createdOn,
      required this.status,
      required this.fare,
      required this.destination,
      required this.pickup});

  factory TripHistory.fromSnapshot(DataSnapshot snapshot) {
    if (snapshot.value != null) {
      var data = snapshot.value as Map;
      return TripHistory(
          createdOn: data["created_at"],
          status: data["status"],
          fare: data["fare"] ?? "0",
          paymentMethod: data["payment_method"],
          destination: data["destination_address"],
          pickup: data["pickUp_address"]);
    }
    throw Exception("This trip was not recorded in our database.");
  }
}
