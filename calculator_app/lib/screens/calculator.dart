import 'package:calculator_app/components/display.dart';
import 'package:calculator_app/components/keyboard.dart';
import 'package:calculator_app/models/memory.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final memory = Memory();
  _onPressed(String text) {
    setState(() => memory.applyCommand(text));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Display(text: memory.text),
        Keyboard(onTap: _onPressed),
      ],
    );
  }
}
