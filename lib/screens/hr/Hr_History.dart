import 'package:flutter/material.dart';
import 'package:hr/screens/home/HomePage.dart';

import '../Leave_History.dart';

void main() {
  runApp(const HrHistoryRequestApp());
}

class HrHistoryRequestApp extends StatelessWidget {
  const HrHistoryRequestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HrHistoryRequestScreen(),
    );
  }
}

class HrHistoryRequestScreen extends StatelessWidget {
  const HrHistoryRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HR History Request'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SearchForm(),
      ),
    );
  }
}
