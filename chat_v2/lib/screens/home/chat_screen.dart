import 'package:chat_v2/components/chat/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../stores/form/message/message_form.store.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageStore = GetIt.instance<MessageFormStore>();
  @override
  void initState() {
    _messageStore.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _messageStore.messages,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading messages!'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No messages found!'));
            } else {
              final messages = snapshot.data ?? [];
              return ListView.builder(
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return ChatMessage(message: message);
                },
              );
            }
        }
      },
    );
  }
}
