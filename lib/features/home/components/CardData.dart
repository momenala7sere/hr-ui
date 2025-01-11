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

  CardData copyWith({
    String? title,
    IconData? icon,
    Color? color,
    Widget Function(BuildContext)? route,
  }) {
    return CardData(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      route: route ?? this.route,
    );
  }
}
