import 'dart:io';

import 'package:contacts_app/services/backups/backup_service.dart';
import 'package:contacts_app/services/databases/cloud/cloud_db_service.dart';
import 'package:contacts_app/services/databases/local/local_db_service.dart';
import 'package:contacts_app/stores/database/cloud/cloud_db.store.dart';
import 'package:contacts_app/stores/database/local/local_db.store.dart';
import 'package:contacts_app/utils/routes/app_routes.dart';
import 'package:contacts_app/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'firebase_options.dart';

final getIt = GetIt.instance;

void _setup() {
  getIt.registerLazySingleton(
    () => LocalDbStore(
      localDbService: LocalDbService(),
      backupService: BackupService(),
    ),
  );
  getIt.registerLazySingleton(
    () => CloudDbStore(cloudDbService: CloudDbService()),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
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
      theme: brightness == Brightness.light
          ? theme.light()
          : theme.dark(),
      routerConfig: routes,
    );
  }
}
