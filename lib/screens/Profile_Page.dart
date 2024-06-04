import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String userName;
  final String userIdRole;
  final int annualLeave;
  final int sickLeave;
  final int requestedVacations;
  final double requestedLeaveHours;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.userIdRole,
    required this.annualLeave,
    required this.sickLeave,
    required this.requestedVacations,
    required this.requestedLeaveHours,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white, // Customize background color
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // User Information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName,
                  style: const TextStyle(fontSize: 18.0),
                ),
                Text(
                  userIdRole,
                  style: const TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
              ],
            ),
            const Divider(thickness: 1.0),

            // Leave Balances
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Annual Leave'),
                Text('$annualLeave Days'),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sick Leave'),
                Text('$sickLeave Days'),
              ],
            ),

            const Divider(thickness: 1.0),

            // Vacation Requests
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Requested Vacations'),
                Text('$requestedVacations Days'),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Requested Leaves'),
                Text('$requestedLeaveHours Hours'),
              ],
            ),

            const Spacer(), // Push content to top

            // Button (assuming custom button)
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextButton(
                onPressed: () {
                  // Handle button press (e.g., navigate to leave request screen)
                },
                child: const Text(
                  'Submit Leave Request',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
