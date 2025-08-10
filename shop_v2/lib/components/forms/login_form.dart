import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/auth/auth_form.store.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormData = GetIt.instance.get<AuthFormStore>();
  final _loginFormKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    } else {
      _loginFormKey.currentState!.save();
      await _loginFormData.loginUser();
      if (!mounted) return;
      context.goNamed('home-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              key: const ValueKey('email'),
              controller: _emailController,
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.email),
              ),
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) =>
                  _loginFormData.authFormData['email'] = newValue?.trim(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.enter_email;
                }
                final validate = RegExp(
                  r'^[a-z0-9._-]+@[a-z0-9-]+\.(com|org|net|gov|edu)(\.[a-z]{2})?$',
                ).hasMatch(value.trim());
                if (!validate) {
                  return AppLocalizations.of(context)!.enter_valid_email;
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              key: const ValueKey('password'),
              controller: _passwordController,
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.password),
              ),
              obscureText: true,
              onSaved: (newValue) =>
                  _loginFormData.authFormData['password'] = newValue?.trim(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.enter_password;
                }
                if (value.trim().length < 6) {
                  return AppLocalizations.of(context)!.password_length;
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(AppLocalizations.of(context)!.forgot_password),
              ),
            ),
          ),
          FilledButton(
            onPressed: _submitData,
            child: Text(AppLocalizations.of(context)!.sign_in.toUpperCase()),
          ),
        ],
      ),
    );
  }
}
