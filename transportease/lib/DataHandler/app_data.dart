import 'package:flutter/cupertino.dart';
import 'package:transportease/Models/address.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation, dropOffLocation;

  void updatePickupLocationAddress(Address location) {
    pickUpLocation = location;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address location) {
    dropOffLocation = location;
    notifyListeners();
  }
}
