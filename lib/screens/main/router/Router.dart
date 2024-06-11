import 'package:flutter/material.dart';

import '../../Login_page.dart';
import '../../ResetPasswordPage.dart';
import '../../VacationRequeste.dart';
import '../../home/HomePage.dart';


class RouterUtil {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/reset-password':
        return MaterialPageRoute(builder: (_) => const ResetPasswordPage());
      case '/HomePage':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/vacation-request':
        return MaterialPageRoute(builder: (_) => const VacationRequestForm());
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
