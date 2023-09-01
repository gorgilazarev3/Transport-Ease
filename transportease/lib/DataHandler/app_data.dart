import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:transportease/Models/address.dart';

import '../Models/app_user.dart';
import '../Models/direction_details.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation, dropOffLocation;
  DirectionDetails? tripDetails;
  User? loggedInUser;
  AppUser? loggedInUserProfile;

  void updatePickupLocationAddress(Address location) {
    pickUpLocation = location;
    notifyListeners();
  }

  void updateDropOffLocationAddress(Address location) {
    dropOffLocation = location;
    notifyListeners();
  }

  void updateTripDetails(DirectionDetails details) {
    tripDetails = details;
    notifyListeners();
  }

  void updateFirebaseUser(User firebaseUser) {
    loggedInUser = firebaseUser;
    notifyListeners();
  }

  void updateAppUser(AppUser appUser) {
    loggedInUserProfile = appUser;
    notifyListeners();
  }
}
