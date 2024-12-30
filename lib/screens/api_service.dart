import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class ApiService {
  static final _httpClient = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) {
      return true; // Trust all certificates (use for development only)
    };

  static final _client = IOClient(_httpClient);

  static Future<Map<String, dynamic>> login(String username, String password) async {
    const String url = 'https://app.karbusiness.com/DMS.Mobile.API/API/Login/Login';

    try {
      final response = await _client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "UserName": username,
          "Password": password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('API Error: $error');
    }
  }
}
