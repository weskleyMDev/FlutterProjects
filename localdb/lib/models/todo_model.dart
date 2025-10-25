import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

final class TodoModel extends Equatable {
  const TodoModel._({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.isCompleted,
    required this.needsSync,
  });

  factory TodoModel.empty() => TodoModel._(
    id: Uuid().v4(),
    title: '',
    description: '',
    createdAt: DateTime.now(),
    isCompleted: false,
    needsSync: true,
  );

  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final bool isCompleted;
  final bool needsSync;

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    bool? isCompleted,
    bool? needsSync,
  }) => TodoModel._(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    createdAt: createdAt ?? this.createdAt,
    isCompleted: isCompleted ?? this.isCompleted,
    needsSync: needsSync ?? this.needsSync,
  );

  Map<String, dynamic> toSqlite() => <String, dynamic>{
    'id': id,
    'title': title,
    'description': description,
    'createdAt': createdAt.toIso8601String(),
    'isCompleted': isCompleted ? 1 : 0,
    'needsSync': needsSync ? 1 : 0,
  };

  Map<String, dynamic> toFirestore() => <String, dynamic>{
    'id': id,
    'title': title,
    'description': description,
    'createdAt': Timestamp.fromDate(createdAt),
    'isCompleted': isCompleted,
    'needsSync': needsSync,
  };

  factory TodoModel.fromSqlite(Map<String, dynamic> map) => TodoModel._(
    id: map['id'] as String,
    title: map['title'] as String,
    description: map['description'] as String,
    createdAt: DateTime.parse(map['createdAt'] as String),
    isCompleted: (map['isCompleted'] as int) == 1,
    needsSync: (map['needsSync'] as int) == 1,
  );

  factory TodoModel.fromFirestore(Map<String, dynamic> map) => TodoModel._(
    id: map['id'] as String,
    title: map['title'] as String,
    description: map['description'] as String,
    createdAt: (map['createdAt'] as Timestamp).toDate(),
    isCompleted: map['isCompleted'] as bool,
    needsSync: map['needsSync'] as bool,
  );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    createdAt,
    isCompleted,
    needsSync,
  ];
}
