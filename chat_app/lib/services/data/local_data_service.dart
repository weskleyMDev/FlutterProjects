import 'dart:async';
import 'dart:math';

import '../../models/chat_message.dart';
import '../../models/user.dart';
import 'data_service.dart';

class LocalDataService implements DataService {
  static final defaultMessage1 = ChatMessage(
    id: '1',
    text:
        'Ola! sadsadsad adasdasdas sadasdasdsa asdasdasdas sasdasdasdsa dasdasdsadasdsa dasdsadsadsad asdsadasdas',
    createAt: DateTime.now(),
    userId: 'a',
    userName: 'Juca',
    userImage: 'assets/images/user_image_pattern.png',
  );
  static final defaultMessage2 = ChatMessage(
    id: '2',
    text: 'Mundo!',
    createAt: DateTime.now(),
    userId: 'b',
    userName: 'Cleide',
    userImage: 'assets/images/user_image_pattern.png',
  );
  static final List<ChatMessage> _messages = [defaultMessage1, defaultMessage2];
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
  Future<ChatMessage> saveMessage(String text, User user) async {
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
