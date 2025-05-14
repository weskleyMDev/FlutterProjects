import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import 'admin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = "user"; // Default role
  bool isLoading = false;
  bool isPasswordVisible = true;

  final AuthService _authService = AuthService();

  void _signup() async {
    setState(() {
      isLoading = true;
    });
    String? result = await _authService.signup(
      email: nameController.text,
      password: passwordController.text,
      role: selectedRole,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (result == null) {
      // Signup successful
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Signup successful!")));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminScreen(),
        ),
      );
    } else {
      // Handle error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $result")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Funcionário"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/add-user.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Bem Vindo a Fribe",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Username",
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
                    labelText: "Password",
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
                const SizedBox(height: 10),
                DropdownButtonFormField(
                  value: selectedRole,
                  items:
                      ['admin', 'user'].map((role) {
                        return DropdownMenuItem(value: role, child: Text(role));
                      }).toList(),
                  decoration: InputDecoration(
                    labelText: "Role",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                isLoading
                    ? Center(child: const CircularProgressIndicator())
                    : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _signup,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 50,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text("Cadastrar"),
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