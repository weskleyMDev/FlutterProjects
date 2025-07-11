import 'package:flutter/material.dart';

class FootnoteComponent extends StatelessWidget {
  const FootnoteComponent({super.key});

  @override
  Widget build(BuildContext context) {
    String contador = '100';
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              text: 'Você possui '.toUpperCase(),
              children: [
                TextSpan(
                  text: contador,
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                TextSpan(text: ' tarefas.'.toUpperCase()),
              ],
            ),
          ),
        ),
        OutlinedButton(onPressed: () {}, child: Text('REMOVER TUDO')),
      ],
    );
  }
}
