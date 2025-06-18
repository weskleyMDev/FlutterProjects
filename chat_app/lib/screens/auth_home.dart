import 'package:chat_app/models/chat_user.dart' show ChatUser;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../factorys/firebase_services_factory.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
import 'loading_screen.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({super.key});

  Future<FirebaseApp> _initializeFirebase() {
    return Firebase.initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseServicesFactory.instance.createAuthService();
    return FutureBuilder(
      future: _initializeFirebase(),
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
                return (snapshot.hasData) ? const HomeScreen() : const AuthScreen();
              }
            },
          );
        }
      },
    );
  }
}
