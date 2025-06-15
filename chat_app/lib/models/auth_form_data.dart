import 'dart:io';

enum AuthMode { login, signup }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.login;

  bool get isLogin => _mode == AuthMode.login;

  void switchMode() {
    _mode = isLogin ? AuthMode.signup : AuthMode.login;
  }
}
