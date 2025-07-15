import 'package:flutter/material.dart';

class CalculateProvider with ChangeNotifier {
  String _result = '';
  String get result => _result;
  void calculateBMI({required Map<String, dynamic> data}) {
    final result = data['weight'] / data['height'];
    _result = result.toStringAsFixed(2);
    notifyListeners();
  }
}
