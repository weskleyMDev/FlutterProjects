import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
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

  void _showSnackBar(String? message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message ?? 'Unknown error')));
  }

  Future<void> _submitData() async {
    if (!_loginFormKey.currentState!.validate()) {
      return;
    } else {
      try {
        _loginFormKey.currentState!.save();
        _loginFormData.toggleLoading();
        await _loginFormData.loginUser();
        _loginFormKey.currentState!.reset();
        _loginFormData.dispose();
        if (!mounted) return;
        context.goNamed('home-screen');
      } on FirebaseAuthException catch (e) {
        _showSnackBar(e.message);
      } catch (e) {
        _showSnackBar(null);
      } finally {
        _loginFormData.toggleLoading();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
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
                    prefixIcon: Icon(FontAwesome5.at, size: 22.0),
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
                child: Observer(
                  builder: (_) {
                    return TextFormField(
                      key: const ValueKey('password'),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        label: Text(AppLocalizations.of(context)!.password),
                        prefixIcon: Icon(FontAwesome5.expeditedssl, size: 22.0),
                        suffixIcon: (_loginFormData.isVisible)
                            ? IconButton(
                                onPressed: _loginFormData.toggleVisibility,
                                icon: const Icon(Icons.visibility_off),
                              )
                            : IconButton(
                                onPressed: _loginFormData.toggleVisibility,
                                icon: const Icon(Icons.visibility),
                              ),
                      ),
                      obscureText: !_loginFormData.isVisible,
                      onSaved: (newValue) =>
                          _loginFormData.authFormData['password'] = newValue
                              ?.trim(),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return AppLocalizations.of(context)!.enter_password;
                        }
                        if (value.trim().length < 6) {
                          return AppLocalizations.of(context)!.password_length;
                        }
                        return null;
                      },
                    );
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
              Observer(
                builder: (_) {
                  return FilledButton(
                    onPressed: (_loginFormData.isLoading) ? null : _submitData,
                    child: Text(
                      AppLocalizations.of(context)!.sign_in.toUpperCase(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Observer(
          builder: (_) {
            return (_loginFormData.isLoading)
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black87,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
