import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/messages.dart';
import '../components/new_message.dart';
import '../factorys/firebase_services_factory.dart';
import '../services/notification/local_notification_service.dart';
import '../utils/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _showUserImage(String url) {
    ImageProvider? provider;
    final uri = Uri.parse(url);

    if (uri.path.contains('assets')) {
      provider = AssetImage('assets/images/user_image_pattern.png');
    } else if (uri.scheme == 'http') {
      provider = NetworkImage(uri.toString());
    } else {
      try {
        String decodePath = Uri.decodeFull(uri.path);
        final file = File(decodePath);
        if (file.existsSync()) {
          provider = FileImage(file);
        } else {
          provider = AssetImage('assets/images/user_image_pattern.png');
        }
      } catch (_) {
        provider = AssetImage('assets/images/user_image_pattern.png');
      }
    }
    return CircleAvatar(backgroundImage: provider);
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseServicesFactory.instance.createAuthService();
    final user = auth.currentUser;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
          child: _showUserImage(user!.imageUrl),
        ),
        title: Text(user.name),
        actions: [
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
                auth.signOut();
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
