import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../components/forms/contact_form.dart';
import '../models/contact.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key, this.contact});

  final Contact? contact;

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(FontAwesome5.user_check),
            tooltip: 'Save',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: ContactForm(),
          ),
        ),
      ),
    );
  }
}
