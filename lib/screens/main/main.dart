import 'package:flutter/material.dart';
import '../main/router/Router.dart';
import 'auth_service.dart';

void main() {
  runApp(HRApp());
}

class HRApp extends StatefulWidget {
  const HRApp({super.key});

  @override
  _HRAppState createState() => _HRAppState();
}

class _HRAppState extends State<HRApp> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    isLoggedIn = await AuthService.isLoggedIn();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouterUtil.generateRoute,
      initialRoute: isLoggedIn ? '/HomePage' : '/login',
    );

  }
}