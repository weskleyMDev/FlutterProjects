import 'dart:convert';

import 'package:uuid/uuid.dart';

final class ReportModel {
  final String id;
  final String text;
  final String userId;
  final DateTime createdAt;

  const ReportModel._({
    required this.id,
    required this.text,
    required this.userId,
    required this.createdAt,
  });

  factory ReportModel.local() {
    return ReportModel._(
      id: Uuid().v4(),
      text: '',
      userId: '',
      createdAt: DateTime.now(),
    );
  }

  ReportModel copyWith({String Function()? text, String Function()? userId}) {
    return ReportModel._(
      id: id,
      text: text != null ? text() : this.text,
      userId: userId != null ? userId() : this.userId,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'userId': userId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel._(
      id: map['id'] as String,
      text: map['text'] as String,
      userId: map['userId'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) =>
      ReportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReportModel(id: $id, text: $text, userId: $userId)';

  @override
  bool operator ==(covariant ReportModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.text == text && other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ userId.hashCode;
}
