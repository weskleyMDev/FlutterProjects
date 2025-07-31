import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import '../../models/contact.dart';
import 'image_formfield.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key, this.contact});

  final Contact? contact;

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mailController = TextEditingController();
  final _phoneController = TextEditingController();
  final Map<String, dynamic> _formData = {};
  File? _image;

  @override
  void dispose() {
    _nameController.dispose();
    _mailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _nameController.clear();
    _mailController.clear();
    _phoneController.clear();
    _image = null;
    _formKey.currentState?.reset();
    _formData.clear();
  }

  void _selectImage(File image) => _image = image;

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formKey.currentState?.save();
    _formData['image'] = _image?.path ?? '';
    print(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: ImageFormField(onImageSelected: _selectImage),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  key: const ValueKey('name'),
                  controller: _nameController,
                  decoration: const InputDecoration(
                    label: Text('Name', overflow: TextOverflow.ellipsis),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(FontAwesome5.user),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid name';
                    }
                    return null;
                  },
                  onSaved: (name) => _formData['name'] = name?.trim() ?? '',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  key: const ValueKey('mail'),
                  controller: _mailController,
                  decoration: const InputDecoration(
                    label: Text('Mail', overflow: TextOverflow.ellipsis),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(FontAwesome5.envelope),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (mail) => _formData['mail'] = mail?.trim() ?? '',
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  key: const ValueKey('phone'),
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    label: Text('Phone', overflow: TextOverflow.ellipsis),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Entypo.mobile),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid phone number';
                    }
                    return null;
                  },
                  onSaved: (phone) => _formData['phone'] = phone?.trim() ?? '',
                ),
              ),
            ],
          ),
          const SizedBox(height: 40.0),
          ElevatedButton(
            onPressed: () async {
              await _submitForm();
              _clearForm();
              print(_formData);
            },
            child: Text('SAVE', overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
