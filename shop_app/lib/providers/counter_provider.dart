import 'package:flutter/material.dart';

class CounterState {
  int _value = 0;

  int get value => _value;
  void increment() => _value++;
  void decrement() => _value--;
  bool differentThan(CounterState old) => old._value != _value;
}

class CounterProvider extends InheritedWidget {
  CounterProvider({super.key, required super.child});

  final CounterState state = CounterState();

  static CounterProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CounterProvider>();

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.differentThan(state);
  }
}
