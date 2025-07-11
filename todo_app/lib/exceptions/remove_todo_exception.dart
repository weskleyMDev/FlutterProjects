class RemoveToDoException implements Exception {
  final String key;
  static const Map<String, String> _errorMessages = {
    'null_todo': 'Não é possível remover uma tarefa nula!',
    'todo_not_found': 'A tarefa com o ID fornecido não foi encontrado!',
    'unknown_error': 'Erro desconhecido ao tentar remover a tarefa.',
  };

  RemoveToDoException(this.key);

  @override
  String toString() =>
      _errorMessages[key] ?? 'Ocorreu um erro ao remover a tarefa da lista!';
}
