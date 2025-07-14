import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ToDo {
  final String id;
  final String title;
  final DateTime date;

  ToDo({
    required this.id,
    required this.title,
    required this.date,
  });

  ToDo copyWith({
    String? id,
    String? title,
    DateTime? date,
  }) {
    return ToDo(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      id: map['id'] as String,
      title: map['title'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDo.fromJson(String source) => ToDo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ToDo(id: $id, title: $title, date: $date)';

  @override
  bool operator ==(covariant ToDo other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.date == date;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ date.hashCode;
}
