import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hdc_app/services/notify_manager.dart';

import 'alarm_home.dart';
import 'receitas_home.dart';

class TabScreen extends StatefulWidget {
  const TabScreen(this.notificationAppLaunchDetails, {super.key});

  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
        appBar: AppBar(
          title: const Text(
            'Hora de Cuidar',
            style: TextStyle(
              fontSize: 24,
              color: Color.fromRGBO(5, 40, 46, 1),
            ),
          ),
          backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(5, 40, 46, 1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    isScrollable: false,
                    unselectedLabelColor: Colors.grey,
                    labelColor: const Color.fromRGBO(5, 40, 46, 1),
                    tabs: const [
                      Tab(
                        child: Text(
                          'Receitas',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Alarmes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  const Center(
                    child: ReceitasHome(),
                  ),
                  Center(
                    child: AlarmesHome(NotifyManager.notificationAppLaunchDetails),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
