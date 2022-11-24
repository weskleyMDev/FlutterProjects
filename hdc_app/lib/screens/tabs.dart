import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hdc_app/screens/feedback.dart';
import 'package:hdc_app/widgets/alarm_home.dart';
import 'package:hdc_app/widgets/receitas_home.dart';

import '../services/notify_manager.dart';

class TabScreen extends StatefulWidget {
  const TabScreen(this.notificationAppLaunchDetails, {super.key});

  static const String routeName = '/tabs';

  final NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
  }

  void _configureSelectNotificationSubject() {
    NotifyManager.selectNotificationStream.stream.listen((String? payload) async {
      await Navigator.of(context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => FeedbackScreen(payload),
      ));
    });
  }

  @override
  void dispose() {
    NotifyManager.selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
        appBar: AppBar(
          foregroundColor: Colors.black,
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
              height: 10.0,
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
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
                          'Lembretes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Receitas',
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
            const Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: AlarmesHome(),
                  ),
                  Center(
                    child: ReceitasHome(),
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

