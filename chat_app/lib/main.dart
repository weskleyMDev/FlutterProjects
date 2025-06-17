import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'factorys/firebase_services_factory.dart';
import 'screens/auth_home.dart';
import 'screens/notification_screen.dart';
import 'themes/font.dart';
import 'themes/theme.dart';
import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;

    TextTheme textTheme = createTextTheme(context, "Raleway", "Raleway");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              FirebaseServicesFactory.instance.createNotificationService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        routes: {
          AppRoutes.home: (_) => const AuthOrHome(),
          AppRoutes.notifications: (_) => const NotificationScreen(),
        },
      ),
    );
  }
}
