import 'package:flutter/material.dart';
import 'package:hr/screens/Login_page.dart';
import 'package:hr/screens/Reset_Password.dart';
import 'package:hr/screens/Home_Page.dart';
import 'package:hr/screens/Vacation_Requeste.dart'; // Import VacationRequestForm

void main() {
  runApp(HRApp());
}

class HRApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace with your actual login logic (e.g., shared preferences)
    final isLoggedIn = false; // Change to true if logged in

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginPage(),
        '/reset-password': (context) => const ResetPassword(),
        '/HomePage': (context) => const HomePage(),
        '/vacation-request': (context) =>
            const VacationRequestForm(), // Add route
      },
      // ignore: dead_code
      initialRoute: isLoggedIn ? '/HomePage' : '/login',
    );
  }
}
