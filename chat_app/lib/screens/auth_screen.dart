import 'package:flutter/material.dart';

import '../components/auth_form.dart';
import '../factorys/firebase_services_factory.dart';
import '../models/auth_form_data.dart';
import '../services/authentication/auth_service.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLoading = false;
  final AuthService auth = FirebaseServicesFactory.instance.createAuthService();

  Future<void> _handleSubmitedForm(AuthFormData formData) async {
    try {
      if (mounted) {
        setState(() => _isLoading = true);
      }
      if (formData.isLogin) {
        await auth.signIn(formData.email, formData.password);
      } else {
        await auth.signUp(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (_) {
      rethrow;
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: AuthForm(submitAuthForm: _handleSubmitedForm),
                ),
              ),
            ),
            if (_isLoading)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
