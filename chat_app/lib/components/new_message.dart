import 'package:flutter/material.dart';

import '../factorys/local_services_factory.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _textController = TextEditingController();
  final localAuth = LocalServicesFactory.instance.createAuthService();
  final localData = LocalServicesFactory.instance.createDataService();

  Future<void> _sendMessage() async {
    final user = localAuth.currentUser;
    if (user != null && _textController.text.trim().isNotEmpty) {
      await localData.saveMessage(_textController.text, user);
      _textController.clear();
      setState(() {});
    }
  }

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
            controller: _textController,
            onChanged: (message) => setState(() {}),
            decoration: InputDecoration(hintText: 'Nova mensagem...'),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _sendMessage(),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 5.0),
          child: IconButton(
            onPressed: _textController.text.trim().isEmpty
                ? null
                : _sendMessage,
            icon: Icon(Icons.send_sharp),
          ),
        ),
      ],
    );
  }
}
