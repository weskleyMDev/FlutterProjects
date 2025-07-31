import 'package:contacts_app/stores/database/local/local_db.store.dart';
import 'package:flutter/material.dart';

import '../../models/contact.dart';
import 'contact_list_item.dart';

class ContactList extends StatelessWidget {
  const ContactList({
    super.key,
    required this.contactList,
    required this.store,
  });

  final List<Contact> contactList;
  final LocalDbStore store;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactList.length,
      itemBuilder: (context, index) {
        final contact = contactList[index];
        return ContactListItem(contact: contact, store: store);
      },
    );
  }
}
