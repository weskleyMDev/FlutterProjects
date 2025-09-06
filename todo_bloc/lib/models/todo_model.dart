import 'dart:convert';

import 'package:uuid/uuid.dart';

class TodoModel {
  final String id;
  final String text;
  final DateTime createdAt;

  TodoModel._({required this.id, required this.text, required this.createdAt});

  factory TodoModel.initial() =>
      TodoModel._(id: Uuid().v4(), text: '', createdAt: DateTime.now());

  factory TodoModel.empty() =>
      TodoModel._(id: '', text: '', createdAt: DateTime.now());

  TodoModel copyWith({
    String Function()? id,
    String Function()? text,
    DateTime Function()? createdAt,
  }) {
    return TodoModel._(
      id: id?.call() ?? this.id,
      text: text?.call() ?? this.text,
      createdAt: createdAt?.call() ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel._(
      id: map['id'] as String,
      text: map['text'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TodoModel(id: $id, text: $text, createdAt: $createdAt)';

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.text == text && other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ createdAt.hashCode;
}
