part of 'edit_todo_bloc.dart';

sealed class EditTodoEvent extends Equatable {
  const EditTodoEvent();

  @override
  List<Object?> get props => [];
}

final class TitleInputChanged extends EditTodoEvent {
  const TitleInputChanged(this.title);

  final String title;

  @override
  List<Object?> get props => [title];
}

final class DescriptionInputChanged extends EditTodoEvent {
  const DescriptionInputChanged(this.description);

  final String description;

  @override
  List<Object?> get props => [description];
}

final class TodoSubmitted extends EditTodoEvent {
  const TodoSubmitted();

  @override
  List<Object?> get props => [];
}

final class ResetEditTodoState extends EditTodoEvent {
  const ResetEditTodoState();

  @override
  List<Object?> get props => [];
}
