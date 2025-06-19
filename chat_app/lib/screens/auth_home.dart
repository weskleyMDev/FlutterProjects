import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../factorys/firebase_services_factory.dart';
import '../models/chat_user.dart';
import '../services/notification/local_notification_service.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
import 'loading_screen.dart';

class AuthOrHome extends StatefulWidget {
  const AuthOrHome({super.key});

  @override
  State<AuthOrHome> createState() => _AuthOrHomeState();
}

class _AuthOrHomeState extends State<AuthOrHome> {
  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    if (!context.mounted) return;
    await Provider.of<LocalNotificationService>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseServicesFactory.instance.createAuthService();
    return FutureBuilder(
      future: init(context),
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          return StreamBuilder<ChatUser?>(
            stream: auth.userChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return LoadingScreen();
              } else {
                return (snapshot.hasData)
                    ? const HomeScreen()
                    : const AuthScreen();
              }
            },
          );
        }
      },
    );
  }
}
