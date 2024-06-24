import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:transportease_providers/Models/driver.dart';
import 'http_assistant.dart';
import 'package:transportease_providers/Models/app_user.dart';
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

      static Future<AppUser> registerNewDriverWithObj(Map<dynamic, dynamic> userData) async {
      String url = 'http://127.0.0.1:8000/api/drivers';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers';
      }
      Map<String, dynamic> reqBody = {
        'email': userData['user'].email,
        'password': userData['password'],
        'name': userData['user'].name,
        'phone_number': userData['user'].phone,
        'role': userData['user'].role
      };
      if(reqBody['role'] == 'taxi_driver') {
        reqBody['license_plate'] = userData['license_plate'];
        reqBody['taxi_car_seats'] = userData['taxi_car_seats'];
        reqBody['taxi_company_name'] = userData['taxi_company_name'];
      }
      else if(reqBody['role'] == 'regular_driver') {
        reqBody['license_plate'] = userData['license_plate'];
        reqBody['car_color'] = userData['car_color'];
        reqBody['car_model'] = userData['car_model'];
      }
      else if(reqBody['role'] == 'transporting_driver' && userData['provider_type'] == 'passengers_provider') {
        reqBody['provider_seats'] = userData['provider_seats'];
        reqBody['provider_type'] = userData['provider_type'];
        reqBody['routes_type'] = userData['routes_type'];
      }
      else if(reqBody['role'] == 'transporting_driver' && userData['provider_type'] == 'carrier_provider') {
        reqBody['carrier_capacity'] = userData['carrier_capacity'];
        reqBody['provider_type'] = userData['provider_type'];
      }
      http.Response response = await http.post(Uri.parse(url), body: reqBody);
      AppUser user = AppUser.fromJSON(json.decode(response.body)['created_user']);
      return user;
  }

    static Future<AppUser> getLoggedInUser() async {
      String url = 'http://127.0.0.1:8000/api/user';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/user';
      }
      final storage = FlutterSecureStorage();
      final accessToken = await storage.read(key: 'access_token');
      http.Response response = await http.get(Uri.parse(url), headers: {'Authorization': 'Bearer ' + accessToken!});
      AppUser user = AppUser.fromJSON(json.decode(response.body));
      return user;
  }

    static Future<Driver> getLoggedInDriver() async {
      AppUser loggedInUser = await getLoggedInUser();
     String url = 'http://127.0.0.1:8000/api/drivers/user/';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers/user/';
      }
      http.Response driverResponse = await http.get(Uri.parse(url + loggedInUser.id));
      Map<String, dynamic> driverObj = jsonDecode(driverResponse.body);
      String providersUrl = 'http://127.0.0.1:8000/api/providers/driver/';
      if(!kIsWeb) {
        providersUrl = 'http://10.0.2.2:8000/api/providers/driver/';
      }
      http.Response providerDetailsResponse = await http.get(Uri.parse(providersUrl + driverObj['id'].toString()));
      Map<String, dynamic> providerDetailsObj = jsonDecode(providerDetailsResponse.body);
      String car_color_placeholder = "";
      String car_model_placeholder = "";
      String license_plate_placeholder = "";
      if(loggedInUser.role.toLowerCase() == 'regular_driver')
      {
        car_color_placeholder = providerDetailsObj['car_color'];
        car_model_placeholder = providerDetailsObj['car_model'];
        license_plate_placeholder = providerDetailsObj['license_plate'];
      }
      else if(loggedInUser.role.toLowerCase() == 'taxi_driver')
      {
        car_color_placeholder = providerDetailsObj['taxi_company_name'];
        car_model_placeholder = providerDetailsObj['taxi_car_seats'].toString() + " седишта";
        license_plate_placeholder = providerDetailsObj['license_plate'];
      }
      else if(loggedInUser.role.toLowerCase() == 'transporting_driver')
      {
        if(providerDetailsObj['provider_type'].toString().toLowerCase() == "carrier_provider") {
          car_color_placeholder = providerDetailsObj['carrier_capacity'].toString();
          car_model_placeholder = " cm3";
          license_plate_placeholder = providerDetailsObj['provider_type'];
        }
        else if(providerDetailsObj['provider_type'].toString().toLowerCase() == "passengers_provider") {
          car_color_placeholder = providerDetailsObj['routes_type'] + " рута";
          car_model_placeholder = providerDetailsObj['provider_seats'].toString() + " седишта";
          license_plate_placeholder = providerDetailsObj['provider_type'];
        }

      }
      Driver driver = Driver(name: loggedInUser.name, phone: loggedInUser.phone, email: loggedInUser.email, id: driverObj['id'].toString(), car_color: car_color_placeholder, car_model: car_model_placeholder, license_plate: license_plate_placeholder);

      return driver;
  }

      static Future<Map> updateRideType(String id, newRide) async {
      String url = 'http://127.0.0.1:8000/api/drivers/updateRide/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers/updateRide/$id';
      }
      http.Response driverResponse = await http.put(Uri.parse(url), body: {
        'newRide' : newRide
      });
      Map<String, dynamic> driverObj = jsonDecode(driverResponse.body);
      return driverObj;
  }

    static Future<Map> getRideRequestById(String id) async {
      String url = 'http://127.0.0.1:8000/api/ride-requests/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/ride-requests/$id';
      }
      http.Response driverResponse = await http.get(Uri.parse(url));
      Map<String, dynamic> driverObj = jsonDecode(driverResponse.body);
      return driverObj;
  }

        static Future<Map> updateToken(String id, token) async {
      String url = 'http://127.0.0.1:8000/api/drivers/updateToken/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers/updateToken/$id';
      }
      http.Response driverResponse = await http.post(Uri.parse(url), body: {
        'token' : token
      });
      Map<String, dynamic> driverObj = jsonDecode(driverResponse.body);
      return driverObj;
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

       static Future<Map> getFullProviderInfoByUserId(String id) async {
      var error;
      String url = 'http://127.0.0.1:8000/api/drivers/full/user/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers/full/user/$id';
      }
      http.Response response = await http.get(Uri.parse(url)).catchError((err) =>  print(err));
      Map provider = jsonDecode(response.body);
      return provider;
  }

  
    static Future<Map> updateRideRequestStatus(String id, status) async {
      String url = 'http://127.0.0.1:8000/api/ride-requests/updateStatus/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/ride-requests/updateStatus/$id';
      }
      http.Response rrResponse = await http.post(Uri.parse(url), body: {
        'status' : status
      });
      Map<String, dynamic> rrObj = jsonDecode(rrResponse.body);
      return rrObj;
  }

      static Future<Map> updateRideRequestFare(String id, fare) async {
      String url = 'http://127.0.0.1:8000/api/ride-requests/updateFare/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/ride-requests/updateFare/$id';
      }
      http.Response rrResponse = await http.post(Uri.parse(url), body: {
        'fare' : fare.toString()
      }).catchError((err) => {
        print(err)});
      Map<String, dynamic> rrObj = jsonDecode(rrResponse.body);
      return rrObj;
  }

  static Future<Map> saveEarnings(String id, fareAmount) async {
          String url = 'http://127.0.0.1:8000/api/drivers/updateEarnings/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/drivers/updateEarnings/$id';
      }
      http.Response driverResponse = await http.post(Uri.parse(url), body: {
        'fareAmount' : fareAmount.toString()
      }).catchError((err) => print(err));
      Map<String, dynamic> driverObj = jsonDecode(driverResponse.body);
      return driverObj;
  }

        static Future<Map> updateRideRequestDetails(String id, Map details) async {
      String url = 'http://127.0.0.1:8000/api/ride-requests/updateDetails/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/ride-requests/updateDetails/$id';
      }
      http.Response rrResponse = await http.post(Uri.parse(url), body: {
        'driver_name' : details['driver_name'],
        'driver_phone' : details['driver_phone'],
        'driver_id' : details['driver_id'],
        'car_details' : details['car_details'],
        'car_plates' : details['car_plates'],
        'driver_location_latitude' : details['driver_location']['latitude'],
        'driver_location_longitude' : details['driver_location']['longitude'],
      }).catchError((err) => {
        print(err)});
      Map<String, dynamic> rrObj = jsonDecode(rrResponse.body);
      return rrObj;
  }

    static void signOutDriver() async {
          String url = 'http://127.0.0.1:8000/api/logout';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/logout';
      }
      http.Response driverResponse = await http.post(Uri.parse(url)).catchError((err) => print(err));
  }

      static Future<List> getRideRequestsForDriver(String id) async {
          String url = 'http://127.0.0.1:8000/api/ride-requests/driver/$id';
      if(!kIsWeb) {
        url = 'http://10.0.2.2:8000/api/ride-requests/driver/$id';
      }
      http.Response rrResponse = await http.get(Uri.parse(url)).catchError((err) => print(err));
      List rideRequests = jsonDecode(rrResponse.body);
      return rideRequests;
  }
}