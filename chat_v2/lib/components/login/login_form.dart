import 'package:chat_v2/models/app_user.dart';
import 'package:chat_v2/stores/form/login/login_form.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get_it/get_it.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, this.user});

  final AppUser? user;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _loginStore = GetIt.instance<LoginFormStore>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formKey.currentState?.save();
    try {
      if (_loginStore.isLogin) {
        await _loginStore.signIn();
      } else {
        await _loginStore.signUp();
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_loginStore.error ?? e.toString())),
      );
    } finally {
      _clearFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    AnimatedSize(
                      duration: Duration(seconds: 1),
                      curve: Curves.easeIn,
                      child: AnimatedOpacity(
                        opacity: _loginStore.isLogin ? 0.0 : 1.0,
                        duration: Duration(seconds: 2),
                        curve: Curves.easeInOutBack,
                        child: _loginStore.isLogin
                            ? SizedBox.shrink()
                            : Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                child: TextFormField(
                                  key: const ValueKey('name'),
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    label: Text(
                                      'Name',
                                      style: TextStyle(color: Colors.purple),
                                    ),
                                    prefixIcon: Icon(FontAwesome5.user_alt),
                                  ),
                                  style: TextStyle(color: Colors.purple),
                                  cursorColor: Colors.purple,
                                  onSaved: (value) =>
                                      _loginStore.formData['name'] = value
                                          ?.trim(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    if (value.length < 3) {
                                      return 'Name must be at least 3 characters';
                                    }
                                    final valid = RegExp(
                                      r'^[a-zA-Z]+$',
                                    ).hasMatch(value);
                                    if (!valid) {
                                      return 'Name must contain only letters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        key: const ValueKey('email'),
                        controller: _emailController,
                        decoration: InputDecoration(
                          label: Text(
                            'Email',
                            style: TextStyle(color: Colors.purple),
                          ),
                          prefixIcon: Icon(FontAwesome5.envelope),
                        ),
                        style: TextStyle(color: Colors.purple),
                        cursorColor: Colors.purple,
                        onSaved: (value) => _loginStore.formData['email'] =
                            value?.trim().toLowerCase(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          final valid = RegExp(
                            r'^[a-z0-9._-]+@[a-z0-9-]+\.(com|org|net|gov|edu)(\.[a-z]{2})?$',
                          ).hasMatch(value);
                          if (!valid) {
                            return 'Please enter a valid email';
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
                          label: Text(
                            'Password',
                            style: TextStyle(color: Colors.purple),
                          ),
                          prefixIcon: Icon(FontAwesome5.key, size: 22.0),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _loginStore.toggleVisible();
                            },
                            iconSize: 28.0,
                            icon: Icon(
                              _loginStore.isVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.purple),
                        cursorColor: Colors.purple,
                        obscureText: !_loginStore.isVisible,
                        onSaved: (value) =>
                            _loginStore.formData['password'] = value?.trim(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async => await _submitForm(),
                  child: Text(_loginStore.isLogin ? 'LOGIN' : 'SIGN UP'),
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    _loginStore.toggleLogin();
                  },
                  child: Text(
                    _loginStore.isLogin
                        ? "Don't have an account? Sign up"
                        : 'Already have an account? Sign in',
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
