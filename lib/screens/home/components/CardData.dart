import 'package:flutter/material.dart';

class CardData {
  final String title;
  final IconData icon;
  final Color color;
  final Widget Function(BuildContext)? route;

  CardData({
    required this.title,
    required this.icon,
    required this.color,
    this.route,
  });
}