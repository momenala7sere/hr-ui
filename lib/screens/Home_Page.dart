import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
        actions: <Widget>[
          Builder(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: IconButton(
                  icon: const Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
              );
            },
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
                "Human Resources-HR",
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
              thickness: 0.5,
              height: 20,
            ),
            ListTile(
              leading: Icon(Icons.calendar_month),
              title: Text('Hiring Date :01/04/2019'),
            ),
            Divider(
              color: Colors.grey,
              thickness: 0.5,
              height: 20,
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 70,
              child: DrawerHeader(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      // New Row for Icons
                      children: <Widget>[
                        Icon(Icons.home),
                        SizedBox(width: 13.0),
                        Icon(Icons.mail),
                        SizedBox(width: 13.0),
                        Icon(Icons.notifications),
                      ],
                    ),
                    SizedBox(width: 13.0),
                    Text(
                      'Employee Code :0003 ',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Add containers here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 140,
                  width: 140,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xffCE5E52),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 0, 0, 0)
                            .withOpacity(0.3), // Adjust shadow color as needed
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            1.0, // Adjust spread radius for shadow extension
                        offset: const Offset(
                            2.0, 2.0), // Adjust offset for shadow position
                      ),
                    ],
                  ),
                  child: const Column(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Annual Leave',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '24 Days',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 140,
                  width: 140,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: const Color(0xffCE5E52),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(255, 0, 0, 0)
                            .withOpacity(0.3), // Adjust shadow color as needed
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            1.0, // Adjust spread radius for shadow extension
                        offset: const Offset(
                            2.0, 2.0), // Adjust offset for shadow position
                      ),
                    ],
                  ),
                  child: const Column(
                    children: <Widget>[
                      Icon(
                        Icons.hotel,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Sick Leave',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '30 Days',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              thickness: 1.0, // Adjust thickness as needed
              color: Colors.grey, // Adjust color as needed
              height: 20.0, // Adjust height for spacing (optional)
              indent: 10.0, // Adjust indent from left side (optional)
              endIndent: 10.0, // Adjust indent from right side (optional)
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Requested Vacations',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    '0 Days',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 104, 104, 104)),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.0, // Adjust thickness as needed
              color: Colors.grey, // Adjust color as needed
              height: 20.0, // Adjust height for spacing (optional)
              indent: 10.0, // Adjust indent from left side (optional)
              endIndent: 10.0, // Adjust indent from right side (optional)
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Remaining Vacations',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    '24 Days',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 104, 104, 104)),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.0, // Adjust thickness as needed
              color: Colors.grey, // Adjust color as needed
              height: 20.0, // Adjust height for spacing (optional)
              indent: 10.0, // Adjust indent from left side (optional)
              endIndent: 10.0, // Adjust indent from right side (optional)
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Remaining Sick Leave',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    '30 Days',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 104, 104, 104)),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 1.0, // Adjust thickness as needed
              color: Colors.grey, // Adjust color as needed
              height: 20.0, // Adjust height for spacing (optional)
              indent: 10.0, // Adjust indent from left side (optional)
              endIndent: 10.0, // Adjust indent from right side (optional)
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Employee Rating',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 110,
                  ),
                  Text(
                    '85%',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 104, 104, 104)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: cardTitles.length,
          itemBuilder: (BuildContext context, int index) {
            return buildDashboardCard(context, cardTitles[index],
                cardIcons[index], cardColors[index]);
          },
        ),
      ),
    );
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
                  topRight: Radius.circular(10.0),
                ),
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
}
