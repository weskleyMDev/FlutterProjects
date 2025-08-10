import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';
import 'package:shop_v2/stores/auth/auth_form.store.dart';

class NewAccForm extends StatefulWidget {
  const NewAccForm({super.key});

  @override
  State<NewAccForm> createState() => _NewAccFormState();
}

class _NewAccFormState extends State<NewAccForm> {
  final _formData = GetIt.instance.get<AuthFormStore>();
  final _authStore = GetIt.instance.get<AuthStore>();
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

  void _resetData() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _registerFormKey.currentState!.reset();
    _formData.dispose();
  }

  Future<void> _submitData() async {
    if (!_registerFormKey.currentState!.validate()) {
      return;
    } else {
      _registerFormKey.currentState!.save();
      await _formData.registerUser();
      _resetData();
      print(_authStore.currentUser);
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
              onSaved: (newValue) =>
                  _formData.authFormData['name'] = newValue?.trim(),
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
                  _formData.authFormData['email'] = newValue?.trim(),
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
                  _formData.authFormData['password'] = newValue?.trim(),
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
