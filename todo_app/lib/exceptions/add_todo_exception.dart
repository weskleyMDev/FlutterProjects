class AddToDoException implements Exception {
  final String key;
  static const Map<String, String> _errorMessages = {
    'null_todo': 'Não é possível adicionar uma tarefa nula!',
    'unknown_error': 'Erro desconhecido ao tentar remover a tarefa.',
  };

  AddToDoException(this.key);

  @override
  String toString() =>
      _errorMessages[key] ?? 'Ocorreu um erro ao adicionar a tarefa na lista!';
}