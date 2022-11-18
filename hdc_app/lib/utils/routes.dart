import 'package:flutter/material.dart';
import 'package:hdc_app/main.dart';
import 'package:hdc_app/services/notify_manager.dart';

import '../widgets/feedback.dart';
import '../widgets/qr_scanner.dart';
import '../widgets/tabs.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> list =
      <String, WidgetBuilder>{
    '/': (_) => MyHomePage(NotifyManager.notificationAppLaunchDetails),
    '/home': (_) => TabScreen(NotifyManager.notificationAppLaunchDetails),
    '/feedback': (_) => FeedbackScreen(NotifyManager.selectedPayload),
    '/qrscan': (_) => const QRScannerScreen(),
  };
  static String inital = '/';
  static String feedback = '/feedback';
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
