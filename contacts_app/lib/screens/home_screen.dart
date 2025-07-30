import 'package:contacts_app/stores/database/cloud/cloud_db.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cloudStore = GetIt.instance<CloudDbStore>();

  @override
  void initState() {
    super.initState();
    cloudStore.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Observer(
        builder: (_) {
          final contactList = cloudStore.contactsFromFirestore.value ?? [];
          return contactList.isEmpty
                  ? const Center(child: SelectableText('Nenhum contato encontrado!'))
                  : ListView.builder(
                itemCount: contactList.length,
                itemBuilder: (context, index) {
                  final contact = contactList[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(contact.id),
                    ),
                    title: Text(contact.name.toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(contact.email),
                        Text(contact.phone),
                      ],
                    ),
                  );
                },
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}