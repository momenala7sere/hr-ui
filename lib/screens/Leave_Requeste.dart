import 'package:flutter/material.dart';
import 'package:hr/screens/home/HomePage.dart';

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
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        title: const Text(
          'New Leave',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LeaveHistoryPage()),
              );
            },
            child: const Text(
              'Leave History',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                decoration: const InputDecoration(
                  labelText: 'Leave Type',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'personal',
                    child: Text('Personal'),
                  ),
                  DropdownMenuItem(
                    value: 'sick',
                    child: Text('Sick'),
                  ),
                  DropdownMenuItem(
                    value: 'Official',
                    child: Text('Official'),
                  ),
                  DropdownMenuItem(
                    value: 'Funeral',
                    child: Text('Funeral'),
                  ),
                  DropdownMenuItem(
                    value: 'Maternity ',
                    child: Text('Maternity '),
                  ),
                  DropdownMenuItem(
                    value: 'Vacation in exchange for working ',
                    child: Text('Vacation in exchange for working '),
                  ),
                  DropdownMenuItem(
                    value: 'Overtime  ',
                    child: Text('Overtime  '),
                  ),
                  DropdownMenuItem(
                    value: 'Unpaid vacation   ',
                    child: Text('Unpaid vacation '),
                  ),
                  DropdownMenuItem(
                    value: 'Umrah   ',
                    child: Text('Umrah '),
                  ),
                  // Add more types if needed
                ],
                onChanged: (value) {
                  // Handle change
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a leave type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Leave Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                controller: _leaveDateController,
                onTap: () => _selectDate(context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a leave date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Leave Period',
                ),
                items: const [
                  DropdownMenuItem(
                    value:
                        'Leave during working hours',
                    child: Text(
                        'Leave during working hours'),
                  ),
                  DropdownMenuItem(
                    value: 'full_day',
                    child: Text('Full Day'),
                  ),
                  // Add more types if needed
                ],
                onChanged: (value) {
                  setState(() {
                    _leavePeriod = value!;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a leave period';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Leave From Time',
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
                    return 'Please select a start time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Leave To Time',
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
                    return 'Please select an end time';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: "Please Enter Description",
                  hintStyle: TextStyle(fontSize: 12),
                ),
                maxLines: 3,
                onChanged: (value) {
                  _description = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
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
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.attach_file),
                        SizedBox(width: 8.0),
                        Text('Attach'),
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
                        label: const Text(
                          'Discard',
                          style: TextStyle(color: Colors.black),
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
                        label: const Text(
                          'Save',
                          style: TextStyle(
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
        title: const Text('Leave History'),
      ),
      body: const Center(
        child: Text('This is the leave history page'),
      ),
    );
  }
}
