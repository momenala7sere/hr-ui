import 'package:flutter/material.dart';
import 'CardData.dart';

class DashboardCard extends StatelessWidget {
  final CardData cardData;

  const DashboardCard({required this.cardData, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          if (cardData.route != null) {
            print("DEBUG: Navigating to ${cardData.title}");
            Navigator.push(
              context,
              MaterialPageRoute(builder: cardData.route!),
            );
          } else {
            print("DEBUG: No route defined for ${cardData.title}");
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: cardData.color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        cardData.icon,
                        size: 50.0,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        cardData.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
