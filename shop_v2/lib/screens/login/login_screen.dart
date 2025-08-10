import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_v2/components/forms/login_form.dart';
import 'package:shop_v2/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.sign_in),
        actions: [
          IconButton(
            onPressed: () => context.pushNamed('new-acc-screen'),
            icon: const Icon(FontAwesome5.user_plus),
            tooltip: AppLocalizations.of(context)!.new_account,
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 8.0),
      ),
      body: LoginForm(),
    );
  }
}
