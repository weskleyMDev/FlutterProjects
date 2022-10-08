import 'package:flutter/material.dart';

import '../providers/counter.dart';
import '../utils/capitalize.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> with Capitalize {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(capitalize('testanto inherited widget')),
      ),
      body: Row(
        children: <Widget>[
          IconButton(
            onPressed: () => setState(
              () => provider.state.incremment(),
            ),
            icon: const Icon(Icons.add),
          ),
          Text(
            '${provider.state.value}',
            style: const TextStyle(fontSize: 25),
          ),
          IconButton(
            onPressed: () => setState(
              () => provider.state.decremment(),
            ),
            icon: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
