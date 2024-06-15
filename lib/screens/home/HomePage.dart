import 'package:flutter/material.dart';
import 'components/DashboardCard.dart';
import 'components/Drawer.dart';
import 'dto/CardItems.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyDashboard(),
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}

class MyDashboard extends StatelessWidget {
  const MyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
        actions: [buildProfileButton(context)],
      ),
      drawer: buildDrawer(),
      endDrawer: buildEndDrawer(),
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
            return DashboardCard(cardData: cardItems[index]);
          },
        ),
      ),
    );
  }
}
