import 'package:flutter/material.dart';

import '../models/place.dart';

class PlacesProvider with ChangeNotifier {
  final List<Place> _places = [];

  List<Place> get places => List.unmodifiable(_places);

  int get itemsCount => _places.length;

  Place getItemByIndex(int index) => _places[index];
}
