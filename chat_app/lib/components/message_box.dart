import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:intl/intl.dart';

import '../models/chat_message.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({
    super.key,
    required this.message,
    required this.isCurrentUser,
  });

  final ChatMessage message;
  final bool isCurrentUser;

  Widget _showUserImage(String url) {
    ImageProvider? provider;
    final uri = Uri.parse(url);
    
    if (uri.path.contains('assets')) {
      provider = AssetImage(uri.toString());
    } else if (uri.scheme == 'http') {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(backgroundImage: provider);
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat('HH:mm').format(message.createAt);
    return Row(
      mainAxisAlignment: isCurrentUser
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isCurrentUser) _showUserImage(message.userImage),
        ChatBubble(
          clipper: ChatBubbleClipper1(
            type: isCurrentUser
                ? BubbleType.sendBubble
                : BubbleType.receiverBubble,
          ),
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          backGroundColor: isCurrentUser
              ? Theme.of(context).colorScheme.tertiaryContainer
              : Theme.of(context).colorScheme.surfaceContainerHigh,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: Text(message.text)),
                Text(
                  time,
                  style: TextStyle().copyWith(
                    color: Colors.white.withAlpha(120),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isCurrentUser) _showUserImage(message.userImage),
      ],
    );
  }
}
