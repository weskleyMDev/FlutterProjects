import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/notification/firebase_notification_service.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifyService = Provider.of<FirebaseNotificationService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Notificações')),
      body: ListView.builder(
        itemCount: notifyService.items.length,
        itemBuilder: (context, index) {
          final item = notifyService.items[index];
          return ListTile(
            title: Text(item.title),
            subtitle: Text(item.body),
            onTap: () => notifyService.removeAt(index),
          );
        },
      ),
    );
  }
}
