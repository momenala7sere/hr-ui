import 'package:flutter/material.dart';
import 'package:hr/screens/Login_page.dart';
import 'package:hr/screens/Reset_Password.dart'; // Assuming Reset_Password.dart exists
import 'package:hr/screens/Home_Page.dart';
import 'package:hr/screens/Profile_Page.dart';

void main() {
  runApp(const HRApp()); // Run the app with the HRApp widget
}

class HRApp extends StatelessWidget {
  const HRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ... other MaterialApp properties (optional)

      // Define routes for navigation
      routes: {
        '/login': (context) => const LoginPage(), // Route for Login page
        '/reset-password': (context) =>
            const ResetPassword(), // Route for Reset Password
        '/HomePage': (context) => const HomePage(),
      },

      // Set the initial screen to LoginPage
      home: const LoginPage(),
    );
  }
}
