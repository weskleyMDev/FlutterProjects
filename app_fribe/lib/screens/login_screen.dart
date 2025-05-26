import 'package:app_fribe/screens/user_screen.dart';
import 'package:app_fribe/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool isLoading = false;
  bool isPasswordVisible = true;

  void _login() async {
    setState(() {
      isLoading = true;
    });

    String? result = await _authService.login(
      email: nameController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (result == 'admin' || result == 'user') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userRole', result!);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) =>
                  result == 'admin' ? const AdminScreen() : const UserScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(result ?? 'Erro ao fazer login')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/fribe.png",
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Usuário",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                isLoading
                    ? Center(child: const CircularProgressIndicator())
                    : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text("Entrar"),
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
