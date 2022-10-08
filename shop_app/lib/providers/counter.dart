import 'package:flutter/material.dart';

class CounterState {
  int _value = 0;

  void incremment() => _value++;
  void decremment() => _value--;
  int get value => _value;
  bool diff(CounterState old) {
    return old._value != _value;
  }
}

class CounterProvider extends InheritedWidget {
  CounterProvider({super.key, required super.child});

  final CounterState state = CounterState();

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.diff(state);
  }
}
