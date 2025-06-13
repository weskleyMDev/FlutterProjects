import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/image_input.dart';
import '../providers/places_provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {
  final _focusDescription = FocusNode();
  final _formKey = GlobalKey<FormState>();
  File? _pickedImage;
  final Map<String, String> _formData = {};

  @override
  void dispose() {
    super.dispose();
    _focusDescription.dispose();
  }

  void _selectedImage(File pickedImage) => _pickedImage = pickedImage;
  void _submitForm() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid || _pickedImage == null) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.error_outline_sharp, color: Colors.red.shade700),
              const SizedBox(width: 8.0),
              Text('Selecione uma imagem válida!'.toUpperCase()),
            ],
          ),
        ),
      );
      return;
    }

    _formKey.currentState?.save();

    Provider.of<PlacesProvider>(
      context,
      listen: false,
    ).savePlace(_formData, _pickedImage!);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Novo Lugar')),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ImageInput(onImagePick: _selectedImage),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Título',
                          prefixIcon: Icon(Icons.title_sharp),
                        ),
                        onSaved: (title) => _formData['title'] = title ?? '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo título';
                          }
                          if (value.length < 3) {
                            return 'Título deve ter pelo menos 3 caracteres';
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(
                          context,
                        ).requestFocus(_focusDescription),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Descrição',
                          prefixIcon: Icon(Icons.description_sharp),
                        ),
                        onSaved: (description) =>
                            _formData['title'] = description ?? '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Preencha o campo descrição';
                          }
                          if (value.length < 3) {
                            return 'Descrição deve ter pelo menos 3 caracteres';
                          }
                          return null;
                        },
                        focusNode: _focusDescription,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _submitForm(),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child: ElevatedButton.icon(
                    onPressed: _submitForm,
                    label: Text('Salvar'.toUpperCase()),
                    icon: Icon(Icons.save_sharp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
