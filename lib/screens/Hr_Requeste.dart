import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

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
        } else {
          _leaveToTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New HR Request',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to leave history page
            },
            child: const Text(
              'HR Request History',
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
                  labelText: ' Request Type',
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Request for support letter - طلب تأييد شركة ',
                    child: Text('Request for support letter - طلب تأييد شركة '),
                  ),
                  DropdownMenuItem(
                    value:
                        'Request for experience certificate - طلب شهادة خبرة',
                    child: Text(
                        'Request for experience certificate - طلب شهادة خبرة'),
                  ),
                  DropdownMenuItem(
                    value: 'Request for company email- طلب بريد الكتروني  ',
                    child:
                        Text('Request for company email- طلب بريد الكتروني '),
                  ),
                  DropdownMenuItem(
                    value:
                        ' Request for company badge - طلب الحصول على شارة الشركة',
                    child: Text(
                        ' Request for company badge - طلب الحصول على شارة الشركة'),
                  ),

                  // Add more types if needed
                ],
                onChanged: (value) {
                  // Handle change
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Request Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                onTap: () => _selectDate(context),
                controller: TextEditingController(
                    text: '${_leaveDate.toLocal()}'.split(' ')[0]),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Directed To ',
                  hintText: "Optional",
                  hintStyle: TextStyle(fontSize: 12),
                ),
                maxLines: 3,
                onChanged: (value) {
                  _description = value;
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
                            borderRadius: BorderRadius.circular(
                                6.0), // Adjust radius as needed
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
                              color: Color.fromARGB(255, 255, 255, 255)),
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
