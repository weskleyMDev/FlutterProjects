import 'package:flutter/material.dart';

import '../providers/counter_provider.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context)?.state;
    return Scaffold(
      appBar: AppBar(title: const Text("Counter Page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            provider?.value.toString() ?? "0",
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    provider?.increment();
                  });
                },
                icon: Icon(Icons.add),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    provider?.decrement();
                  });
                },
                icon: Icon(Icons.remove),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
