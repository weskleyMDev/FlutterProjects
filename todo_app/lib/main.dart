import 'package:flutter/material.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 12.0,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme().copyWith(
          border: OutlineInputBorder(),
        ),
        textTheme: TextTheme().copyWith(
          displayLarge: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
        ),
      ),
      home: const HomePage(),
    );
  }
}
