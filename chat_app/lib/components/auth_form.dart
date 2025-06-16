import 'dart:io';

import 'package:chat_app/utils/capitalize.dart';
import 'package:chat_app/utils/trim_indent.dart';
import 'package:flutter/material.dart';

import '../models/auth_form_data.dart';
import 'user_image.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key, required this.submitAuthForm});

  final void Function(AuthFormData) submitAuthForm;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  @override
  void dispose() {
    super.dispose();
    _focusEmail.dispose();
    _focusPassword.dispose();
  }

  void _selectImage(File image) {
    _formData.image = image;
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    /* if (_formData.image == null && !_formData.isLogin) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_sharp,
                color: Theme.of(context).colorScheme.errorContainer,
              ),
              const SizedBox(width: 8.0),
              Text(
                'Selecione uma imagem válida!'.toUpperCase(),
                style: TextStyle().copyWith(
                  color: Theme.of(context).colorScheme.errorContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
      return;
    } */

    if (!isValid) return;

    _formKey.currentState?.save();

    widget.submitAuthForm(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!_formData.isLogin)
            Column(
              children: [
                UserImage(onImagePick: _selectImage),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: TextFormField(
                    key: ValueKey('name'),
                    initialValue: _formData.name,
                    onChanged: (name) =>
                        _formData.name = name.capitalizeWords(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome',
                    ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_focusEmail);
                    },
                    validator: (value) {
                      final name = value?.trim() ?? '';
                      if (name.isEmpty) {
                        return 'O campo nome é obrigatório!';
                      }
                      if (name.length < 4) {
                        return 'O nome deve ter pelo menos 4 caracteres!';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),

          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              key: ValueKey('email'),
              focusNode: _focusEmail,
              initialValue: _formData.email,
              onChanged: (email) => _formData.email = email.trim(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_focusPassword);
              },
              validator: (value) {
                final email = value?.trim() ?? '';
                if (email.isEmpty) {
                  return 'O campo email é obrigatório!';
                }
                final emailPattern = RegExp(
                  r'^[a-zA-Z0-9.-]+@[a-z]+\.[a-z]{2,}(?:\.[a-z]{2,})?$',
                ).hasMatch(email);
                if (!emailPattern) {
                  return '''
                  Digite um email válido! é aceito:
                  - Letras
                  - Números
                  - Especiais: - .
                  '''
                      .trimIndent();
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              key: ValueKey('password'),
              focusNode: _focusPassword,
              initialValue: _formData.password,
              onChanged: (password) => _formData.password = password.trim(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submitForm(),
              validator: (value) {
                final password = value?.trim() ?? '';
                if (password.length < 6) {
                  return 'A senha deve ter pelo menos 6 caracteres!';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton.icon(
              onPressed: _submitForm,
              label: Text(
                _formData.isLogin
                    ? 'Entrar'.toUpperCase()
                    : 'Cadastrar'.toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: 30.0),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: TextButton(
              onPressed: () => setState(() => _formData.switchMode()),
              child: Text(
                _formData.isLogin
                    ? 'Não possui uma conta? Cadastre-se'
                    : 'Já possui uma conta? Entre',
                textAlign: TextAlign.center,
                style: TextStyle().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
