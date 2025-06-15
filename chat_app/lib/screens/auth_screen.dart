import 'package:flutter/material.dart';

import '../components/auth_form.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: constraints.maxHeight * 0.6,
                width: constraints.maxWidth *0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                child: AuthForm(),
              ),
            );
          },
        ),
      ),
    );
  }
}
