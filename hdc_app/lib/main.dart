import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/feedback.dart';
import 'screens/home_page.dart';
import 'screens/qr_scanner.dart';
import 'screens/tabs.dart';
import 'services/notify_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HDC - Hora de Cuidar',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: NotifyManager.initialRoute,
      routes: {
        MyHomePage.routeName: (_) => const MyHomePage(),
        TabScreen.routeName: (_) => TabScreen(NotifyManager.notificationAppLaunchDetails),
        QRScannerScreen.routeName: (_) => const QRScannerScreen(),
        FeedbackScreen.routeName: (_) => FeedbackScreen(NotifyManager.selectedPayload),
      },
    );
  }
}
