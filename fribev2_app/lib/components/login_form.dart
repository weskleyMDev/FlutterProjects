import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../models/form_data/login_form_data.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onSubmit});

  final void Function(LoginFormData) onSubmit;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginFormData _formData = LoginFormData();
  bool _isVisible = false;

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
    );
  }

  void _submitForm() {
    try {
      final bool isValid = _formKey.currentState?.validate() ?? false;
      if (!isValid) return;
      widget.onSubmit(_formData);
    } catch (e) {
      _showSnackbar(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: SvgPicture.asset(
                  'assets/images/logo.svg',
                  height: 200.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  key: const ValueKey('email'),
                  initialValue: _formData.email,
                  onChanged: (value) => _formData.email = value,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail_outline_sharp),
                  ),
                  validator: (value) {
                    final name = value?.trim() ?? '';
                    if (name.isEmpty) return 'Email is required!';
                    if (!RegExp(
                      r'^[a-z0-9._-]+@[a-z0-9.-]+\.[a-zA-Z]{2,}$',
                    ).hasMatch(name)) {
                      return 'Invalid email format!';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 12.0),
                child: TextFormField(
                  key: const ValueKey('password'),
                  initialValue: _formData.password,
                  onChanged: (value) => _formData.password = value,
                  obscureText: !_isVisible,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_outline_sharp),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: Icon(
                        _isVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                  validator: (value) {
                    final password = value?.trim() ?? '';
                    if (password.isEmpty) return 'Password is required!';
                    if (password.length < 6) {
                      return 'Password must be at least 6 characters!';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 22.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(_formData.isLogin ? 'ENTRAR' : 'CADASTRAR'),
              ),
              const SizedBox(height: 50.0),
              // TextButton(
              //   onPressed: () {
              //     setState(() {
              //       _formData.toggleMode();
              //     });
              //   },
              //   child: Text(
              //     _formData.isLogin ? 'CRIAR NOVA CONTA' : 'ENTRAR',
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
