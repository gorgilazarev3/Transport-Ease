import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:transportease/AssistantFunctions/http_assistant.dart';
import 'package:transportease/DataHandler/app_data.dart';
import 'package:transportease/Models/address.dart';
import 'package:transportease/Models/direction_details.dart';
import 'package:transportease/config_maps.dart' as ConfigMap;

class MethodsAssistants {
  static Future<Address> getAddressFromCoordinates(
      Position position, context) async {
    String apiKey = ConfigMap.browserMapsKey;

    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=" +
            apiKey;

    final response = await HttpAssistant.getRequest(url);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Address address = Address.fromJson(jsonDecode(response.body));

      Provider.of<AppData>(context, listen: false)
          .updatePickupLocationAddress(address);

      return address;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load address');
    }
  }

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

        print("DROP OFF LOC:");
        print(address);

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
}
