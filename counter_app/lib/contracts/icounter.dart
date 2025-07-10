import 'package:flutter/material.dart';

abstract class ICounter with ChangeNotifier {
  int get counter;
  void increment();
  void decrement();
}
