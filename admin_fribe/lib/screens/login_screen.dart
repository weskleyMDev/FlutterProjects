import 'package:admin_fribe/blocs/auth/auth_bloc.dart';
import 'package:admin_fribe/blocs/login_form/login_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final loginState = context.watch<LoginFormBloc>().state;
    final loginBloc = context.read<LoginFormBloc>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState.status == AuthStatus.unauthenticated &&
                authState.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(content: Text(authState.errorMessage!)),
                );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                onChanged: (value) {
                  loginBloc.add(LoginFormEmailChanged(value));
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Email',
                  errorText: loginState.emailErrorText,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  loginBloc.add(LoginFormPasswordChanged(value));
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Password',
                  errorText: loginState.passwordErrorText,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: loginState.isValid
                    ? () => loginBloc.add(const LoginFormSubmitted())
                    : null,
                child: loginState.isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
