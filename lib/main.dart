import 'package:flutter/material.dart';
import 'package:hr/screens/Login_page.dart';

void main() {
  runApp(const HRApp());
}

class HRApp extends StatelessWidget {
  const HRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
