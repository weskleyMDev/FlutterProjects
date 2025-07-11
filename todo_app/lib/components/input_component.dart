import 'package:flutter/material.dart';

class InputComponent extends StatelessWidget {
  InputComponent({super.key});

  final textController = TextEditingController();
  void _submit() {
    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textController,
            decoration: InputDecoration(label: const Text('Insira uma tarefa')),
            textInputAction: TextInputAction.done,
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton(onPressed: _submit, child: const Icon(Icons.add_sharp)),
      ],
    );
  }
}
