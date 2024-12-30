import 'package:flutter/material.dart';
import 'package:hr/localization_service.dart'; // Import LocalizationService
import 'package:hr/screens/home/HomePage.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const VacationHistoryApp());
}

class VacationHistoryApp extends StatelessWidget {
  const VacationHistoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VacationHistoryScreen(),
    );
  }
}

class VacationHistoryScreen extends StatelessWidget {
  const VacationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationService.translate('vacations_history')),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () {
            // Pass current locale to HomePage when navigating back
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
        child: Column(
          children: [
            SearchForm(),
            SizedBox(height: 16),
            Expanded(child: VacationHistoryList()),
          ],
        ),
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
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

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
        controller.text = _dateFormat.format(picked);
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
            hintText: LocalizationService.translate('date_format'),
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
            hintText: LocalizationService.translate('date_format'),
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.search,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
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

class VacationHistoryList extends StatelessWidget {
  const VacationHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        VacationHistoryCard(
          id: '2520',
          employee: 'Mohammed',
          requestDate: '01/06/2023 11:02:21',
          requestType: 'Quota',
          from: '01/06/2023',
          to: '10/06/2023',
          status: 'Requested',
        ),
      ],
    );
  }
}

class VacationHistoryCard extends StatelessWidget {
  final String id;
  final String employee;
  final String requestDate;
  final String requestType;
  final String from;
  final String to;
  final String status;

  const VacationHistoryCard({
    super.key,
    required this.id,
    required this.employee,
    required this.requestDate,
    required this.requestType,
    required this.from,
    required this.to,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${LocalizationService.translate('id')}: $id',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              '${LocalizationService.translate('employee')}: $employee',
            ),
            const SizedBox(height: 8.0),
            Text(
              '${LocalizationService.translate('request_date')}: $requestDate',
            ),
            const SizedBox(height: 8.0),
            Text(
              '${LocalizationService.translate('request_type')}: $requestType',
            ),
            const SizedBox(height: 8.0),
            Text('${LocalizationService.translate('from')}: $from'),
            const SizedBox(height: 8.0),
            Text('${LocalizationService.translate('to')}: $to'),
            const SizedBox(height: 8.0),
            Chip(
              label: Text(LocalizationService.translate(status)),
              backgroundColor: Colors.blue,
              labelStyle: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
