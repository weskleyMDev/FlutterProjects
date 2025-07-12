import 'package:flutter/material.dart';

import '../components/footnote_component.dart';
import '../components/input_component.dart';
import '../components/list_component.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(
        builder: (context, constraints) => SafeArea(
          child: Center(
            child: Card(
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Lista de Tarefas',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16.0),
                    const InputComponent(),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: const ListComponent(),
                      ),
                    ),
                    const FootnoteComponent(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
