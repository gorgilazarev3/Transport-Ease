import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:transportease/AssistantFunctions/http_assistant.dart';
import 'package:transportease/DataHandler/app_data.dart';
import 'package:transportease/Models/address.dart';
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
}
