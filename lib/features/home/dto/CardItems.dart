import 'package:flutter/material.dart';
import 'package:hr/features/home/forms/LeaveHistoryApp.dart';
import 'package:hr/features/home/forms/LeaveRequestForm.dart';
import 'package:hr/features/home/forms/VacationRequestForm.dart';
import 'package:hr/features/screens/Vacation_History.dart';
import 'package:hr/localization_service.dart';
import 'package:hr/screens/Track_My_Request.dart';
import 'package:hr/screens/home/forms/VacationHistoryApp.dart';
import 'package:hr/screens/hr/Hr_History.dart';
import 'package:hr/screens/hr/Hr_Requeste.dart';
import '../components/CardData.dart';

final List<CardData> cardItems = [
  CardData(
    title: LocalizationService.translate('vacation_request'),
    icon: Icons.person_add,
    color: const Color(0xFFCE5E52),
    route: (context) => const VacationRequestForm(),
  ),
  CardData(
    title: LocalizationService.translate('leave_request'),
    icon: Icons.schedule,
    color: const Color(0xFFCE5E52),
    route: (context) => const LeaveRequestForm(),
  ),
  CardData(
    title: LocalizationService.translate('vacations_history') ??
        'Vacations History',
    icon: Icons.pending_actions,
    color: const Color(0xFFCE5E52),
    route: (context) => const VacationHistoryScreen(),
  ),
  CardData(
    title: LocalizationService.translate('leaves_history') ?? 'Leaves History',
    icon: Icons.content_paste_go_rounded,
    color: const Color(0xFFCE5E52),
    route: (context) => const LeaveHistoryApp(),
  ),
  CardData(
    title: LocalizationService.translate('hr_request') ?? 'HR Request',
    icon: Icons.groups,
    color: const Color(0xFFCE5E52),
    route: (context) => const HrRequestForm(),
  ),
  CardData(
    title: LocalizationService.translate('hr_requests_history') ??
        'HR Requests History',
    icon: Icons.history,
    color: const Color(0xFFCE5E52),
    route: (context) => const HrHistoryRequestScreen(),
  ),
  CardData(
    title:
        LocalizationService.translate('track_my_request') ?? 'Track My Request',
    icon: Icons.pin_drop,
    color: const Color(0xFFCE5E52),
    route: (context) => const TrackMyRequest(),
  ),
];
