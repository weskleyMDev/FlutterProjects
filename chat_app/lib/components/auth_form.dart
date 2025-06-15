import 'package:flutter/material.dart';

import '../models/auth_form_data.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submitForm() {
    _formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!_formData.isLogin)
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              key: ValueKey('name'),
              initialValue: _formData.name,
              onChanged: (name) => _formData.name = name,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              key: ValueKey('email'),
              initialValue: _formData.email,
              onChanged: (email) => _formData.email = email,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              key: ValueKey('password'),
              initialValue: _formData.password,
              onChanged: (password) => _formData.password = password,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Senha',
              ),
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
          Spacer(),
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
