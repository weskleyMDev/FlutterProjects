// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Settings {
  bool isGlutenFree;
  bool isLactoseFree;
  bool isVegan;
  bool isVegetarian;

  Settings({
    this.isGlutenFree = false,
    this.isLactoseFree = false,
    this.isVegan = false,
    this.isVegetarian = false,
  });

  Settings copyWith({
    bool? isGlutenFree,
    bool? isLactoseFree,
    bool? isVegan,
    bool? isVegetarian,
  }) {
    return Settings(
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isGlutenFree': isGlutenFree,
      'isLactoseFree': isLactoseFree,
      'isVegan': isVegan,
      'isVegetarian': isVegetarian,
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      isGlutenFree: map['isGlutenFree'] as bool,
      isLactoseFree: map['isLactoseFree'] as bool,
      isVegan: map['isVegan'] as bool,
      isVegetarian: map['isVegetarian'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Settings.fromJson(String source) =>
      Settings.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Settings(isGlutenFree: $isGlutenFree, isLactoseFree: $isLactoseFree, isVegan: $isVegan, isVegetarian: $isVegetarian)';
  }

  @override
  bool operator ==(covariant Settings other) {
    if (identical(this, other)) return true;

    return other.isGlutenFree == isGlutenFree &&
        other.isLactoseFree == isLactoseFree &&
        other.isVegan == isVegan &&
        other.isVegetarian == isVegetarian;
  }

  @override
  int get hashCode {
    return isGlutenFree.hashCode ^
        isLactoseFree.hashCode ^
        isVegan.hashCode ^
        isVegetarian.hashCode;
  }
}
