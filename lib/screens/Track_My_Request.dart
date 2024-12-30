import 'package:flutter/material.dart';
import 'package:hr/localization_service.dart'; // Import localization service
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TrackMyRequest(),
    );
  }
}
class TrackMyRequest extends StatefulWidget {
  const TrackMyRequest({super.key});

  @override
  _TrackMyRequestState createState() => _TrackMyRequestState();
}

class _TrackMyRequestState extends State<TrackMyRequest> {
  final List<Map<String, dynamic>> requests = [
    {
      'id': 3411,
      'employee': 'Mohammed',
      'requestType': 'Return From Reservation',
      'requestDate': DateTime.parse('2023-05-02 10:30:32'),
      'status': 'Requested',
    },
    {
      'id': 2550,
      'employee': 'Nisreen',
      'requestType': 'Vacation',
      'requestDate': DateTime.parse('2023-06-01 10:30:32'),
      'status': 'Requested',
    },
  ];

  DateTime? fromDate;
  DateTime? toDate;
  String requestType = 'All';

  List<Map<String, dynamic>> get filteredRequests {
    return requests.where((request) {
      bool matchesDateRange = true;
      bool matchesRequestType = true;

      if (fromDate != null) {
        matchesDateRange = request['requestDate'].isAfter(fromDate!) ||
            request['requestDate'].isAtSameMomentAs(fromDate!);
      }
      if (toDate != null) {
        matchesDateRange = matchesDateRange &&
            (request['requestDate'].isBefore(toDate!) ||
                request['requestDate'].isAtSameMomentAs(toDate!));
      }
      if (requestType != 'All') {
        matchesRequestType = request['requestType'] == requestType;
      }

      return matchesDateRange && matchesRequestType;
    }).toList();
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != (isFromDate ? fromDate : toDate)) {
      setState(() {
        if (isFromDate) {
          fromDate = picked;
        } else {
          toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 8.0), // Add spacing between icon and title
            Text(LocalizationService.translate('track_my_requests')),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocalizationService.translate('from_date')),
            GestureDetector(
              onTap: () => _selectDate(context, true),
              child: AbsorbPointer(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: fromDate == null
                        ? LocalizationService.translate('from_date')
                        : DateFormat('yyyy-MM-dd').format(fromDate!),
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(LocalizationService.translate('to_date')),
            GestureDetector(
              onTap: () => _selectDate(context, false),
              child: AbsorbPointer(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: toDate == null
                        ? LocalizationService.translate('to_date')
                        : DateFormat('yyyy-MM-dd').format(toDate!),
                    suffixIcon: const Icon(Icons.calendar_month),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(LocalizationService.translate('request_type')),
            DropdownButton<String>(
              value: requestType,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  requestType = newValue!;
                });
              },
              items: <String>['All', 'Return From Reservation', 'Vacation']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    LocalizationService.translate(value), // Translate value
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle search
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffCE5E52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      LocalizationService.translate('search'),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRequests.length,
                itemBuilder: (context, index) {
                  final request = filteredRequests[index];
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(request['id'].toString()),
                      ),
                      title: Text(request['employee']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocalizationService.translate('request_type') +
                                ': ${request['requestType']}',
                          ),
                          Text(
                            LocalizationService.translate('request_date') +
                                ': ${DateFormat('yyyy-MM-dd HH:mm:ss').format(request['requestDate'])}',
                          ),
                        ],
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: request['status'] == 'Requested'
                              ? Colors.blue
                              : Colors.grey,
                        ),
                        child: Text(request['status']),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
