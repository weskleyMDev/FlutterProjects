import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'pages/home_page.dart';
import 'services/data/local_service.dart';
import 'stores/todo.store.dart';
import 'utils/theme.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<TodoStore>(
    () => TodoStore(dataService: LocalDataService()),
    instanceName: 'todoStore',
    dispose: (todo) => todo.dispose(),
  );
}

void main() {
  setup();
  runApp(const MyApp());
}

final darkTheme = ThemeData.dark(useMaterial3: true);
final lightTheme = ThemeData.light(useMaterial3: true);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    final theme = MaterialTheme();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo V2',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => HomePage())),
            child: Text('Go'),
          ),
        ),
      ),
    );
  }
}
