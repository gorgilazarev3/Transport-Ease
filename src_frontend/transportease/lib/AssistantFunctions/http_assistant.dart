import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class HttpAssistant {
  static Future<http.Response> getRequest(url) {
    return http.get(Uri.parse(url));
  }

  static Future<http.Response> getRequestWithCorsProxy(url) {
    return http.get(
        Uri.parse("https://corsproxy.io/?" + Uri.encodeComponent(url)),
        headers: {"x-requested-with": "XMLHttpRequest"});
  }

    static Future<http.Response> getRequestWithCorsProxySh(url) {
    return http.get(
        Uri.parse("https://proxy.cors.sh/" + Uri.encodeComponent(url)),
        headers: {"x-cors-api-key": "temp_3a309c242ff6eccead73a7704a8e0e83"});
  }

      static Future<http.Response> getRequestFromBackend(url) {
      if(kIsWeb) {
            return http.get(
        Uri.parse("http://127.0.0.1:8000/api/proxy?url=" + url));
      }
      else {
            return http.get(
        Uri.parse("http://10.0.2.2:8000/api/proxy?url=" + url));
      }
  }

  
      static Future<http.Response> getPlacesApiFromBackend(place) {

              if(kIsWeb) {
    return http.get(
        Uri.parse("http://127.0.0.1:8000/api/getPlacesApi?place=" + place));
      }
      else {
     return http.get(
        Uri.parse("http://10.0.2.2:8000/api/getPlacesApi?place=" + place));
      }
  }

        static Future<http.Response> getPlaceDetailsApiFromBackend(place) {
          
              if(kIsWeb) {
    return http.get(
        Uri.parse("http://127.0.0.1:8000/api/getPlaceDetailsApi?place_id=" + place));
              }
      else {
    return http.get(
        Uri.parse("http://10.0.2.2:8000/api/getPlaceDetailsApi?place_id=" + place));
      }
            
  }

          static Future<http.Response> getDirectionDetailsApiFromBackend(origin, destination) {
                  if(kIsWeb) {
return http.get(
        Uri.parse("http://127.0.0.1:8000/api/getDirectionDetailsApi?origin=" + origin + "&destination=" + destination));
              }
      else {
return http.get(
        Uri.parse("http://10.0.2.2:8000/api/getDirectionDetailsApi?origin=" + origin + "&destination=" + destination));
      }
    
  }
  
}
