import 'package:chat_v2/utils/route/app_routes.dart';
import 'package:chat_v2/utils/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'firebase_options.dart';
import 'stores/form/input_form.store.dart';

final getIt = GetIt.instance;
void _setup() {
  getIt.registerLazySingleton(() => InputFormStore());
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
      title: 'Flutter Demo',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: routes,
    );
  }
}
