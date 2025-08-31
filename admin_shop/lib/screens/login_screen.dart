import 'package:admin_shop/blocs/login/login_form_bloc.dart';
import 'package:admin_shop/generated/l10n.dart';
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
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _loginFormKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginFormBloc>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<LoginFormBloc, LoginFormState>(
        listener: (context, state) {
          if (state.loginStatus == LoginFormStatus.success) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Successful login!')));
          }
          if (state.loginStatus == LoginFormStatus.failure) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.failureMessage)));
          }
        },
        builder: (context, state) {
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
                        Container(
                          margin: const EdgeInsets.only(top: 30.0, bottom: 6.0),
                          child: TextFormField(
                            key: const ValueKey('email_login'),
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: S.of(context).email,
                              errorText: state.errorEmail.isEmpty
                                  ? null
                                  : state.errorEmail,
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
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6.0, bottom: 30.0),
                          child: TextFormField(
                            key: const ValueKey('password_login'),
                            controller: _passwordController,
                            focusNode: _passwordFocusNode,
                            obscureText: state.isObscure,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: S.of(context).password,
                              errorText: state.errorPassword.isEmpty
                                  ? null
                                  : state.errorPassword,
                              prefixIcon: const Icon(Icons.lock_rounded),
                              suffixIcon: IconButton(
                                onPressed: () =>
                                    loginBloc.add(TogglePasswordVisibility()),
                                icon: Icon(
                                  state.isObscure
                                      ? Icons.visibility_rounded
                                      : Icons.visibility_off_rounded,
                                ),
                              ),
                            ),
                            onChanged: (value) =>
                                loginBloc.add(LoginFormPasswordChanged(value)),
                          ),
                        ),
                        FilledButton(
                          onPressed: !state.isFormValid
                              ? null
                              : () => loginBloc.add(LoginFormSubmitted()),
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            padding: const EdgeInsets.all(15.0),
                          ),
                          child: Text(
                            S.of(context).login,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10.0),
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              overlayColor: Colors.transparent,
                            ),
                            child: Text(S.of(context).no_account),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (state.loginStatus == LoginFormStatus.waiting)
                Container(
                  color: Colors.black87,
                  child: const Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }
}
