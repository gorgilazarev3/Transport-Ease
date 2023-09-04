import 'package:http/http.dart' as http;

class HttpAssistant {
  static Future<http.Response> getRequest(url) {
    return http.get(Uri.parse(url));
  }

  static Future<http.Response> getRequestWithCorsProxy(url) {
    return http.get(
        Uri.parse("https://corsproxy.io/?" + Uri.encodeComponent(url)),
        headers: {"x-requested-with": "XMLHttpRequest"});
  }
}
