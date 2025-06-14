import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';
import '../models/place_location.dart';
import '../utils/db_services.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => List.unmodifiable(_places);

  int get itemsCount => _places.length;

  Place getItemByIndex(int index) => _places[index];

  Future<void> loadPlaces() async {
    final dataList = await DBServices.getData('places');
    _places = dataList.map((item) => Place.fromMap(item).copyWith(
      id: item['id'],
      title: item['title'],
      location: null,
      image: File(item['image'])
    )).toList();
    notifyListeners();
  }

  void addPlace(Place place) {
    final id = DateTime.now().toIso8601String();
    final newPlace = place.copyWith(id: id);
    _places.add(newPlace);
    DBServices.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image?.path,
    });
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
