import 'package:app_fribe/firebase_options.dart';
import 'package:app_fribe/screens/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'theme/meat_app_theme_material3.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await clearFirestoreCache();
  runApp(const MyApp());
}

Future<void> clearFirestoreCache() async {
  try {
    await FirebaseFirestore.instance.clearPersistence();
  } catch (e) {
    throw Exception('Failed to clear Firestore cache: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fribe Cortes Especiais',
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: meatAppTheme,
      home: SplashScreen(),
    );
  }
}
