import 'package:admin_shop/blocs/auth/auth_bloc.dart';
import 'package:admin_shop/blocs/login_form/login_form_bloc.dart';
import 'package:admin_shop/generated/l10n.dart';
import 'package:admin_shop/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> _loginFormKey;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _loginFormKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  Future<void> _submitForm(
    LoginFormState formState,
    LoginFormBloc loginBloc,
    AuthBloc authBloc,
  ) async {
    try {
      if (formState.isSignInMode) {
        authBloc.add(
          SignInRequested(email: formState.email, password: formState.password),
        );
        loginBloc.add(ClearLoginFormFields());
      } else {
        authBloc.add(
          SignUpRequested(
            name: formState.name,
            email: formState.email,
            password: formState.password,
          ),
        );
        loginBloc.add(ClearLoginFormFields());
      }
    } catch (e) {
      rethrow;
    } finally {
      _clearFields();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginFormBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status == AuthStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Erro desconhecido'),
              ),
            );
          }
        },
        child: BlocBuilder<LoginFormBloc, LoginFormState>(
          builder: (context, formState) {
            return Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _loginFormKey,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SvgPicture.asset(
                            'assets/images/logo.svg',
                            width: 120.0,
                            height: 120.0,
                          ),
                          const SizedBox(height: 30),
                          if (!formState.isSignInMode)
                            TextFormField(
                              key: const ValueKey('name_login'),
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                labelText: S.of(context).name,
                                errorText: formState.errorName.isEmpty
                                    ? null
                                    : formState.errorName,
                                prefixIcon: const Icon(Icons.person_rounded),
                              ),
                              onFieldSubmitted: (_) => FocusScope.of(
                                context,
                              ).requestFocus(_emailFocusNode),
                              onChanged: (value) =>
                                  loginBloc.add(LoginFormNameChanged(value)),
                            ),
                          const SizedBox(height: 6),
                          TextFormField(
                            key: const ValueKey('email_login'),
                            controller: _emailController,
                            focusNode: _emailFocusNode,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).email,
                              errorText: formState.errorEmail.isEmpty
                                  ? null
                                  : formState.errorEmail,
                              prefixIcon: const Icon(
                                Icons.alternate_email_rounded,
                              ),
                            ),
                            onFieldSubmitted: (_) => FocusScope.of(
                              context,
                            ).requestFocus(_passwordFocusNode),
                            onChanged: (value) =>
                                loginBloc.add(LoginFormEmailChanged(value)),
                          ),
                          const SizedBox(height: 6),
                          TextFormField(
                            key: const ValueKey('password_login'),
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: formState.isObscure,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).password,
                              errorText: formState.errorPassword.isEmpty
                                  ? null
                                  : formState.errorPassword,
                              prefixIcon: const Icon(Icons.lock_rounded),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    loginBloc.add(TogglePasswordVisibility()),
                                icon: Icon(
                                  formState.isObscure
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                ),
                              ),
                            ),
                            onChanged: (value) =>
                                loginBloc.add(LoginFormPasswordChanged(value)),
                          ),
                          const SizedBox(height: 30),
                          FilledButton(
                            onPressed: formState.isSignInMode
                                ? (!formState.isLoginValid
                                      ? null
                                      : () => _submitForm(
                                          formState,
                                          loginBloc,
                                          authBloc,
                                        ))
                                : (!formState.isSignUpValid
                                      ? null
                                      : () => _submitForm(
                                          formState,
                                          loginBloc,
                                          authBloc,
                                        )),
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              padding: const EdgeInsets.all(15.0),
                            ),
                            child: Text(
                              formState.isSignInMode
                                  ? S.of(context).login
                                  : S.of(context).register,
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextButton(
                            onPressed: () =>
                                loginBloc.add(ToggleLoginFormMode()),
                            style: TextButton.styleFrom(
                              overlayColor: Colors.transparent,
                            ),
                            child: Text(
                              formState.isSignInMode
                                  ? S.of(context).no_account
                                  : S.of(context).have_account,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    if (authState.status == AuthStatus.waiting) {
                      return LoadingScreen();
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
