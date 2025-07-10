import 'package:counter_app/contracts/icounter.dart';
import 'package:flutter/material.dart';

class Counter with ChangeNotifier implements ICounter {
  int _count = 0;

  @override
  int get counter => _count;

  @override
  void decrement() {
    _count--;
    notifyListeners();
  }

  @override
  void increment() {
    _count++;
    notifyListeners();
  }
}
