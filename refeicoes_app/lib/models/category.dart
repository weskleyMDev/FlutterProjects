// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    required this.color,
  });

  factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int,
      title: map['title'] as String,
      color: Color(map['color'] as int),
    );
  }

  final Color color;
  final int id;
  final String title;

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.color == color;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ color.hashCode;

  @override
  String toString() => 'Category(id: $id, title: $title, color: $color)';

  Category copyWith({
    int? id,
    String? title,
    Color? color,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'color': color.value,
    };
  }

  String toJson() => json.encode(toMap());
}
