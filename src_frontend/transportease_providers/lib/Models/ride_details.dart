import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideDetails {
  String pickUpAddress;

  String destinationAddress;
  LatLng destinationLocation;
  LatLng pickUpLocation;
  String paymentMethod;
  String rideRequestId;
  String riderName;
  String riderPhone;

  RideDetails(
      {required this.pickUpAddress,
      required this.destinationAddress,
      required this.destinationLocation,
      required this.pickUpLocation,
      required this.paymentMethod,
      required this.rideRequestId,
      required this.riderName,
      required this.riderPhone});
}
