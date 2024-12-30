import 'package:flutter/material.dart';
import 'package:hr/screens/Leave_History.dart';
import 'package:hr/screens/home/HomePage.dart';
import 'package:hr/localization_service.dart';
import 'package:hr/screens/home/forms/LeaveHistoryApp.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LeaveRequestForm(),
    );
  }
}

class LeaveRequestForm extends StatefulWidget {
  const LeaveRequestForm({super.key});

  @override
  _LeaveRequestFormState createState() => _LeaveRequestFormState();
}

class _LeaveRequestFormState extends State<LeaveRequestForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _leaveDate = DateTime.now();
  TimeOfDay _leaveFromTime = TimeOfDay.now();
  TimeOfDay _leaveToTime = TimeOfDay.now();
  String _description = '';
  String _leavePeriod = '';

  final TextEditingController _leaveDateController = TextEditingController();
  final TextEditingController _leaveFromTimeController =
      TextEditingController();
  final TextEditingController _leaveToTimeController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _leaveDateController.text = '${_leaveDate.toLocal()}'.split(' ')[0];
    _leaveFromTimeController.text = _leaveFromTime.format(context);
    _leaveToTimeController.text = _leaveToTime.format(context);
  }

  @override
  void dispose() {
    _leaveDateController.dispose();
    _leaveFromTimeController.dispose();
    _leaveToTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _leaveDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _leaveDate) {
      setState(() {
        _leaveDate = picked;
        _leaveDateController.text = '${_leaveDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFrom ? _leaveFromTime : _leaveToTime,
    );
    if (picked != null && picked != (isFrom ? _leaveFromTime : _leaveToTime)) {
      setState(() {
        if (isFrom) {
          _leaveFromTime = picked;
          _leaveFromTimeController.text = _leaveFromTime.format(context);
        } else {
          _leaveToTime = picked;
          _leaveToTimeController.text = _leaveToTime.format(context);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
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
        title: Text(
          LocalizationService.translate('new_leave'), // Localized title
          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LeaveHistoryScreen()),
              );
            },
            child: Text(
              LocalizationService.translate('leave_history'), // Localized button
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: LocalizationService.translate('leave_type'),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'personal',
                    child: Text(LocalizationService.translate('personal')),
                  ),
                  DropdownMenuItem(
                    value: 'sick',
                    child: Text(LocalizationService.translate('sick')),
                  ),
                  DropdownMenuItem(
                    value: 'official',
                    child: Text(LocalizationService.translate('official')),
                  ),
                  DropdownMenuItem(
                    value: 'funeral',
                    child: Text(LocalizationService.translate('funeral')),
                  ),
                  DropdownMenuItem(
                    value: 'maternity',
                    child: Text(LocalizationService.translate('maternity')),
                  ),
                  DropdownMenuItem(
                    value: 'vacation_in_exchange',
                    child: Text(LocalizationService.translate('vacation_in_exchange')),
                  ),
                  DropdownMenuItem(
                    value: 'overtime',
                    child: Text(LocalizationService.translate('overtime')),
                  ),
                  DropdownMenuItem(
                    value: 'unpaid_vacation',
                    child: Text(LocalizationService.translate('unpaid_vacation')),
                  ),
                  DropdownMenuItem(
                    value: 'umrah',
                    child: Text(LocalizationService.translate('umrah')),
                  ),
                ],
                onChanged: (value) {
                  // Handle change
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocalizationService.translate('select_leave_type');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: LocalizationService.translate('leave_date'),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                controller: _leaveDateController,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocalizationService.translate('select_leave_date');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: LocalizationService.translate('leave_period'),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'working_hours',
                    child: Text(
                        LocalizationService.translate('working_hours')),
                  ),
                  DropdownMenuItem(
                    value: 'full_day',
                    child: Text(LocalizationService.translate('full_day')),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _leavePeriod = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocalizationService.translate('select_leave_period');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText:
                      LocalizationService.translate('leave_from_time'),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () => _selectTime(context, true),
                  ),
                ),
                controller: _leaveFromTimeController,
                onTap: () => _selectTime(context, true),
                validator: (value) {
                  if (_leavePeriod != 'full_day' &&
                      (value == null || value.isEmpty)) {
                    return LocalizationService.translate(
                        'select_start_time');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText:
                      LocalizationService.translate('leave_to_time'),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () => _selectTime(context, false),
                  ),
                ),
                controller: _leaveToTimeController,
                onTap: () => _selectTime(context, false),
                validator: (value) {
                  if (_leavePeriod != 'full_day' &&
                      (value == null || value.isEmpty)) {
                    return LocalizationService.translate('select_end_time');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: LocalizationService.translate('description'),
                  hintText: LocalizationService.translate('enter_description'),
                  hintStyle: const TextStyle(fontSize: 12),
                ),
                maxLines: 3,
                onChanged: (value) {
                  _description = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return LocalizationService.translate(
                        'enter_valid_description');
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    // Handle file attachment
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.attach_file),
                        const SizedBox(width: 8.0),
                        Text(LocalizationService.translate('attach')),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 120,
                      height: 35,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Handle discard
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 16,
                          color: Colors.black,
                        ),
                        label: Text(
                          LocalizationService.translate('discard'),
                          style: const TextStyle(color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          side: const BorderSide(
                            color: Color.fromARGB(255, 112, 112, 112),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: 35,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Handle save
                          }
                        },
                        icon: const Icon(
                          Icons.save,
                          size: 16,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        label: Text(
                          LocalizationService.translate('save'),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          side: const BorderSide(
                            color: Color(0xffCE5E52),
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaveHistoryPage extends StatelessWidget {
  const LeaveHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationService.translate('leave_history')),
      ),
      body: Center(
        child: Text(LocalizationService.translate('leave_history_page')),
      ),
    );
  }
}
