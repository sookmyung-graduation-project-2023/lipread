import 'package:flutter/material.dart';
import 'package:lipread/screens/account/account_screen.dart';
import 'package:lipread/screens/history/history_screen.dart';
import 'package:lipread/screens/notification/notification_screen.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'widgets/home_banner.dart';
import 'widgets/tab_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _routeToHistoryScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const HistoryScreen()));
  }

  void _routeToNotificationScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NotificationScreen()));
  }

  void _routeToAccountScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AccountScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LipRead.'),
        actions: [
          IconButton(
            onPressed: () => _routeToHistoryScreen(context),
            icon: const Icon(Icons.calendar_month_outlined),
          ),
          IconButton(
            onPressed: () => _routeToNotificationScreen(context),
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () => _routeToAccountScreen(context),
            icon: const Icon(Icons.account_circle_outlined),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  HomeBanner(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            TabView(),
          ],
        ),
      ),
    );
  }
}
