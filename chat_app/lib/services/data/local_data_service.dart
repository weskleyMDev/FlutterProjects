import 'dart:async';
import 'dart:math';

import '../../models/chat_message.dart';
import '../../models/chat_user.dart';
import 'data_service.dart';

class LocalDataService implements DataService {
  static final List<ChatMessage> _messages = [];
  static MultiStreamController<List<ChatMessage>>? _controller;
  static final _msgStream = Stream<List<ChatMessage>>.multi((controller) {
    _controller = controller;
    controller.add(_messages);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    return _msgStream;
  }

  @override
  Future<ChatMessage> saveMessage(String text, ChatUser user) async {
    final message = ChatMessage(
      id: Random().nextDouble().toString(),
      text: text,
      createAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImage: user.imageUrl,
    );
    _messages.add(message);
    _controller?.add(_messages.reversed.toList());
    return message;
  }
}
