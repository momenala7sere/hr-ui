// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:hr/localization_service.dart';
import 'package:http/io_client.dart';

class LoginPage extends StatefulWidget {
  final Function(Locale) onChangeLanguage;
  final Locale currentLocale;

  const LoginPage({
    super.key,
    required this.onChangeLanguage,
    required this.currentLocale,
  });

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog(LocalizationService.translate('fill_credentials'));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      const url = 'https://app.karbusiness.com/DMS.Mobile.API/API/Login/Login';
      final body = json.encode({
        "UserName": username,
        "Password": password,
      });

      // Handling SSL verification issue
      final httpClient = HttpClient()
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;

      final client = IOClient(httpClient);

      final response = await client.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['success'] == true) {
          Navigator.of(context).pushReplacementNamed('/HomePage');
        } else {
          _showErrorDialog(responseData['message'] ?? 'Login failed');
        }
      } else {
        _showErrorDialog(
            'Error ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (error) {
      _showErrorDialog('Exception occurred: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(LocalizationService.translate('Error')),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(LocalizationService.translate('ok')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isEnglish = widget.currentLocale.languageCode == 'en';

    return Scaffold(
      backgroundColor: const Color(0xff3D3D3D),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Image(
                  image: AssetImage('assets/images/karlogo.png'),
                  width: 70,
                  height: 70,
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.apps,
                    color: Color(0xffCE5E52),
                    size: 40,
                  ),
                  Text(
                    ' E-Service System',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person, color: Colors.white),
                    labelText: LocalizationService.translate('username'),
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock, color: Colors.white),
                    labelText: LocalizationService.translate('password'),
                    labelStyle: const TextStyle(color: Colors.white),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Checkbox(
                          value: true,
                          activeColor: const Color(0xffCE5E52),
                          onChanged: (bool? value) {
                            if (value != null) {
                              print("Remember Me is: $value");
                            }
                          },
                        ),
                      ),
                      Text(
                        LocalizationService.translate('remember_me'),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 13),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/reset-password');
                    },
                    child: Text(
                      LocalizationService.translate('forgot_password'),
                      style: const TextStyle(
                          color: Colors.white, fontSize: 13),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _isLoading ? null : _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffCE5E52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  minimumSize: const Size(380, 50),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        LocalizationService.translate('login'),
                        style: const TextStyle(
                            color: Colors.white, fontSize: 22),
                      ),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () {
                  if (isEnglish) {
                    widget.onChangeLanguage(const Locale('ar', 'EG'));
                  } else {
                    widget.onChangeLanguage(const Locale('en', 'US'));
                  }
                },
                child: Text(
                  isEnglish ? "عربي" : "English",
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                LocalizationService.translate('rights_reserved'),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
