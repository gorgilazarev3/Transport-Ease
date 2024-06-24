import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:transportease/AssistantFunctions/http_assistant.dart';
import 'package:transportease/Models/app_user.dart';
import 'package:http/http.dart' as http;
class BackendAPIAssistant {
  static Future<AppUser> authenticateUserWithEmailAndPassword(String email, String password) async {
      String url = 'http://127.0.0.1:8000/api/login';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/login';
      }
      http.Response response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password
      });
      Map<String, dynamic> parsedJson = json.decode(response.body);
      final storage = FlutterSecureStorage();
      await storage.write(key: 'access_token', value: parsedJson['access_token']); 
      AppUser user = AppUser.fromJSON(parsedJson);
      return user;
  }

  static Future<AppUser> registerNewUser(String email, String password, String name, String phoneNumber, String role) async {
      String url = 'http://127.0.0.1:8000/api/register';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/register';
      }
      http.Response response = await http.post(Uri.parse(url), body: {
        'email': email,
        'password': password,
        'name': name,
        'phone_number': phoneNumber,
        'role': role
      });
      AppUser user = AppUser.fromJSON(json.decode(response.body)['created_user']);
      return user;
  }

    static Future<AppUser> registerNewUserWithObj(Map<dynamic, dynamic> userData) async {
      String url = 'http://127.0.0.1:8000/api/register';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/register';
      }
      http.Response response = await http.post(Uri.parse(url), body: {
        'email': userData['email'],
        'password': userData['password'],
        'name': userData['name'],
        'phone_number': userData['phone'],
        'role': userData['role']
      });
      AppUser user = AppUser.fromJSON(json.decode(response.body)['created_user']);
      return user;
  }

      static Future<AppUser> getLoggedInUser() async {
      final storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: 'access_token');
      String url = 'http://127.0.0.1:8000/api/user';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/user';
      }
      http.Response response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer ' + accessToken!});
      AppUser user = AppUser.fromJSON(json.decode(response.body));
      return user;
  }

  static Future<Map> createARideRequest(Map requestData) async {
      var error;
      String url = 'http://127.0.0.1:8000/api/ride-requests';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/ride-requests';
      }
      http.Response response = await http.post(Uri.parse(url), body: {
      "payment_method": "cash",
      "pickup_location_latitude": requestData['pickup_location_latitude'],
      "pickup_location_longitude": requestData['pickup_location_longitude'],
      "destination_location_latitude": requestData['destination_location_latitude'],
      "destination_location_longitude": requestData['destination_location_longitude'],
      "rider_name": requestData['rider_name'],
      "rider_phone": requestData['rider_phone'],
      "pickup_address": requestData['pickup_address'],
      "destination_address": requestData['destination_address'],
      "pickup_place": requestData['pickup_place'],
      "destination_place": requestData['destination_place'],
      "ride_type": requestData['ride_type']
      }).catchError((err) =>  error = err);
      Map createdRequest = jsonDecode(response.body);
      return createdRequest;
  }

   static Future<Map> cancelRideRequest(int id) async {
      var error;
      String url = 'http://127.0.0.1:8000/api/ride-requests/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/ride-requests/$id';
      }
      http.Response response = await http.delete(Uri.parse(url)).catchError((err) =>  error = err);
      Map cancelledRequest = jsonDecode(response.body);
      return cancelledRequest;
  }

  
   static Future<Map> getFullProviderInfo(String id) async {
      var error;
      String url = 'http://127.0.0.1:8000/api/drivers/full/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers/full/$id';
      }
      http.Response response = await http.get(Uri.parse(url)).catchError((err) =>  error = err);
      Map provider = jsonDecode(response.body);
      return provider;
  }

        static Future<Map> updateRideType(String id, newRide) async {
      String url = 'http://127.0.0.1:8000/api/drivers/updateRide/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers/updateRide/$id';
      }
      http.Response driverResponse = await http.put(Uri.parse(url), body: {
        'newRide' : newRide.toString()
      });
      Map<String, dynamic> driverObj = jsonDecode(driverResponse.body);
      return driverObj;
  }

         static Future<Map> getFullProviderInfoByUserId(String id) async {
      var error;
      String url = 'http://127.0.0.1:8000/api/drivers/full/user/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers/full/user/$id';
      }
      http.Response response = await http.get(Uri.parse(url)).catchError((err) =>  error = err);
      Map provider = jsonDecode(response.body);
      return provider;
  }

    static Future<Map> getRideRequest(int id) async {
      var error;
      String url = 'http://127.0.0.1:8000/api/ride-requests/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/ride-requests/$id';
      }
      http.Response response = await http.get(Uri.parse(url)).catchError((err) =>  error = err);
      Map request = jsonDecode(response.body);
      return request;
  }

   static Future<Map> updateDriverRating(String id, newRating) async {
      String url = 'http://127.0.0.1:8000/api/drivers/updateRating/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers/updateRating/$id';
      }
      http.Response driverResponse = await http.post(Uri.parse(url), body: {
        'newRating' : newRating.toString()
      }).catchError((err) => print(err));
      Map<String, dynamic> driverObj = jsonDecode(driverResponse.body);
      return driverObj;
  }
}