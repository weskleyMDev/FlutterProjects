import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const defaultColor = Color(0xFF9E9E9E);
  static const darkColor = Color(0xFF616161);
  static const operationColor = Color(0xFFFF9800);

  const Button({super.key, required this.text, this.big = false})
    : color = defaultColor;

  const Button.dark({super.key, required this.text, this.big = false})
    : color = darkColor;

  const Button.operation({super.key, required this.text, this.big = false})
    : color = operationColor;

  final String text;
  final bool big;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          side: BorderSide(
            color: Colors.white
          ),
          backgroundColor: color,
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 22.0, color: Colors.white),
        ),
      ),
    );
  }
}
