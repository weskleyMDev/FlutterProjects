import 'package:calculator_app/components/button.dart';
import 'package:calculator_app/components/button_row.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key, required this.onTap});

  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.0,
      child: Column(
        children: [
          ButtonRow(
            buttons: [
              Button.dark(text: 'AC', onPressed: onTap),
              Button.dark(text: '%', onPressed: onTap),
              Button.dark(text: '+/-', onPressed: onTap),
              Button.operation(text: '/', onPressed: onTap),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '7', onPressed: onTap),
              Button(text: '8', onPressed: onTap),
              Button(text: '9', onPressed: onTap),
              Button.operation(text: 'x', onPressed: onTap),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '4', onPressed: onTap),
              Button(text: '5', onPressed: onTap),
              Button(text: '6', onPressed: onTap),
              Button.operation(text: '-', onPressed: onTap),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '1', onPressed: onTap),
              Button(text: '2', onPressed: onTap),
              Button(text: '3', onPressed: onTap),
              Button.operation(text: '+', onPressed: onTap),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '0', big: true, onPressed: onTap),
              Button(text: '.', onPressed: onTap),
              Button.operation(text: '=', onPressed: onTap),
            ],
          ),
        ],
      ),
    );
  }
}
