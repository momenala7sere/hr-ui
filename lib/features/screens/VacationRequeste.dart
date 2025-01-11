import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hr/generic_bloc.dart';
import 'package:hr/generic_event.dart';
import 'package:hr/generic_state.dart';
import 'package:hr/localization_service.dart';
import 'package:hr/screens/Vacation_History.dart';

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
  String? _selectedFile; // To store the selected file path or name

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startDateController.text = '${_startDate.toLocal()}'.split(' ')[0];
    _endDateController.text = '${_endDate.toLocal()}'.split(' ')[0];
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

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
          _startDateController.text = '${_startDate.toLocal()}'.split(' ')[0];
        } else {
          _endDate = picked;
          _endDateController.text = '${_endDate.toLocal()}'.split(' ')[0];
        }
      });
    }
  }

  void _submitForm(BuildContext context) {
  if (_formKey.currentState!.validate()) {
    final requestData = {
      'type': 'vacation_request',
      'startDate': _startDate.toIso8601String(),
      'endDate': _endDate.toIso8601String(),
      'description': _description,
      'employeeAddress': _employeeAddress,
      'alternativeEmployee': _alternativeEmployee,
      'employeePhoneNumber': _employeePhoneNumber,
      'attachedFile': _selectedFile,
    };

    context.read<GenericBloc>().add(SubmitData(data: requestData));
  }
}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GenericBloc(),
      child: BlocListener<GenericBloc, GenericState>(
        listener: (context, state) {
          if (state is GenericLoaded) {
            final successMessage = state.data['message'] ?? 'Request submitted!';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(successMessage)),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const VacationHistoryScreen()),
            );
          } else if (state is GenericError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              LocalizationService.translate('new_vacation'),
              style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VacationHistoryScreen(),
                    ),
                  );
                },
                child: Text(
                  LocalizationService.translate('vacation_history'),
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
                      labelText: LocalizationService.translate('vacation_type'),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: 'funeral',
                        child: Text(LocalizationService.translate('funeral')),
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
                        value: 'maternity',
                        child: Text(LocalizationService.translate('maternity')),
                      ),
                      DropdownMenuItem(
                        value: 'overtime',
                        child: Text(LocalizationService.translate('overtime')),
                      ),
                      DropdownMenuItem(
                        value: 'unpaid_vacation',
                        child: Text(
                          LocalizationService.translate('unpaid_vacation'),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'umrah',
                        child: Text(LocalizationService.translate('umrah')),
                      ),
                    ],
                    onChanged: (value) {
                      // Handle change
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: LocalizationService.translate('start_date'),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () => _selectDate(context, true),
                      ),
                    ),
                    controller: _startDateController,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: LocalizationService.translate('end_date'),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_month),
                        onPressed: () => _selectDate(context, false),
                      ),
                    ),
                    controller: _endDateController,
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: LocalizationService.translate('description'),
                      hintText: LocalizationService.translate('enter_description'),
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      _description = value;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: LocalizationService.translate('employee_address'),
                      hintText: LocalizationService.translate('enter_address'),
                    ),
                    onChanged: (value) {
                      _employeeAddress = value;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText:
                          LocalizationService.translate('alternative_employee'),
                    ),
                    onChanged: (value) {
                      _alternativeEmployee = value;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: LocalizationService.translate('phone_number'),
                      hintText: LocalizationService.translate('enter_phone'),
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
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          setState(() {
                            _selectedFile = result.files.single.name;
                          });

                          print("Selected File: ${result.files.single.path}");
                        } else {
                          print("File selection canceled.");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.attach_file),
                            const SizedBox(width: 8.0),
                            Text(
                              _selectedFile != null
                                  ? _selectedFile!
                                  : LocalizationService.translate('attach'),
                            ),
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
                            onPressed: () => _submitForm(context),
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
        ),
      ),
    );
  }
}