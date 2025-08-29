import 'dart:convert';

class TodoModel {
  final String id;
  final String text;

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  const TodoModel({required this.id, required this.text});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TodoModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text);

  @override
  int get hashCode => id.hashCode ^ text.hashCode;

  @override
  String toString() {
    return 'TodoModel{id: $id,text: $text}';
  }

  TodoModel copyWith({String? id, String? text}) {
    return TodoModel(id: id ?? this.id, text: text ?? this.text);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'text': text};
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(id: map['id'] as String, text: map['text'] as String);
  }

  String toJSON() => json.encode(toMap());

  factory TodoModel.fromJSON(String source) =>
      TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
