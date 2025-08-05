import 'package:chat_v2/stores/form/login/login_form.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get_it/get_it.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final loginStore = GetIt.instance<LoginFormStore>();
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

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formKey.currentState?.save();
    print(loginStore.formData);
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
                        opacity: loginStore.isLogin ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 2500),
                        curve: Curves.easeInOutBack,
                        child: loginStore.isLogin
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
                                      loginStore.formData['name'] = value
                                          ?.trim(),
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
                        onSaved: (value) =>
                            loginStore.formData['email'] = value?.trim(),
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
                              loginStore.toogleVisible();
                            },
                            iconSize: 28.0,
                            icon: Icon(
                              loginStore.isVisible
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.purple),
                        cursorColor: Colors.purple,
                        obscureText: !loginStore.isVisible,
                        onSaved: (value) =>
                            loginStore.formData['password'] = value?.trim(),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () async => await _submitForm(),
                  child: Text(loginStore.isLogin ? 'LOGIN' : 'SIGN UP'),
                ),
                const SizedBox(height: 20.0),
                InkWell(
                  onTap: () {
                    loginStore.toogleLogin();
                  },
                  child: Text(
                    loginStore.isLogin
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
