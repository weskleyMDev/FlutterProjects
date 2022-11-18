import 'package:flutter/material.dart';
import 'package:hdc_app/screens/home_page.dart';
import 'package:hdc_app/services/notify_manager.dart';

import '../screens/feedback.dart';
import '../screens/qr_scanner.dart';
import '../screens/tabs.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/home': (_) => const MyHomePage(),
    '/tabs': (_) => TabScreen(NotifyManager.notificationAppLaunchDetails),
    '/feedback': (_) => FeedbackScreen(NotifyManager.selectedPayload),
    '/qrscan': (_) => const QRScannerScreen(),
  };
  static String inital = '/home';
  static String feedback = '/feedback';
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
