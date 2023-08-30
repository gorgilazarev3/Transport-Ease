import 'package:http/http.dart' as http;

class HttpAssistant {
  static Future<http.Response> getRequest(url) {
    return http.get(Uri.parse(url));
  }
}
