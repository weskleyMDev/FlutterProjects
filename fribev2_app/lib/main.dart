import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'services/auth/firebase_auth_service.dart';
import 'services/stock/firebase_stock_service.dart';
import 'stores/auth.store.dart';
import 'stores/stock.store.dart';
import 'utils/app_routes.dart';
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
        Provider(create: (_) => AuthStore(authService: FirebaseAuthService())),
        Provider(
          create: (_) => StockStore(stockService: FirebaseStockService()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Fribe Cortes Especiais',
        debugShowCheckedModeBanner: false,
        locale: const Locale('pt', 'BR'),
        supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        routerConfig: router,
      ),
    );
  }
}
