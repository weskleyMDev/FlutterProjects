import 'package:calculator_app/components/button.dart';
import 'package:calculator_app/components/button_row.dart';
import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500.0,
      child: Column(
        children: [
          ButtonRow(
            buttons: [
              Button.dark(text: 'AC'),
              Button.dark(text: '%'),
              Button.dark(text: '+/-'),
              Button.operation(text: '/'),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '7'),
              Button(text: '8'),
              Button(text: '9'),
              Button.operation(text: 'x'),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '4'),
              Button(text: '5'),
              Button(text: '6'),
              Button.operation(text: '-'),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '1'),
              Button(text: '2'),
              Button(text: '3'),
              Button.operation(text: '+'),
            ],
          ),
          ButtonRow(
            buttons: [
              Button(text: '0', big: true),
              Button(text: '.'),
              Button.operation(text: '='),
            ],
          ),
        ],
      ),
    );
  }
}
