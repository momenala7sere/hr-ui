import 'package:flutter/material.dart';
import 'package:hr/screens/home/HomePage.dart';
import 'package:hr/localization_service.dart'; // Import localization service

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
        title: Text(
          LocalizationService.translate(
              'hr_history_request'), // Localized title
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 30),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  currentLocale: Localizations.localeOf(context), // Pass locale
                ),
              ),
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

class SearchForm extends StatefulWidget {
  const SearchForm({super.key});

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _fromDateController,
          decoration: InputDecoration(
            labelText: LocalizationService.translate('from_date'),
            hintText: LocalizationService.translate('enter_date'),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () => _selectDate(context, _fromDateController),
            ),
          ),
          onTap: () => _selectDate(context, _fromDateController),
          readOnly: true,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _toDateController,
          decoration: InputDecoration(
            labelText: LocalizationService.translate('to_date'),
            hintText: LocalizationService.translate('enter_date'),
            border: const OutlineInputBorder(),
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month),
              onPressed: () => _selectDate(context, _toDateController),
            ),
          ),
          onTap: () => _selectDate(context, _toDateController),
          readOnly: true,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Handle search logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffCE5E52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.search, size: 25, color: Colors.white),
                const SizedBox(width: 8.0),
                Text(
                  LocalizationService.translate('search'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
