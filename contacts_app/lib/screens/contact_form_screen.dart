import 'package:contacts_app/stores/database/cloud/cloud_db.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';

import '../components/forms/contact_form.dart';
import '../models/contact.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key, this.contact});

  final Contact? contact;

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final cloudStore = GetIt.instance<CloudDbStore>();

  Future<void> _submitForm(Map<String, dynamic> formData) async {
    try {
      if (widget.contact == null) {
        final contact = Contact(
          id: Uuid().v4(),
          name: formData['name'],
          email: formData['mail'],
          phone: formData['phone'],
          imagePath: formData['image'],
        );
        await cloudStore.saveContact(contact.toMap());
      } else {
        final contact = Contact(
          id: widget.contact!.id,
          name: formData['name'],
          email: formData['mail'],
          phone: formData['phone'],
          imagePath: formData['image'],
        );
        await cloudStore.saveContact(contact.toMap());
      }
    } catch (e) {
      throw Exception('Error saving contact: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.contact == null
              ? 'New Contact'
              : 'Edit ${widget.contact?.name}',
        ),
        actionsPadding: const EdgeInsets.only(right: 8.0),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: ContactForm(contact: widget.contact, onSubmit: _submitForm),
          ),
        ),
      ),
    );
  }
}
