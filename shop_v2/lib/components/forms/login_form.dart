import 'package:flutter/material.dart';
import 'package:shop_v2/l10n/app_localizations.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();

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
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.password),
              ),
              obscureText: true,
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
          OutlinedButton(
            onPressed: () {},
            child: Text(AppLocalizations.of(context)!.sign_in.toUpperCase()),
          ),
        ],
      ),
    );
  }
}
