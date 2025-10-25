import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localdb/blocs/sync_todos/sync_todos_bloc.dart';
import 'package:localdb/blocs/todo_view/todo_view_bloc.dart';
import 'package:localdb/database/local_db/todo_dao.dart';
import 'package:localdb/database/remote_db/remote_db.dart';
import 'package:localdb/firebase_options.dart';
import 'package:localdb/generated/l10n.dart';
import 'package:localdb/repositories/todo_repository.dart';
import 'package:localdb/utils/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => TodoDao()),
        RepositoryProvider(create: (_) => RemoteDb()),
        RepositoryProvider(
          create: (context) => TodoRepository(
            todoDao: context.read<TodoDao>(),
            remoteDb: context.read<RemoteDb>(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodoViewBloc(todoDao: context.read<TodoDao>()),
          ),
          BlocProvider(
            create: (context) =>
                SyncTodosBloc(todoRepository: context.read<TodoRepository>())
                  ..add(const GetSyncedCountEvent()),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          darkTheme: ThemeData.dark(),
          themeMode: ThemeMode.system,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: routes,
        ),
      ),
    );
  }
}
