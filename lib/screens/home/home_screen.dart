import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:lipread/screens/account/account_screen.dart';
import 'package:lipread/screens/history/history_screen.dart';
import 'package:lipread/screens/notification/notification_screen.dart';
import 'package:lipread/utilities/font_type.dart';
import 'components/home_banner.dart';
import 'components/tab_view.dart';

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
    return DoubleBack(
      message: '한 번 더 뒤로가기 버튼을 누르면 종료됩니다.',
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'LipRead.',
            style: TextStyle(fontFamily: FontType.bronova.name),
          ),
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
        body: NestedScrollView(
          physics: const ClampingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      HomeBanner(),
                    ],
                  ),
                ),
              )
            ];
          },
          body: const TabView(),
        ),
      ),
    );
  }
}
