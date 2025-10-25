import 'package:equatable/equatable.dart';
import 'package:localdb/models/todo_model.dart';

final class SyncResultModel extends Equatable {
  const SyncResultModel({
    required this.successCount,
    required this.failureCount,
    required this.failedTodos,
  });

  factory SyncResultModel.empty() =>
      const SyncResultModel(successCount: 0, failureCount: 0, failedTodos: []);

  final int successCount;
  final int failureCount;
  final List<TodoModel> failedTodos;

  @override
  List<Object?> get props => [successCount, failureCount, failedTodos];
}
