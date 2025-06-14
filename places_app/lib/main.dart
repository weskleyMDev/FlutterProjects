import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite_ffi;

import 'providers/places_provider.dart';
import 'screens/home_screen.dart';
import 'screens/place_form_screen.dart';
import 'themes/text_theme.dart';
import 'themes/theme.dart';
import 'utils/app_routes.dart';

void main() {
  if (Platform.isWindows) {
    sqflite_ffi.databaseFactory = sqflite_ffi.databaseFactoryFfi;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final TextTheme textTheme = createTextTheme(
      context,
      "Nunito Sans",
      "Nunito",
    );
    final MaterialTheme theme = MaterialTheme(textTheme);
    return ChangeNotifierProvider(
      create: (context) => PlacesProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Places App',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routes: {
          AppRoutes.home: (_) => HomeScreen(),
          AppRoutes.placeForm: (_) => PlaceFormScreen(),
        },
      ),
    );
  }
}
