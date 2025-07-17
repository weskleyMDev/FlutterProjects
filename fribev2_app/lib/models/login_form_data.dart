// ignore_for_file: public_member_api_docs, sort_constructors_first
enum FormMode { login, register }

class LoginFormData {
  String email;
  String password;
  final String role;
  FormMode _mode = FormMode.login;

  LoginFormData({this.email = '', this.password = ''}) : role = 'user';

  bool get isLogin => _mode == FormMode.login;
  bool get isRegister => _mode == FormMode.register;

  void toggleMode() {
    _mode == FormMode.login
        ? _mode = FormMode.register
        : _mode = FormMode.login;
  }

  @override
  String toString() {
    return 'LoginFormData(email: $email, password: $password, role: $role)';
  }
}
