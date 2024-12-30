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
        onTap: cardData.route != null
            ? () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: cardData.route!),
                )
            : null,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: cardData.color, // Use the card's color
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              height: 3.5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      cardData.icon, // Use the card's icon
                      size: 50.0,
                      color: cardData.color,
                    ),
                    const SizedBox(height: 8.0),
                    Directionality(
                      textDirection: Localizations.localeOf(context).languageCode == 'ar'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: Text(
                        cardData.title.isNotEmpty ? cardData.title : 'Untitled Card', // Fallback title
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: cardData.color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
