import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/login_form.dart';
import '../models/form_data/login_form_data.dart';
import '../stores/auth.store.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  void _handleLoginData(LoginFormData formData) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    try {
      setState(() => _isLoading = true);
      if (formData.isLogin) {
        authStore.login(email: formData.email, password: formData.password);
      } else {
        authStore.signup(email: formData.email, password: formData.password);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error processing login: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [LoginForm(onSubmit: _handleLoginData)],
                  ),
                ),
              ),
              if (_isLoading)
                Container(
                  color: Colors.black54,
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
