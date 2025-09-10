import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fribev2_app/firebase_options.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/services/stock/firebase_stock_service.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:provider/provider.dart';

import 'services/auth/firebase_auth_service.dart';
import 'services/sales/firebase_sales_service.dart';
import 'stores/auth.store.dart';
import 'stores/cart.store.dart';
import 'stores/payment.store.dart';
import 'stores/sales.store.dart';
import 'stores/sales_filter.store.dart';
import 'utils/app_routes.dart';
import 'utils/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        Provider(create: (_) => StockStore(FirebaseStockService())),
        Provider(create: (_) => SalesStore(FirebaseSalesService())),
        Provider(create: (_) => CartStore()),
        Provider(create: (_) => SalesFilterStore()),
        Provider(create: (_) => PaymentStore()),
      ],
      child: MaterialApp.router(
        title: 'Fribe Cortes Especiais',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: brightness == Brightness.light ? theme.light() : theme.dark(),
        routerConfig: router,
      ),
    );
  }
}
