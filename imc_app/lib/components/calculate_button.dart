import 'package:flutter/material.dart';

class CalculateButton extends StatelessWidget {
  const CalculateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _calculate,
          child: Text(
            'CALCULATE',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Provide your data!',
          style: Theme.of(context).textTheme.labelLarge,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _calculate() {}
}
