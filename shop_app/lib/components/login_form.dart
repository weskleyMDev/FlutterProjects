import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/exceptions/auth_exception.dart';
import 'package:shop_app/providers/auth_login.dart';
import 'package:shop_app/utils/capitalize.dart';

enum LoginMode { login, signup }

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  LoginMode _loginMode = LoginMode.login;
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;
  bool _isLoading = false;
  final _passwordController = TextEditingController();
  final Map<String, String> _loginData = {'email': '', 'password': ''};

  AnimationController? _controller;
  Animation<double>? _opacityAnimation;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));

    _slideAnimation = Tween(
      begin: Offset(0.0, -1.5),
      end: Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller!, curve: Curves.linear));
    //_heightAnimation?.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _switchLoginMode() {
    setState(() {
      if (_isLoginMode) {
        _loginMode = LoginMode.signup;
        _controller?.forward();
      } else {
        _loginMode = LoginMode.login;
        _controller?.reverse();
      }
    });
  }

  //bool get _isSignupMode => _loginMode == LoginMode.signup;
  bool get _isLoginMode => _loginMode == LoginMode.login;

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() => _isLoading = true);

    _formKey.currentState?.save();
    final auth = Provider.of<AuthLogin>(context, listen: false);
    try {
      if (_isLoginMode) {
        await auth.signin(_loginData['email']!, _loginData['password']!);
      } else {
        await auth.signup(_loginData['email']!, _loginData['password']!);
      }
    } on AuthException catch (e) {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          icon: Icon(Icons.warning_amber_sharp, size: 36.0),
          iconColor: Colors.amber,
          title: const Text("Erro ao auntenticar!"),
          content: Text('[ERROR]: $e', textAlign: TextAlign.center),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Card(
      color: Colors.black54,
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          width: screenSize.width * 0.85,
          height: _isLoginMode ? 310.0 : 400.0,
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'E-mail',
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            prefixIcon: Icon(Icons.email_sharp),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            errorMaxLines: 5,
                            alignLabelWithHint: true,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (email) =>
                              _loginData['email'] = email?.trim() ?? '',
                          validator: (value) {
                            final email = value?.trim() ?? '';
                            if (email.isEmpty) {
                              return 'E-mail é obrigatório';
                            }
                            
                            final hasUppercase = RegExp(r'[A-Z]').hasMatch(email);
                            final hasNumber = RegExp(r'\d').hasMatch(email);
                            final hasSpecialChar = RegExp(
                              r'[._+-]',
                            ).hasMatch(email);
                            final isLongEnough = email.length >= 8;
                            
                            final emailPattern = RegExp(
                              //r'^[a-zA-Z0-9._-]+@[a-z]+\.[a-z]{2,}(?:\.[a-z]{2,})?$'
                              r'^[a-zA-Z0-9._+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})?$',
                            ).hasMatch(email);
                            if (!emailPattern ||
                                !hasUppercase ||
                                !hasNumber ||
                                !hasSpecialChar ||
                                !isLongEnough) {
                              return '''
                              E-mail inválido. Deve conter:
                              - Ao menos uma letra maiúscula;
                              - Ao menos um número;
                              - Ao menos um dos caracteres: ._+-;
                              - No mínimo 8 caracteres;
                              - Está no formato nome@dominio.com
                              '''
                                  .trimIndent();
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            prefixIcon: Icon(Icons.password_sharp),
                            suffixIcon: IconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ),
                          controller: _passwordController,
                          obscureText: _isPasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          onSaved: (password) =>
                              _loginData['password'] = password?.trim() ?? '',
                          validator: (value) {
                            final password = value?.trim() ?? '';
                            if (password.isEmpty) {
                              return 'Senha é obrigatória';
                            }
                            if (password.length < 6) {
                              return 'Senha deve ter pelo menos 6 caracteres';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10.0),
                        AnimatedContainer(
                          constraints: BoxConstraints(
                            minHeight: _isLoginMode ? 0.0 : 60.0,
                            maxHeight: _isLoginMode ? 0.0 : 120.0,
                          ),
                          duration: Duration(milliseconds: 300),
                          curve: Curves.linear,
                          child: FadeTransition(
                            opacity: _opacityAnimation!,
                            child: SlideTransition(
                              position: _slideAnimation!,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Confirmar Senha',
                                  labelStyle: TextStyle(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                  prefixIcon: Icon(Icons.password_sharp),
                                  suffixIcon: IconButton(
                                    onPressed: _toggleConfirmPasswordVisibility,
                                    icon: Icon(
                                      _isConfirmPasswordVisible
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                  ),
                                ),
                                obscureText: _isConfirmPasswordVisible,
                                keyboardType: TextInputType.visiblePassword,
                                validator: _isLoginMode
                                    ? null
                                    : (value) {
                                        final confirmPassword =
                                            value?.trim() ?? '';
                                        if (confirmPassword.isEmpty) {
                                          return 'Confirmação de senha é obrigatória';
                                        }
                                        if (confirmPassword !=
                                            _passwordController.text) {
                                          return 'As senhas não coincidem';
                                        }
                                        return null;
                                      },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton.icon(
                          onPressed: _submitForm,
                          label: Text(
                            _isLoginMode
                                ? 'Entrar'.toUpperCase()
                                : 'Inscrever'.toUpperCase(),
                          ),
                          icon: Icon(
                            _isLoginMode
                                ? Icons.login_sharp
                                : Icons.person_add_sharp,
                          ),
                        ),
                        const SizedBox(height: 30.0,),
                        TextButton(
                          onPressed: _switchLoginMode,
                          child: Text(
                            _isLoginMode
                                ? 'Não tem uma conta? Inscreva-se'
                                : 'Já tem uma conta? Entrar',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
        ),
      ),
    );
  }
}
