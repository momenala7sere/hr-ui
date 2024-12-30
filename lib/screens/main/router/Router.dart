import 'package:flutter/material.dart';
import 'package:hr/screens/home/forms/LeaveRequestForm.dart';
import 'package:hr/screens/home/forms/VacationHistoryApp.dart';
import 'package:hr/screens/hr/Hr_Requeste.dart';

import '../../Login_page.dart';
import '../../ResetPasswordPage.dart';
import '../../VacationRequeste.dart';
import '../../home/HomePage.dart';

class RouterUtil {
  static Route<dynamic> generateRoute(
    RouteSettings settings, {
    required Function(Locale) onChangeLanguage,
    required Locale currentLocale,
  }) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginPage(
            onChangeLanguage: onChangeLanguage,
            currentLocale: currentLocale,
          ),
        );
      case '/reset-password':
        return MaterialPageRoute(
          builder: (_) => ResetPasswordPage(
            currentLocale: currentLocale, // Pass the current locale
          ),
        );
      case '/HomePage':
        return MaterialPageRoute(
          builder: (context) => HomePage(
            currentLocale: currentLocale, // Pass current locale
          ),
        );
      case '/vacation-request':
        return MaterialPageRoute(builder: (_) => const VacationRequestForm());
      case '/leave-request':
        return MaterialPageRoute(builder: (_) => const LeaveRequestForm());
      case '/Hr-request':
        return MaterialPageRoute(builder: (_) => const HrRequestForm());
      case '/vacation-history':
        return MaterialPageRoute(builder: (_) => const VacationHistoryApp());
      default:
        return MaterialPageRoute(
          builder: (_) => LoginPage(
            onChangeLanguage: onChangeLanguage,
            currentLocale: currentLocale,
          ),
        );
    }
  }
}
