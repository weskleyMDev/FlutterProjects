import 'package:contacts_app/stores/database/cloud/cloud_db.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';

import '../../models/contact.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem({
    super.key,
    required this.contact,
    required this.store,
  });

  final Contact contact;
  final CloudDbStore store;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.blue,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: BehindMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                context.pushNamed('edit-contact', extra: contact);
              },
              backgroundColor: Colors.blue,
              icon: FontAwesome5.user_edit,
              label: 'Editar',
              padding: EdgeInsets.zero,
            ),
            SlidableAction(
              onPressed: (_) async {
                await store.deleteContact(id: contact.id);
              },
              backgroundColor: Colors.red,
              icon: FontAwesome5.user_times,
              label: 'Deletar',
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(14.0),
              ),
              padding: EdgeInsets.zero,
            ),
          ],
        ),
        child: Card(
          margin: EdgeInsets.zero,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            leading: CircleAvatar(child: Text(contact.id)),
            title: Text(
              contact.name.toUpperCase(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(contact.email), Text(contact.phone)],
            ),
          ),
        ),
      ),
    );
  }
}
