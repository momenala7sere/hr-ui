import 'package:flutter/material.dart';

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
        leading: Padding(
          padding: const EdgeInsets.only(left: 25),
          child: IconButton(
            icon: const Icon(Icons.group, size: 30),
            onPressed: () {
              // Add functionality for icon press (optional)
            },
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SearchForm(),
      ),
    );
  }
}


