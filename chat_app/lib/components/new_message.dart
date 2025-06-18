import 'package:flutter/material.dart';

import '../factorys/firebase_services_factory.dart';
import '../factorys/local_services_factory.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _textController = TextEditingController();
  final auth = FirebaseServicesFactory.instance.createAuthService();
  final localData = LocalServicesFactory.instance.createDataService();

  Future<void> _sendMessage() async {
    final user = auth.currentUser;
    if (user != null && _textController.text.trim().isNotEmpty) {
      await localData.saveMessage(_textController.text, user);
      _textController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(
          width: 50.0,
          height: 50.0,
          child: Stack(
            children: [
              Positioned(
                top: 8.0,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.emoji_emotions_outlined),
                ),
              ),
            ],
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
          width: 50.0,
          height: 50.0,
          child: Stack(
            children: [
              Positioned(
                top: 8.0,
                child: IconButton(
                  onPressed: _textController.text.trim().isEmpty
                      ? null
                      : _sendMessage,
                  icon: Icon(Icons.send_sharp),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
