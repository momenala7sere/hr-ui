// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:hr/localization_service.dart';

class ResetPassword extends StatelessWidget {
  final Locale currentLocale;

  const ResetPassword({super.key, required this.currentLocale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xff3D3D3D),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    LocalizationService.translate('reset_password'),
                    style: const TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                LocalizationService.translate('enter_email'),
                style: const TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 100.0),
              TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.mail, color: Colors.white),
                  labelText: LocalizationService.translate('email_placeholder'),
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width, 40.0),
                  backgroundColor: const Color(0xffCE5E52),
                ),
                onPressed: () {
                  // Add your reset password logic here
                },
                child: Text(
                  LocalizationService.translate('submit'),
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          LocalizationService.translate('back_to_login'),
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 100.0),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Copyright © ${DateTime.now().year}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
