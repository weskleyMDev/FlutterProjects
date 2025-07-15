import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/calculate.dart';

class ResultLabel extends StatelessWidget {
  const ResultLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 16.0),
        Consumer<CalculateProvider>(
          builder: (context, provider, _) => Text(
            provider.label.isEmpty
                ? 'Enter your height and weight.'
                : provider.label,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
