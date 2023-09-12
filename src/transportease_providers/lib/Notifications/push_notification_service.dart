import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transportease_providers/DataHandler/app_data.dart';
import 'package:transportease_providers/Models/ride_request_notification_model.dart';
import 'package:transportease_providers/Screens/ride_request_notification_widget.dart';
import 'package:transportease_providers/main.dart';

import '../Models/ride_details.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  // PushNotificationService().retrieveRideRequestInfo(
  //     PushNotificationService().getRideRequestId(message),);
}

class PushNotificationService {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize(BuildContext context) async {
    await firebaseMessaging.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      retrieveRideRequestInfo(getRideRequestId(message), context);
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
      // FirebaseMessaging.onBackgroundMessage(
      //     _firebaseMessagingBackgroundHandler);
    });
  }

  Future<String> getToken(BuildContext context) async {
    String? token = await firebaseMessaging.getToken();
    print("token is: " + token!);
    providersRef
        .child(Provider.of<AppData>(context, listen: false).loggedInUser!.uid)
        .child("token")
        .set(token);
    firebaseMessaging.subscribeToTopic("all_providers");
    firebaseMessaging.subscribeToTopic("all_users");
    return token;
  }

  String getRideRequestId(RemoteMessage message) {
    String rideRequestId = "";
    rideRequestId = message.data["ride_request_id"];
    return rideRequestId;
  }

  Future<void> retrieveRideRequestInfo(
      String rideRequestId, BuildContext context) async {
    DataSnapshot snap = await newRideRequestsRef.child(rideRequestId).get();
    if (snap.value != null) {
      var data = snap.value as Map;
      double pickUpLocationLat =
          double.parse(data["pickUpLocation"]["latitude"].toString());
      double pickUpLocationLng =
          double.parse(data["pickUpLocation"]["longitude"].toString());
      String pickUpAddress = data["pickUp_address"].toString();

      String destAddress = data["destination_address"].toString();
      double destLocationLat =
          double.parse(data["destinationLocation"]["latitude"].toString());
      double destLocationLng =
          double.parse(data["destinationLocation"]["longitude"].toString());

      String paymentMethod = data["payment_method"].toString();
      String riderName = data["rider_name"].toString();
      String riderPhone = data["rider_phone"].toString();

      RideDetails rideDetails = RideDetails(
          rideRequestId: rideRequestId,
          pickUpAddress: pickUpAddress,
          destinationAddress: destAddress,
          pickUpLocation: LatLng(pickUpLocationLat, pickUpLocationLng),
          destinationLocation: LatLng(destLocationLat, destLocationLng),
          paymentMethod: paymentMethod,
          riderName: riderName,
          riderPhone: riderPhone);

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: ((context) =>
              RideRequestNotificationWidget(rideDetails: rideDetails)));

      Provider.of<AppData>(context, listen: false)
          .audioPlayer
          .open(Audio("assets/audios/notification.mp3"), autoStart: true);
    }
  }
}
