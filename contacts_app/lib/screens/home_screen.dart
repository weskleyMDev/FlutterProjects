import 'package:contacts_app/stores/database/cloud/cloud_db.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../components/lists/contact_list.dart';

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
        title: Text('My Contacts'),
        actionsPadding: const EdgeInsets.only(right: 8.0),
        actions: [
          Observer(
            builder: (_) {
              return IconButton(
                onPressed: cloudStore.sortContacts,
                icon: Icon(
                  cloudStore.isSorted
                      ? FontAwesome5.sort_alpha_down
                      : FontAwesome5.sort_alpha_down_alt,
                ),
              );
            },
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          switch (cloudStore.status) {
            case FutureStatus.pending:
              return const Center(child: CircularProgressIndicator());
            case FutureStatus.rejected:
              return const Center(child: Text('Error loading data!'));
            default:
              final contactList = cloudStore.contactsList;
              return contactList.isEmpty
                  ? const Center(child: SelectableText('None contacts found!'))
                  : Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      child: ContactList(
                        contactList: contactList,
                        store: cloudStore,
                      ),
                    );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed('new-contact');
        },
        tooltip: 'Add Contact',
        child: const Icon(FontAwesome5.user_plus),
      ),
    );
  }
}
