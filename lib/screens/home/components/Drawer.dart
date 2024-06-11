import 'package:flutter/material.dart';

Widget buildDrawer() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const UserAccountsDrawerHeader(
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
        buildDrawerItem(Icons.account_circle_rounded, 'Employee code :0003'),
        buildDivider(),
        buildDrawerItem(Icons.apartment, 'Company :Khurmala Erbil Office'),
        buildDivider(),
        buildDrawerItem(Icons.calendar_month, 'Hiring Date :01/04/2019'),
        buildDivider(),
      ],
    ),
  );
}

Widget buildEndDrawer() {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(
          height: 70,
          child: DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.home),
                SizedBox(width: 13.0),
                Icon(Icons.mail),
                SizedBox(width: 13.0),
                Icon(Icons.notifications),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildStatusContainer(Icons.person, 'Annual Leave', '24 Days'),
            buildStatusContainer(Icons.hotel, 'Sick Leave', '30 Days'),
          ],
        ),
        const SizedBox(height: 5),
        buildDivider(),
        buildStatusRow('Requested Vacations', '0 Days'),
        buildDivider(),
        buildStatusRow('Remaining Vacations', '24 Days'),
        buildDivider(),
        buildStatusRow('Remaining Sick Leave', '30 Days'),
        buildDivider(),
        buildStatusRow('Employee Rating', '85%'),
      ],
    ),
  );
}
Widget buildProfileButton(BuildContext context) {
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
}

Widget buildDrawerItem(IconData icon, String text) {
  return ListTile(
    leading: Icon(icon),
    title: Text(text),
  );
}


Widget buildDivider() {
  return const Divider(
    color: Colors.grey,
    thickness: 0.5,
    height: 20,
  );
}

Widget buildStatusContainer(IconData icon, String title, String value) {
  return Container(
    height: 140,
    width: 140,
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: const Color(0xffCE5E52),
      borderRadius: BorderRadius.circular(10.0),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.3),
          blurRadius: 5.0,
          spreadRadius: 1.0,
          offset: const Offset(2.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(icon, size: 40, color: Colors.white),
        const SizedBox(height: 15),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ],
    ),
  );
}

Widget buildStatusRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 104, 104, 104),
          ),
        ),
      ],
    ),
  );
}