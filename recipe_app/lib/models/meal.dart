// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

enum Complexity { easy, medium, hard }

enum Cost { cheap, fair, expensive }

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final String imgUrl;
  final List<String> ingredients;
  final List<String> steps;
  final int duration;
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;
  final Complexity complexity;
  final Cost cost;

  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.imgUrl,
    required this.ingredients,
    required this.steps,
    required this.duration,
    required this.isGlutenFree,
    required this.isLactoseFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.complexity,
    required this.cost,
  }); 

  Meal copyWith({
    String? id,
    List<String>? categories,
    String? title,
    String? imgUrl,
    List<String>? ingredients,
    List<String>? steps,
    int? duration,
    bool? isGlutenFree,
    bool? isLactoseFree,
    bool? isVegan,
    bool? isVegetarian,
    Complexity? complexity,
    Cost? cost,
  }) {
    return Meal(
      id: id ?? this.id,
      categories: categories ?? this.categories,
      title: title ?? this.title,
      imgUrl: imgUrl ?? this.imgUrl,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      duration: duration ?? this.duration,
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      complexity: complexity ?? this.complexity,
      cost: cost ?? this.cost,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categories': categories,
      'title': title,
      'imgUrl': imgUrl,
      'ingredients': ingredients,
      'steps': steps,
      'duration': duration,
      'isGlutenFree': isGlutenFree,
      'isLactoseFree': isLactoseFree,
      'isVegan': isVegan,
      'isVegetarian': isVegetarian,
      'complexity': complexity.name,
      'cost': cost.name,
    };
  }

  factory Meal.fromMap(Map<String, dynamic> map) {
    return Meal(
      id: map['id'] as String,
      categories: List<String>.from((map['categories'] as List<String>)),
      title: map['title'] as String,
      imgUrl: map['imgUrl'] as String,
      ingredients: List<String>.from((map['ingredients'] as List<String>)),
      steps: List<String>.from((map['steps'] as List<String>)),
      duration: map['duration'] as int,
      isGlutenFree: map['isGlutenFree'] as bool,
      isLactoseFree: map['isLactoseFree'] as bool,
      isVegan: map['isVegan'] as bool,
      isVegetarian: map['isVegetarian'] as bool,
      complexity: Complexity.values.byName(map['complexity'] as String),
      cost: Cost.values.byName(map['cost'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Meal.fromJson(String source) => Meal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Meal(id: $id, categories: $categories, title: $title, imgUrl: $imgUrl, ingredients: $ingredients, steps: $steps, duration: $duration, isGlutenFree: $isGlutenFree, isLactoseFree: $isLactoseFree, isVegan: $isVegan, isVegetarian: $isVegetarian, complexity: $complexity, cost: $cost)';
  }

  @override
  bool operator ==(covariant Meal other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      listEquals(other.categories, categories) &&
      other.title == title &&
      other.imgUrl == imgUrl &&
      listEquals(other.ingredients, ingredients) &&
      listEquals(other.steps, steps) &&
      other.duration == duration &&
      other.isGlutenFree == isGlutenFree &&
      other.isLactoseFree == isLactoseFree &&
      other.isVegan == isVegan &&
      other.isVegetarian == isVegetarian &&
      other.complexity == complexity &&
      other.cost == cost;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      categories.hashCode ^
      title.hashCode ^
      imgUrl.hashCode ^
      ingredients.hashCode ^
      steps.hashCode ^
      duration.hashCode ^
      isGlutenFree.hashCode ^
      isLactoseFree.hashCode ^
      isVegan.hashCode ^
      isVegetarian.hashCode ^
      complexity.hashCode ^
      cost.hashCode;
  }

  String get complexityText {
    switch (complexity) {
      case Complexity.easy:
        return 'Easy';
      case Complexity.medium:
        return 'Medium';
      case Complexity.hard:
        return 'Hard';
    }
  }

  String get costText {
    switch (cost) {
      case Cost.cheap:
        return 'Cheap';
      case Cost.fair:
        return 'Fair';
      case Cost.expensive:
        return 'Expensive';
    }
  }
}
