import 'package:flutter/material.dart';
import 'package:hr/screens/home/forms/LeaveRequestForm.dart';
import 'package:hr/screens/hr/Hr_Requeste.dart';

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
      case '/leave-request':
        return MaterialPageRoute(builder: (_) => const LeaveRequestForm());
      case '/Hr-request':
        return MaterialPageRoute(builder: (_) => const HrRequestForm());
      default:
        return MaterialPageRoute(builder: (_) => const LoginPage());
    }
  }
}
