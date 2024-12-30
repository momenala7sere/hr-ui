import 'package:flutter/material.dart';
import 'package:hr/localization_service.dart';
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
    title: LocalizationService.translate('vacation_request'),
    icon: Icons.person_add,
    color: Colors.green,
    route: (context) => const VacationRequestForm(),
  ),
  CardData(
    title: LocalizationService.translate('leave_request'),
    icon: Icons.schedule,
    color: Colors.yellow,
    route: (context) => const LeaveRequestForm(),
  ),
  CardData(
    title: LocalizationService.translate('vacations_history'),
    icon: Icons.pending_actions,
    color: Colors.purple,
    route: (context) => const VacationHistoryApp(),
  ),
  CardData(
    title: LocalizationService.translate('leaves_history'),
    icon: Icons.content_paste_go_rounded,
    color: Colors.black,
    route: (context) => const LeaveHistoryApp(),
  ),
  CardData(
    title: LocalizationService.translate('hr_request'),
    icon: Icons.groups,
    color: Colors.blueGrey,
    route: (context) => const HrRequestForm(),
  ),
  CardData(
    title: LocalizationService.translate('hr_requests_history'),
    icon: Icons.history,
    color: Colors.purpleAccent,
    route: (context) => const HrHistoryRequestApp(),
  ),
  CardData(
    title: LocalizationService.translate('track_my_request'),
    icon: Icons.pin_drop,
    color: Colors.indigoAccent,
    route: (context) => const TrackMyRequest(),
  ),
];
