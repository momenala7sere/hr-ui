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
      home: VacationRequestForm(),
    );
  }
}

class VacationRequestForm extends StatefulWidget {
  const VacationRequestForm({super.key});

  @override
  _VacationRequestFormState createState() => _VacationRequestFormState();
}

class _VacationRequestFormState extends State<VacationRequestForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  String _description = '';
  String _employeeAddress = '';
  String _alternativeEmployee = '';
  String _employeePhoneNumber = '';

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isStart ? _startDate : _endDate)) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Vacation',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to vacation history page
            },
            child: const Text(
              'Vacations History',
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
                  labelText: 'Vacation Type',
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
                  labelText: 'Start Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, true),
                  ),
                ),
                onTap: () => _selectDate(context, true),
                controller: TextEditingController(
                    text: '${_startDate.toLocal()}'.split(' ')[0]),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'End Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context, false),
                  ),
                ),
                onTap: () => _selectDate(context, false),
                controller: TextEditingController(
                    text: '${_endDate.toLocal()}'.split(' ')[0]),
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
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Employee Address',
                  hintText: "Please Enter Address",
                  hintStyle: TextStyle(fontSize: 10),
                ),
                onChanged: (value) {
                  _employeeAddress = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Alternative Employee',
                ),
                onChanged: (value) {
                  _alternativeEmployee = value;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Employee Phone No.',
                  hintText: "Please Enter Your Phone Number ",
                  hintStyle: TextStyle(fontSize: 10),
                ),
                onChanged: (value) {
                  _employeePhoneNumber = value;
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
                              color: Color.fromARGB(255, 112, 112,
                                  112), // Set your desired border color
                              width: 1.0, // Adjust border width
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
                              borderRadius: BorderRadius.circular(
                                  6.0), // Adjust radius as needed
                            ),
                            side: const BorderSide(
                              color: Color(
                                  0xffCE5E52), // Set your desired border color
                              width: 1.0, // Adjust border width
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
