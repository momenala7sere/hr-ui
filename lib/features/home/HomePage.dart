import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hr/generic_bloc.dart';
import 'package:hr/generic_event.dart';
import 'package:hr/generic_state.dart';
import 'package:hr/localization_service.dart';
import 'package:hr/screens/home/LeaveBalanceBadge.dart';
import 'package:hr/screens/home/MessageBadge.dart';
import 'package:hr/screens/home/NotificationBadge.dart';
import 'package:hr/screens/home/dto/CardItems.dart';
import 'components/DashboardCard.dart';
import 'components/Drawer.dart';
import 'components/CardData.dart';

class HomePage extends StatelessWidget {
  final Locale currentLocale;

  const HomePage({super.key, required this.currentLocale});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GenericBloc(
        fetchDataCallback: () async {
          // Simulate fetching data
          await Future.delayed(const Duration(seconds: 1));
          return {
            'leaveBalance': 5,
            'notificationCount': 10,
            'messageCount': 3,
            'cards': cardItems.map((card) {
              return card.copyWith(
                title: LocalizationService.translate(card.title) ?? card.title,
              );
            }).toList(),
          };
        },
      )..add(FetchData()),
      child: BlocBuilder<GenericBloc, GenericState>(
        builder: (context, state) {
          if (state is GenericLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is GenericLoaded) {
            final data = state.data ?? {};
            return MyDashboard(
              currentLocale: currentLocale,
              leaveBalance: data['leaveBalance'] ?? 0,
              notificationStream: Stream.value(data['notificationCount'] ?? 0),
              messageStream: Stream.value(data['messageCount'] ?? 0),
              cards: data['cards'] ?? cardItems,
            );
          } else if (state is GenericError) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
              ),
            );
          }
          return const Scaffold(
            body: Center(child: Text('No data available.')),
          );
        },
      ),
    );
  }
}

class MyDashboard extends StatelessWidget {
  final Locale currentLocale;
  final int leaveBalance;
  final Stream<int> notificationStream;
  final Stream<int> messageStream;
  final List<dynamic> cards;

  const MyDashboard({
    super.key,
    required this.currentLocale,
    required this.leaveBalance,
    required this.notificationStream,
    required this.messageStream,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationService.translate('dashboard_title')),
        actions: [
          LeaveBalanceBadge(leaveBalance: leaveBalance),
          NotificationBadge(
            notificationStream: notificationStream,
            onNotificationSelected: (value) {
              print('Notification Selected: $value');
            },
          ),
          MessageBadge(
            messageStream: messageStream,
            onMessageSelected: (value) {
              print('Message Selected: $value');
            },
          ),
        ],
      ),
      drawer: buildDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: cards.length,
          itemBuilder: (BuildContext context, int index) {
            final cardData = cards[index] as CardData;
            return DashboardCard(cardData: cardData);
          },
        ),
      ),
    );
  }
}
