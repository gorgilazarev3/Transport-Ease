import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:transportease_providers/Models/address.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../Models/app_user.dart';
import '../Models/direction_details.dart';
import '../Models/driver.dart';
import '../Models/trip_history.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation, dropOffLocation;
  DirectionDetails? tripDetails;
  User? loggedInUser;
  AppUser? loggedInUserProfile;
  StreamSubscription<Position>? mainPageStreamSub;
  StreamSubscription<Position>? rideStreamSub;
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.newPlayer();
  Position? currentPosition;
  Driver? driverInformation;
  String earnings = "0";
  int numTrips = 0;
  List<String> tripHistoryKeys = [];
  List<TripHistory> tripHistoryData = [];
  String title = "";
  double starCount = 0.0;
  String rideType = "regular";

  void updateTitle(String e) {
    title = e;
    notifyListeners();
  }

  void updateStarCount(double e) {
    starCount = e;
    notifyListeners();
  }

  void updateEarnings(String e) {
    earnings = e;
    notifyListeners();
  }

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

  void updateDriverInfo(Driver driver) {
    driverInformation = driver;
    notifyListeners();
  }

  void updateMainPageSub(StreamSubscription<Position> sub) {
    mainPageStreamSub = sub;
    notifyListeners();
  }

  void pauseMainPageSub() {
    if (mainPageStreamSub != null) {
      mainPageStreamSub!.pause();
    }
    notifyListeners();
  }

  void resumeMainPageSub() {
    if (mainPageStreamSub != null) {
      mainPageStreamSub!.resume();
    }
    notifyListeners();
  }

  void updateRideSub(StreamSubscription<Position> sub) {
    rideStreamSub = sub;
    notifyListeners();
  }

  void pauseRideSub() {
    if (rideStreamSub != null) {
      rideStreamSub!.pause();
    }
    notifyListeners();
  }

  void resumeRideSub() {
    if (rideStreamSub != null) {
      rideStreamSub!.resume();
    }
    notifyListeners();
  }

  void cancelRideSub() {
    if (rideStreamSub != null) {
      rideStreamSub!.cancel();
    }
    notifyListeners();
  }

  void updateCurrentPosition(Position position) {
    currentPosition = position;
    notifyListeners();
  }

  void updateNumTrips(int numTripsNew) {
    numTrips = numTripsNew;
    notifyListeners();
  }

  void updateTripHistoryKeys(List<String> keys) {
    tripHistoryKeys = keys;
    notifyListeners();
  }

  void updateTripHistoryData(List<TripHistory> tripHistory) {
    tripHistoryData = tripHistory;
    notifyListeners();
  }

  void addTripHistoryData(TripHistory tripHistory) {
    tripHistoryData.add(tripHistory);
    notifyListeners();
  }

  void updateRideType(String type) {
    rideType = type;
    notifyListeners();
  }
}
