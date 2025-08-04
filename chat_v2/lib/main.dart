import 'package:chat_v2/services/auth/firebase_auth_service.dart';
import 'package:chat_v2/services/database/firestore_messages.dart';
import 'package:chat_v2/stores/form/login/login_form.store.dart';
import 'package:chat_v2/stores/form/message/message_form.store.dart';
import 'package:chat_v2/utils/route/app_routes.dart';
import 'package:chat_v2/utils/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';

final getIt = GetIt.instance;
void _setup() {
  getIt.registerLazySingleton(
    () => MessageFormStore(databaseService: FirestoreMessages()),
  );
  getIt.registerLazySingleton(
    () => LoginFormStore(authService: FirebaseAuthService()),
  );
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
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: routes,
    );
  }
}
