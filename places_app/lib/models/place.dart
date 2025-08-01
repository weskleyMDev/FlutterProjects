// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'place_location.dart';

class Place {
  final String id;
  final String title;
  final String description;
  final PlaceLocation? location;
  final File? image;

  Place({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.image,
  });

  Place copyWith({
    String? id,
    String? title,
    String? description,
    PlaceLocation? location,
    File? image,
  }) {
    return Place(
      id: id ?? '',
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'location': location?.toMap(),
      'image': image?.path,
    };
  }

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'],// ?? PlaceLocation.fromMap(map['location'] as Map<String, dynamic>),
      image: File(map['image'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory Place.fromJson(String source) =>
      Place.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Place(id: $id, title: $title, location: $location, image: $image)';
  }

  @override
  bool operator ==(covariant Place other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.location == location &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ location.hashCode ^ image.hashCode;
  }
}
