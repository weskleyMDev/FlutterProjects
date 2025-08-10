import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/auth/auth_form.store.dart';
import 'package:shop_v2/utils/capitalize.dart';

class NewAccForm extends StatefulWidget {
  const NewAccForm({super.key});

  @override
  State<NewAccForm> createState() => _NewAccFormState();
}

class _NewAccFormState extends State<NewAccForm> {
  final _registerFormData = GetIt.instance.get<AuthFormStore>();
  final _registerFormKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitData() async {
    if (!_registerFormKey.currentState!.validate()) {
      return;
    } else {
      _registerFormKey.currentState!.save();
      await _registerFormData.registerUser();
      _registerFormKey.currentState!.reset();
      _registerFormData.dispose();
      if (!mounted) return;
      context.goNamed('home-screen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _registerFormKey,
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                height: 200.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                label: Text(AppLocalizations.of(context)!.select_image),
                icon: Icon(FontAwesome5.camera_retro),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: TextFormField(
              key: const ValueKey('name'),
              controller: _nameController,
              decoration: InputDecoration(
                label: Text(AppLocalizations.of(context)!.user_name),
              ),
              onSaved: (newValue) => _registerFormData.authFormData['name'] =
                  newValue?.trim().capitalize(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.enter_name;
                }
                if (value.trim().length < 3) {
                  return AppLocalizations.of(context)!.name_length;
                }
                return null;
              },
            ),
          ),
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
                  _registerFormData.authFormData['email'] = newValue?.trim(),
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
                  _registerFormData.authFormData['password'] = newValue?.trim(),
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
          FilledButton(
            onPressed: _submitData,
            child: Text(AppLocalizations.of(context)!.sign_up.toUpperCase()),
          ),
        ],
      ),
    );
  }
}
