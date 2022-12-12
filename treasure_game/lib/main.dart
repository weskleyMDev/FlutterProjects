import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'utils/routes.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Treasure Game',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        canvasColor: Colors.blueGrey[200],
      ),
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.list,
      navigatorKey: AppRoutes.navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
