import 'dart:convert';
import 'package:http/http.dart' as http;

// Giả sử đây là API key và country mặc định
const String googleMapAPIKey = 'AIzaSyC94zvPNPZiDgAWC5CO0orqehrh90IYt8g';
const String defaultCountry = 'VN';

// Định nghĩa enum HttpMethod
enum HttpMethod { GET, POST }

// Hàm buildHttpResponse
Future<http.Response> buildHttpResponse(String url,
    {required HttpMethod method, Map? request}) async {
  try {
    if (method == HttpMethod.GET) {
      return await http.get(Uri.parse(url));
    } else if (method == HttpMethod.POST) {
      return await http.post(Uri.parse(url), body: request);
    } else {
      throw Exception('Unsupported HTTP method');
    }
  } catch (e) {
    throw Exception('Request failed: $e');
  }
}

// Hàm handleResponse
Future<Map<String, dynamic>> handleResponse(http.Response response) async {
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}
