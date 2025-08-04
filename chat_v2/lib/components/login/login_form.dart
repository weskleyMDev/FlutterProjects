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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Observer(
          builder: (context) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.7,
                    child: Column(
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
                                          style: TextStyle(
                                            color: Colors.purple,
                                          ),
                                        ),
                                        prefixIcon: Icon(FontAwesome5.user_alt),
                                      ),
                                      style: TextStyle(color: Colors.purple),
                                      cursorColor: Colors.purple,
                                      forceErrorText: 'teste',
                                    ),
                                  ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              key: const ValueKey('email'),
                              controller: _emailController,
                              decoration: InputDecoration(
                                label: Text(
                                  'Email',
                                  style: TextStyle(color: Colors.purple),
                                ),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(FontAwesome5.envelope),
                                suffixIconColor: Colors.purple,
                                prefixIconColor: Colors.purple,
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                ),
                                errorStyle: TextStyle(color: Colors.red),
                              ),
                              style: TextStyle(color: Colors.purple),
                              cursorColor: Colors.purple,
                              forceErrorText: 'teste',
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
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
                              forceErrorText: 'teste',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(loginStore.isLogin ? 'LOGIN' : 'SIGN UP'),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        loginStore.toogleLogin();
                      },
                      child: Text(
                        loginStore.isLogin
                            ? "Dont't have an account? Sign up"
                            : "Already have an account? Sign in",
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
