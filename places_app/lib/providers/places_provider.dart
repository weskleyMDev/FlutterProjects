import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../models/place_location.dart';

class PlacesProvider with ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places => List.unmodifiable(_places);

  int get itemsCount => _places.length;

  Place getItemByIndex(int index) => _places[index];

  void addPlace(Place place) {
    final id = DateTime.now().toIso8601String();
    _places.add(place.copyWith(id: id));
    notifyListeners();
  }

  void updatePlace(Place place) {
    final int index = _places.indexWhere((p) => p.id == place.id);
    if (index >= 0) {
      _places[index] = place;
    }
    notifyListeners();
  }

  void savePlace(Map<String, String> data, File image) {
    final String id = data['id'] ?? '';
    final String title = data['title'] ?? '';
    final PlaceLocation? location = null;
    final File pickedImage = image;

    final newPlace = Place(
      id: id,
      title: title,
      location: location,
      image: pickedImage,
    );

    return id.isNotEmpty ? updatePlace(newPlace) : addPlace(newPlace);
  }
}
