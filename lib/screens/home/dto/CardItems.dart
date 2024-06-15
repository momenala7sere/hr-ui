import 'package:flutter/material.dart';
import 'package:hr/screens/Track_My_Request.dart';
import 'package:hr/screens/hr/Hr_History.dart';
import 'package:hr/screens/hr/Hr_Requeste.dart';

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
    route: (context) => const HrRequestForm(),
  ),
  CardData(
    title: 'HR Requests History',
    icon: Icons.history,
    color: Colors.purpleAccent,
    route: (context) => const HrHistoryRequestApp(),
  ),
  CardData(
    title: 'Track My Request',
    icon: Icons.pin_drop,
    color: Colors.indigoAccent,
    route: (context) => const TrackMyRequest(),
  ),
];
