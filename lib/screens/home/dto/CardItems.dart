import 'package:flutter/material.dart';

import '../../Leave_History.dart';
import '../../Leave_Requeste.dart';
import '../../VacationRequeste.dart';
import '../../Vacation_History.dart';
import '../components/CardData.dart';

final List<CardData> cardItems = [
  CardData(
    title: 'Vacation Request',
    icon: Icons.person_add,
    color: Colors.green,
    route: (context) => const VacationRequestForm(),
  ),
  CardData(
    title: 'Job Description',
    icon: Icons.assignment_ind,
    color: Colors.red,
  ),
  CardData(
    title: 'Leave Request',
    icon: Icons.schedule,
    color: Colors.yellow,
    route: (context) => const LeaveRequestForm(),
  ),
  CardData(
    title: 'Vacations History',
    icon: Icons.pending_actions,
    color: Colors.purple,
    route: (context) => const VacationHistoryApp(),
  ),
  CardData(
    title: 'Leaves History',
    icon: Icons.content_paste_go_rounded,
    color: Colors.black,
    route: (context) => const LeaveHistoryApp(),
  ),
  CardData(
    title: 'HR Request',
    icon: Icons.groups,
    color: Colors.blueGrey,
  ),
  CardData(
    title: 'HR Requests History',
    icon: Icons.history,
    color: Colors.purpleAccent,
  ),
  CardData(
    title: 'Track My Request',
    icon: Icons.pin_drop,
    color: Colors.indigoAccent,
  ),
  CardData(
    title: 'Purchase Request',
    icon: Icons.shopping_cart,
    color: Colors.grey,
  ),
];