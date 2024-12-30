import 'package:flutter/material.dart';
import 'package:hr/localization_service.dart'; // Import localization service
import 'components/DashboardCard.dart';
import 'components/Drawer.dart';
import 'dto/CardItems.dart';

class HomePage extends StatelessWidget {
  final Locale currentLocale;

  const HomePage({super.key, required this.currentLocale});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyDashboard(currentLocale: currentLocale),
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}

class MyDashboard extends StatelessWidget {
  final Locale currentLocale;

  const MyDashboard({super.key, required this.currentLocale});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizationService.translate('dashboard_title'), // Translated title
        ),
        actions: [buildProfileButton(context)],
      ),
      drawer: buildDrawer(), // Retaining the drawer functionality
      endDrawer: buildEndDrawer(), // Retaining the end drawer functionality
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: cardItems.length,
          itemBuilder: (BuildContext context, int index) {
            final translatedCardData = cardItems[index].copyWith(
              title: LocalizationService.translate(
                  cardItems[index].title), // Translated card title
            );
            return DashboardCard(cardData: translatedCardData);
          },
        ),
      ),
    );
  }
}
