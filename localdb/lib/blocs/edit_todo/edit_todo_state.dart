part of 'edit_todo_bloc.dart';

final class EditTodoState extends Equatable {
  const EditTodoState._({
    required this.initialTodo,
    required this.titleInput,
    required this.descriptionInput,
    required this.status,
    required this.errorMessage,
  });

  factory EditTodoState.initial() => const EditTodoState._(
    initialTodo: null,
    titleInput: TitleInput.pure(),
    descriptionInput: DescriptionInput.pure(),
    status: FormzSubmissionStatus.initial,
    errorMessage: null,
  );

  factory EditTodoState.fromTodoModel(TodoModel todo) => EditTodoState._(
    initialTodo: todo,
    titleInput: TitleInput.dirty(todo.title),
    descriptionInput: DescriptionInput.dirty(todo.description),
    status: FormzSubmissionStatus.initial,
    errorMessage: null,
  );

  final TodoModel? initialTodo;
  final TitleInput titleInput;
  final DescriptionInput descriptionInput;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  bool get isNewTodo => initialTodo == null;

  bool get isFormValid => Formz.validate([titleInput, descriptionInput]);

  String? get titleInputError => _getErrorTitle<TitleInputError>(titleInput, {
    TitleInputError.empty: 'Title cannot be empty',
    TitleInputError.invalid: 'Title is invalid',
    TitleInputError.tooShort: 'Title is too short (min 3 characters)',
    TitleInputError.tooLong: 'Title is too long (max 50 characters)',
  });

  String? get descriptionInputError =>
      _getErrorTitle<DescriptionInputError>(descriptionInput, {
        DescriptionInputError.empty: 'Description cannot be empty',
        DescriptionInputError.invalid: 'Description is invalid',
        DescriptionInputError.tooShort:
            'Description is too short (min 10 characters)',
        DescriptionInputError.tooLong:
            'Description is too long (max 200 characters)',
      });

  String? _getErrorTitle<T extends Enum>(
    FormzInput input,
    Map<T, String> errorMessages,
  ) {
    if (input.isPure || input.error == null) return null;
    return errorMessages[input.error as T];
  }

  EditTodoState copyWith({
    TodoModel? initialTodo,
    TitleInput? titleInput,
    DescriptionInput? descriptionInput,
    FormzSubmissionStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return EditTodoState._(
      initialTodo: initialTodo ?? this.initialTodo,
      titleInput: titleInput ?? this.titleInput,
      descriptionInput: descriptionInput ?? this.descriptionInput,
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [
    initialTodo,
    titleInput,
    descriptionInput,
    status,
    errorMessage,
  ];
}
