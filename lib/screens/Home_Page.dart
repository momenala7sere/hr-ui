import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyDashboard(),
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}

class MyDashboard extends StatelessWidget {
  final List<String> cardTitles = [
    'Vacation Request',
    'Job Description',
    'Leave Request',
    'Vacations History',
    'Leaves History',
    'HR Request',
    'HR Requests History',
    'Track My Request',
    'Purchase Request',
  ];

  final List<IconData> cardIcons = [
    Icons.person_add,
    Icons.assignment_ind,
    Icons.schedule,
    Icons.pending_actions,
    Icons.content_paste_go_rounded,
    Icons.groups,
    Icons.history,
    Icons.pin_drop,
    Icons.shopping_cart,
  ];

  final List<Color> cardColors = [
    Colors.green,
    Colors.red,
    Colors.yellow,
    Colors.purple,
    Colors.black,
    Colors.blueGrey,
    Colors.purpleAccent,
    Colors.indigoAccent,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dashboard'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            UserAccountsDrawerHeader(
              accountName: Text(
                "Admin User",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                "Human resources-HR",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: ClipOval(
                child: Image(
                  image: AssetImage("assets/images/karlogo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/city.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Employee code :0003'),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.apartment),
              title: Text('Company :Khurmala Erbil Office'),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.125,
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Hiring Date :01/04/2019'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(cardTitles.length, (index) {
            return buildDashboardCard(context, cardTitles[index],
                cardIcons[index], cardColors[index]);
          }),
        ),
      ),
    );
  }
}

Widget buildDashboardCard(
    BuildContext context, String title, IconData icon, Color cardColor) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
            height: 3.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 50.0,
                    color: cardColor,
                  ),
                  const SizedBox(height: 8.0),
                  Text(title),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
