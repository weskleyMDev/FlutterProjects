import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'providers/calculate.dart';
import 'providers/fields.dart';
import 'utils/fonts.dart';
import 'utils/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final textTheme = createTextTheme(
      context: context,
      displayFont: 'Lora',
      bodyFont: 'Schibsted Grotesk',
    );
    final theme = MaterialTheme(textTheme: textTheme);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculateProvider()),
        ChangeNotifierProvider(create: (_) => FieldsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'IMC App',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: const HomePage(),
      ),
    );
  }
}
