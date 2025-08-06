import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/firebase_options.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/services/login/firebase_service.dart';
import 'package:shop_v2/services/stock/stock_service.dart';
import 'package:shop_v2/stores/login/login.store.dart';
import 'package:shop_v2/stores/stock/home.store.dart';
import 'package:shop_v2/utils/routes/app_routes.dart';
import 'package:shop_v2/utils/theme/theme.dart';

final getIt = GetIt.instance;
void _setup() {
  getIt.registerLazySingleton(
    () => LoginStore(loginService: FirebaseService()),
  );
  getIt.registerLazySingleton(() => HomeStore(stockService: StockService()));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _setup();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final theme = CustomTheme();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Shop V2',
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: routes,
    );
  }
}
