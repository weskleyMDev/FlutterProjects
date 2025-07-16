import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'interfaces/impl/api_implementation.dart';
import 'pages/home_page.dart';
import 'services/api_service.dart';
import 'utils/theme.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final theme = MaterialTheme();
    return MultiProvider(
      providers: [
        Provider(create: (_) => ApiService(apiInterface: ApiImplementation())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: Locale('pt', 'BR'),
        supportedLocales: [Locale('pt', 'BR'), Locale('en', 'US')],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        title: 'Currency Converter',
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        home: const HomePage(),
      ),
    );
  }
}
