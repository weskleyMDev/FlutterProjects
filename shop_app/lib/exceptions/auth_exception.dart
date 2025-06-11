class AuthException implements Exception {
  final String key;
  static const Map<String, String> erros = {
    'EMAIL_EXISTS': 'O e-mail já está cadastrado!',
    'OPERATION_NOT_ALLOWED': 'Operação não permitida!',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Acesso bloqueado temporariamente. Tente novamente mais tarde!',
    'INVALID_EMAIL': 'E-mail não encontrado!',
    'INVALID_LOGIN_CREDENTIALS': 'Usuário ou Senha inválidos!',
    'USER_DISABLED': 'A conta do usuário foi desativada!',
  };

  AuthException(this.key);

  @override
  String toString() =>
      erros[key] ??
      'Ocorreu um erro no processo de autenticação!';
}
