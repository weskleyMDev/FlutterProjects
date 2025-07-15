import 'dart:math';

import 'package:flutter/material.dart';

enum BMIStatus { underweight, normal, overweight, obese }

class CalculateProvider with ChangeNotifier {
  double _result = 0;
  String _label = '';

  double get result => _result;
  String get label => _label;

  void clearStrings() {
    _result = 0;
    _label = '';
    notifyListeners();
  }

  BMIStatus _getBMIStatus(double bmi) {
    if (bmi < 18.5) return BMIStatus.underweight;
    if (bmi < 25) return BMIStatus.normal;
    if (bmi < 30) return BMIStatus.overweight;
    return BMIStatus.obese;
  }

  void calculateBMI({required Map<String, dynamic> data}) {
    final double bmi = data['weight'] / pow(data['height'], 2);
    _result = double.tryParse(bmi.toStringAsFixed(2)) ?? 0.0;
    final status = _getBMIStatus(bmi);
    switch (status) {
      case BMIStatus.underweight:
        _label = 'Your BMI is: $_result. You are underweight!';
        break;
      case BMIStatus.normal:
        _label = 'Your BMI is: $_result. You are normal weight!';
        break;
      case BMIStatus.overweight:
        _label = 'Your BMI is: $_result. You are overweight!';
        break;
      case BMIStatus.obese:
        _label = 'Your BMI is: $_result. You are obese!';
    }
    notifyListeners();
  }
}
