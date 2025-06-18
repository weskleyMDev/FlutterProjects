import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/messages.dart';
import '../components/new_message.dart';
import '../factorys/local_services_factory.dart';
import '../models/chat_notification.dart';
import '../services/notification/local_notification_service.dart';
import '../utils/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localService = LocalServicesFactory.instance.createAuthService();
    final notifyService = Provider.of<LocalNotificationService>(
      context,
      listen: false,
    );
    final newNotification = ChatNotification(
      title: 'New Message',
      body: 'You have a new message',
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(localService.currentUser!.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_sharp),
            onPressed: () {
              notifyService.addNotification(newNotification);
            },
          ),
          Consumer<LocalNotificationService>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.notifications);
              },
              icon: const Icon(Icons.notification_important_sharp),
            ),
            builder: (context, service, child) => Badge.count(
              count: service.count,
              isLabelVisible: service.count > 0,
              offset: Offset(-2.0, 5.0),
              child: child!,
            ),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 'logout',
                child: Row(
                  children: [
                    const Icon(Icons.logout_sharp),
                    const SizedBox(width: 8.0),
                    const Text('Logout'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'logout') {
                localService.signout();
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Column(
            children: [
              Expanded(child: Messages()),
              NewMessage(),
            ],
          ),
        ),
      ),
    );
  }
}
