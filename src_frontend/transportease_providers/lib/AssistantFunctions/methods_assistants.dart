import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:transportease_providers/AssistantFunctions/http_assistant.dart';
import 'package:transportease_providers/DataHandler/app_data.dart';
import 'package:transportease_providers/Models/address.dart';
import 'package:transportease_providers/Models/app_user.dart';
import 'package:transportease_providers/Models/direction_details.dart';
import 'package:transportease_providers/Models/trip_history.dart';
import 'package:transportease_providers/config_maps.dart' as ConfigMap;
import 'package:transportease_providers/main.dart';

import '../config_maps.dart';

class MethodsAssistants {
  // static Future<Address> getAddressFromCoordinates(
  //     Position position, context) async {
  //   String apiKey = ConfigMap.browserMapsKey;

  //   String url =
  //       "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=" +
  //           apiKey;

  //   final response = await HttpAssistant.getRequest(url);
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     Address address = Address.fromJson(jsonDecode(response.body));

  //     Provider.of<AppData>(context, listen: false)
  //         .updatePickupLocationAddress(address);

  //     return address;
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load address');
  //   }
  // }

  static Future<Address> getDropOffAddressDetailsFromPlaceId(
      String placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text(
                  "Се поставува локацијата на дестинацијата, Ве молиме почекајте неколку секунди"),
            ));

    String url =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=${placeId}&key=${ConfigMap.browserMapsKey}";

    final response = await HttpAssistant.getRequestWithCorsProxy(url);

    Navigator.pop(context);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonObj = jsonDecode(response.body);
      if (jsonObj["status"] == "OK") {
        Address address = Address(
            placeName: jsonObj["result"]["name"],
            placeId: placeId,
            placeFormattedAddress: jsonObj["result"]["name"],
            latitude: jsonObj["result"]["geometry"]["location"]["lat"],
            longitude: jsonObj["result"]["geometry"]["location"]["lng"]);

        Provider.of<AppData>(context, listen: false)
            .updateDropOffLocationAddress(address);

        return address;
      } else {
        throw Exception('Failed to load address');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load address');
    }
  }

  static Future<DirectionDetails> obtainDirectionDetails(
      LatLng initialPosition, LatLng destinationPosition) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${destinationPosition.latitude},${destinationPosition.longitude}&key=${ConfigMap.browserMapsKey}";

    final response = await HttpAssistant.getRequestWithCorsProxy(url);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonObj = jsonDecode(response.body);
      if (jsonObj["status"] == "OK") {
        DirectionDetails directionDetails = DirectionDetails.fromJson(jsonObj);

        return directionDetails;
      } else {
        throw Exception('Failed to load directions');
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load directions');
    }
  }

  static int calculateFare(DirectionDetails directionDetails, String rideType) {
    //in USD
    double timeTravelled = 0.0;
    double distanceTravelled = 0.0;
    if (rideType.toLowerCase() == "taxi") {
      timeTravelled = (directionDetails.durationValue / 60) * 0.15;
      distanceTravelled = (directionDetails.distanceValue / 1000) * 0.30;
    } else if (rideType.toLowerCase() == "regular") {
      timeTravelled = (directionDetails.durationValue / 60) * 0.20;
      distanceTravelled = (directionDetails.distanceValue / 1000) * 0.20;
    }
    double fareUsd = timeTravelled + distanceTravelled;

    //in MKD, at time of writing this function 1$ USD = 57 MKD
    double fareMkd = fareUsd * 57;
    return fareMkd.round();
  }

  static void getLoggedInUser(BuildContext context) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    String userId = firebaseUser!.uid;
    Provider.of<AppData>(context, listen: false)
        .updateFirebaseUser(firebaseUser);

    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref().child("providers").child(userId);

    // databaseReference.once().then((DataSnapshot snapshot) {
    //       if (snapshot.value != null) {
    //         AppUser user = AppUser.fromSnapshot(snapshot);
    //         Provider.of<AppData>(context).updateAppUser(user);
    //       }
    //     } as FutureOr Function(DatabaseEvent value));

    DataSnapshot snapshot = await databaseReference.get();
    if (snapshot.exists) {
      AppUser user = AppUser.fromSnapshot(snapshot);
      Provider.of<AppData>(context, listen: false).updateAppUser(user);
    }
  }

  static void disableLiveLocationUpdatesOfProvider(BuildContext context) {
    Provider.of<AppData>(context, listen: false).pauseMainPageSub();
    Geofire.removeLocation(
        Provider.of<AppData>(context, listen: false).loggedInUser!.uid);
    availableProvidersRef
        .doc(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
        .delete();
  }

  static void enableLiveLocationUpdatesOfProvider(BuildContext context) {
    Provider.of<AppData>(context, listen: false).resumeMainPageSub();
    Geofire.setLocation(
        Provider.of<AppData>(context, listen: false).loggedInUser!.uid,
        Provider.of<AppData>(context, listen: false).currentPosition!.latitude,
        Provider.of<AppData>(context, listen: false)
            .currentPosition!
            .longitude);

    GeoFirePoint myLocation = geo.point(
        latitude: Provider.of<AppData>(context, listen: false)
            .currentPosition!
            .latitude,
        longitude: Provider.of<AppData>(context, listen: false)
            .currentPosition!
            .longitude);
    availableProvidersRef
        .doc(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
        .set({
      'name': Provider.of<AppData>(context, listen: false).loggedInUser!.uid,
      'position': myLocation.data
    });
  }

  static Future<void> retrieveHistory(BuildContext context) async {
    //retrieving and updating earnings of provider
    var earningsSnap = await providersRef
        .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
        .child("earnings")
        .get();
    if (earningsSnap.value != null) {
      String earnings = earningsSnap.value.toString();
      Provider.of<AppData>(context, listen: false).updateEarnings(earnings);
    }
    //retrieving and updating trip history
    var historySnap = await providersRef
        .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
        .child("history")
        .get();
    if (historySnap.value != null) {
      Map<dynamic, dynamic> keys = historySnap.value as Map;
      int numTrips = keys.length;
      Provider.of<AppData>(context, listen: false).updateNumTrips(numTrips);

      List<String> tripHistoryKeys = [];
      keys.forEach((key, value) {
        tripHistoryKeys.add(key);
      });

      Provider.of<AppData>(context, listen: false)
          .updateTripHistoryKeys(tripHistoryKeys);
      obtainTripHistoryData(context);
      //retrieving and updating ratings of provider
      var ratingsSnap = await providersRef
          .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
          .child("ratings")
          .get();
      if (ratingsSnap.value != null) {
        String ratings = ratingsSnap.value.toString();
        double starCount = double.parse(ratings);
        Provider.of<AppData>(context, listen: false).updateStarCount(starCount);

        if (starCount <= 1) {
          Provider.of<AppData>(context, listen: false)
              .updateTitle("Многу лошо");
        } else if (starCount <= 2) {
          Provider.of<AppData>(context, listen: false).updateTitle("Лошо");
          return;
        } else if (starCount <= 3.5) {
          Provider.of<AppData>(context, listen: false).updateTitle("Добро");

          return;
        } else if (starCount <= 4.5) {
          Provider.of<AppData>(context, listen: false)
              .updateTitle("Многу добро");

          return;
        } else if (starCount <= 5) {
          Provider.of<AppData>(context, listen: false).updateTitle("Одлично");

          return;
        }
      } else {
        String ratings = "0.0";
        double starCount = double.parse(ratings);
        Provider.of<AppData>(context, listen: false).updateStarCount(starCount);
        Provider.of<AppData>(context, listen: false).updateTitle("Неоценет");
      }
    }
  }

  static Future<void> obtainTripHistoryData(BuildContext context) async {
    var keys = Provider.of<AppData>(context, listen: false).tripHistoryKeys;

    for (String key in keys) {
      var rideSnap = await newRideRequestsRef.child(key).get();
      if (rideSnap.exists && rideSnap.value != null) {
        var tripHistory = TripHistory.fromSnapshot(rideSnap);
        Provider.of<AppData>(context, listen: false)
            .addTripHistoryData(tripHistory);
      }
    }
  }

  static void clearTripHistory(context) {
    Provider.of<AppData>(context, listen: false).updateNumTrips(0);
    Provider.of<AppData>(context, listen: false).tripHistoryData.clear();
    Provider.of<AppData>(context, listen: false).tripHistoryKeys.clear();
  }

  static String formatDateAsString(String date) {
    DateTime dateTime = DateTime.parse(date);
    String formattedDate =
        "${DateFormat.MMMd().format(dateTime)}, ${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)}";
    return formattedDate;
  }
}
