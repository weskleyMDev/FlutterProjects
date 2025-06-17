import 'package:flutter/material.dart';

class NewMessage extends StatelessWidget {
  const NewMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5.0),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.emoji_emotions_outlined),
          ),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(hintText: 'Nova mensagem...'),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5.0),
          child: IconButton(onPressed: () {}, icon: Icon(Icons.send_sharp)),
        ),
      ],
    );
  }
}
