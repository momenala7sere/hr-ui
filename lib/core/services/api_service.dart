import 'dart:convert';
import 'dart:io';
import 'package:hr/utils/token_storage.dart';
import 'package:http/io_client.dart';

class ApiService {
  static final _httpClient = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) {
      return true; // Trust all certificates (use for development only)
    };

  static final _client = IOClient(_httpClient);

  // Login API
  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    const String url =
        'https://app.karbusiness.com/DMS.Mobile.API/API/Login/Login';

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
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          final List<dynamic> responseList = responseData['response'];
          if (responseList.isNotEmpty) {
            final token = responseList[0]['token'];
            if (token != null && token.isNotEmpty) {
              // Save the token securely
              await TokenStorage.saveToken('access_token', token);
            } else {
              throw Exception('Token is missing in the response.');
            }
          } else {
            throw Exception('Invalid response structure.');
          }
        }
        return responseData;
      } else {
        throw Exception(
            'Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('API Error: $error');
    }
  }

  // Generic GET request with token
  static Future<Map<String, dynamic>> getRequest(String endpoint) async {
    final String url =
        'https://app.karbusiness.com/DMS.Mobile.API/API/$endpoint';
    final token = await TokenStorage.getToken('access_token');

    try {
      final response = await _client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('API Error: $error');
    }
  }

  // Generic POST request with token
  static Future<Map<String, dynamic>> postRequest(
      String endpoint, Map<String, dynamic> body) async {
    final String url =
        'https://app.karbusiness.com/DMS.Mobile.API/API/$endpoint';
    final token = await TokenStorage.getToken('access_token');

    try {
      final response = await _client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
            'Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (error) {
      throw Exception('API Error: $error');
    }
  }

  // Logout API
  static Future<void> logout() async {
    await TokenStorage.deleteToken('access_token');
    await TokenStorage.deleteToken('refresh_token');
  }
}
