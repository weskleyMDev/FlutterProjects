import 'package:flutter/widgets.dart';

import '../screens/home_screen.dart';
import '../screens/player_screen.dart';
// import '../screens/scanner_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> list = {
    HomeScreen.route: (_) => const HomeScreen(),
    PlayerScreen.route: (_) => const PlayerScreen(),
    // ScannerScreen.route: (_) => const ScannerScreen(),
  };
  static const initial = HomeScreen.route;
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}
