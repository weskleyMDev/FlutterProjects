import 'dart:convert';

import 'package:uuid/uuid.dart';

final class ReportModel {
  final String id;
  final String text;
  final String userId;

  const ReportModel._({
    required this.id,
    required this.text,
    required this.userId,
  });

  factory ReportModel.local() {
    return ReportModel._(id: Uuid().v4(), text: '', userId: '');
  }

  ReportModel copyWith({String? text, String? userId}) {
    return ReportModel._(
      id: id,
      text: text ?? this.text,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'text': text, 'userId': userId};
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel._(
      id: map['id'] as String,
      text: map['text'] as String,
      userId: map['userId'] as String,
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
