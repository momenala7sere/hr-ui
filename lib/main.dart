import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Added for Provider support
import 'locale_provider.dart'; // Import LocaleProvider
import 'localization_service.dart';
import 'screens/login_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hr/screens/ResetPasswordPage.dart';
import 'package:hr/screens/home/HomePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalizationService.load(const Locale('en', 'US')); // Default language
  runApp(HRApp());
}

class HRApp extends StatelessWidget {
  const HRApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(), // Provide LocaleProvider
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: localeProvider.locale, // Use the globally managed locale
            supportedLocales: LocalizationService.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback:
                LocalizationService.localeResolutionCallback,
            routes: {
              '/login': (context) => LoginPage(
                    onChangeLanguage: (locale) =>
                        Provider.of<LocaleProvider>(context, listen: false)
                            .setLocale(locale), // Pass onChangeLanguage
                    currentLocale: localeProvider.locale, // Pass current locale
                  ),
              '/HomePage': (context) => HomePage(
                    currentLocale: localeProvider.locale, // Pass current locale
                  ),
              '/reset-password': (context) => ResetPasswordPage(
                    currentLocale: localeProvider.locale, // Pass current locale
                  ),
            },
            initialRoute: '/login',
          );
        },
      ),
    );
  }
}
