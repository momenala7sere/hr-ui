import 'package:flutter/material.dart';
import 'package:hr/localization_service.dart';
import 'package:hr/screens/hr/Hr_History.dart'; // Import localization service

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HrRequestForm(),
    );
  }
}

class HrRequestForm extends StatefulWidget {
  const HrRequestForm({super.key});

  @override
  _HrRequestFormState createState() => _HrRequestFormState();
}

class _HrRequestFormState extends State<HrRequestForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime _leaveDate = DateTime.now();
  String _description = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(
    LocalizationService.translate('new_hr_request'), // Localized title
    style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
  ),
  actions: [
    TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HrHistoryRequestScreen(), // Navigate to HrHistoryRequestScreen
          ),
        );
      },
      child: Text(
        LocalizationService.translate('hr_request_history'),
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
                  labelText: LocalizationService.translate('request_type'),
                ),
                items: [
                  DropdownMenuItem(
                    value: 'support_letter',
                    child:
                        Text(LocalizationService.translate('support_letter')),
                  ),
                  DropdownMenuItem(
                    value: 'experience_certificate',
                    child: Text(
                      LocalizationService.translate('experience_certificate'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'company_email',
                    child: Text(
                      LocalizationService.translate('company_email'),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'company_badge',
                    child: Text(LocalizationService.translate('company_badge')),
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
                  labelText: LocalizationService.translate('request_date'),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                onTap: () => _selectDate(context),
                controller: TextEditingController(
                  text: '${_leaveDate.toLocal()}'.split(' ')[0],
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: LocalizationService.translate('directed_to'),
                  hintText: LocalizationService.translate('optional'),
                  hintStyle: const TextStyle(fontSize: 12),
                ),
                maxLines: 3,
                onChanged: (value) {
                  _description = value;
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
