// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        backgroundColor: const Color(0xff3D3D3D),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                    size: 40,
                  ), // Replace with your desired icon
                  SizedBox(width: 10.0), // Add spacing between icon and text
                  Text(
                    'Reset Password',
                    style: TextStyle(
                        fontSize: 34.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Please Enter Your Email Below and we will send you a New Password',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 100.0),
              TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail, color: Colors.white),
                      labelText: 'Please Enter Your Email',
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
                    borderRadius: BorderRadius.circular(
                        10.0), // Adjust corner radius as needed
                  ),
                  minimumSize: Size(MediaQuery.of(context).size.width, 40.0),
                  backgroundColor: const Color(0xffCE5E52),
                ),
                onPressed: () {},
                child: const Text(
                  'Reset Password',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    // Wrap both icon and text in GestureDetector
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(
                          '/login'); // Navigate to Login_page.dart
                    },
                    child: const Row(
                      // Nested Row for better alignment
                      children: [
                        Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Back To Login Page',
                          style: TextStyle(
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
