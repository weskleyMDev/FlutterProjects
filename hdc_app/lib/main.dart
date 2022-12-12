import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hdc_app/widgets/alarm_modal.dart';

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
        timePickerTheme: TimePickerThemeData(
          backgroundColor: const Color.fromRGBO(231, 249, 251, 1),
          helpTextStyle: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(5, 40, 46, 1),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          hourMinuteShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          hourMinuteColor: Colors.lightBlue[200],
          hourMinuteTextColor: const Color.fromRGBO(5, 40, 46, 1),
          dialBackgroundColor: Colors.lightBlue[200],
          dialTextColor: MaterialStateColor.resolveWith(
            (states) => states.contains(MaterialState.selected)
                ? Colors.white
                : const Color.fromRGBO(5, 40, 46, 1),
          ),
          dialHandColor: Colors.lightBlue,
          entryModeIconColor: const Color.fromRGBO(5, 40, 46, 1),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) => Colors.lightBlue,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: NotifyManager.initialRoute,
      routes: {
        MyHomePage.routeName: (_) => const MyHomePage(),
        TabScreen.routeName: (_) =>
            TabScreen(NotifyManager.notificationAppLaunchDetails),
        QRScannerScreen.routeName: (_) => const QRScannerScreen(),
        FeedbackScreen.routeName: (_) =>
            FeedbackScreen(NotifyManager.selectedPayload),
        AlarmModal.route: (_) => const AlarmModal(),
      },
    );
  }
}
