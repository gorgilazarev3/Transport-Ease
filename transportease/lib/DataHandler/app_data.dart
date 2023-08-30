import 'package:flutter/cupertino.dart';
import 'package:transportease/Models/address.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation;

  void updatePickupLocationAddress(Address location) {
    pickUpLocation = location;
    notifyListeners();
  }
}
