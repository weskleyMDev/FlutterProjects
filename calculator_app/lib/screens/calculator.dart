import 'package:calculator_app/components/display.dart';
import 'package:calculator_app/components/keyboard.dart';
import 'package:flutter/material.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Display(text: '0'),
        Keyboard(),
      ],
    );
  }
}
