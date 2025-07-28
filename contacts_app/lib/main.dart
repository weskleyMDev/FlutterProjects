import 'dart:io';

import 'package:contacts_app/services/db/local_db_service.dart';
import 'package:contacts_app/stores/db/db.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'models/contact.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => DbStore(dbService: LocalDbService()));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final store = GetIt.instance<DbStore>();

  @override
  void initState() {
    super.initState();
    store.init();
  }
  
  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              final contact = Contact(
                name: 'Teste2',
                email: 'teste2@teste',
                phone: '123456789',
                imagePath: '',
                id: null,
              );
              store.addContact(contact);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final contactList = store.contactsList;
          switch (store.status) {
            case FutureStatus.pending:
              return const Center(child: CircularProgressIndicator());
            case FutureStatus.rejected:
              return const Center(
                child: Text('Erro ao buscar dados no banco!'),
              );
            case FutureStatus.fulfilled:
              return contactList.isEmpty
                  ? const Center(child: Text('Nenhum contato encontrado!'))
                  : ListView.builder(
                      itemCount: contactList.length,
                      itemBuilder: (context, index) {
                        final contact = contactList[index];
                        return ListTile(
                          title: Text(contact.name),
                          subtitle: Text(contact.email),
                        );
                      },
                    );
          }
        },
      ),
    );
  }
}
