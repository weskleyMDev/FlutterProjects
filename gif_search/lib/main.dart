import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:gif_search/utils/routes.dart';

import 'services/api/api_service.dart';
import 'stores/api/api.store.dart';
import 'utils/theme.dart';

final getIt = GetIt.instance;
Future<void> _setup() async {
  getIt.registerLazySingleton(() => ApiStore(apiService: ApiService()));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setup();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final theme = MyTheme();
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Gifs Search',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      routerConfig: routes,
    );
  }
}
