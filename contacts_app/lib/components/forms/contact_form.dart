import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';

import '../../models/contact.dart';
import 'image_formfield.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({super.key, this.contact, this.onSubmit});

  final Contact? contact;
  final Future<void> Function(Map<String, dynamic>)? onSubmit;

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
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _mailController.text = widget.contact!.email;
      _phoneController.text = widget.contact!.phone;
      if (widget.contact!.imagePath.isNotEmpty) {
        _image = _loadImage(widget.contact!.imagePath);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  File? _loadImage(String imagePath) {
    try {
      File file = File(imagePath);
      if (file.existsSync()) {
        return file;
      } else {
        throw Exception('Image file not found');
      }
    } catch (e) {
      return null;
    }
  }

  void _clearForm() {
    _nameController.clear();
    _mailController.clear();
    _phoneController.clear();
    setState(() {
      _image = null;
      _formKey.currentState?.reset();
      _formData.clear();
    });
  }

  void _selectImage(File image) => _image = image;

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Changes will not be saved.'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Nevermind'),
              onPressed: () {
                context.pop(false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                context.pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formKey.currentState?.save();
    _formData['image'] = _image?.path ?? '';
    if (widget.onSubmit != null) {
      await widget.onSubmit!(_formData);
    }
    _clearForm();
  }

  bool get emptyFields =>
      _nameController.text.isEmpty &&
      _mailController.text.isEmpty &&
      _phoneController.text.isEmpty;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }
        if (_isEditing) {
          final shouldLeave = await _showBackDialog() ?? false;
          if (context.mounted && shouldLeave) {
            context.pop();
          }
        } else {
          context.pop();
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: ImageFormField(
                    onImageSelected: _selectImage,
                    imagePath: _image,
                  ),
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
                    onSaved: (name) => _formData['name'] = name?.trim(),
                    onChanged: (name) {
                      if (widget.contact?.name == name || emptyFields) {
                        setState(() => _isEditing = false);
                      } else {
                        setState(() => _isEditing = true);
                      }
                    },
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
                    onSaved: (mail) => _formData['mail'] = mail?.trim(),
                    onChanged: (mail) {
                      final newMail = mail.trim();
                      if (newMail == widget.contact?.email || emptyFields) {
                        setState(() => _isEditing = false);
                      } else {
                        setState(() => _isEditing = true);
                      }
                    },
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
                    onSaved: (phone) => _formData['phone'] = phone?.trim(),
                    onChanged: (phone) {
                      final newPhone = phone.trim();
                      if (newPhone == widget.contact?.phone || emptyFields) {
                        setState(() => _isEditing = false);
                      } else {
                        setState(() => _isEditing = true);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () async {
                await _submitForm();
                if (!context.mounted) return;
                context.go('/');
              },
              child: Text('SAVE', overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
