import 'package:chat_app/models/chat_message.dart';

import 'package:chat_app/models/user.dart';

import 'data_service.dart';

class FirebaseDataService implements DataService {
  @override
  Stream<List<ChatMessage>> messagesStream() {
    // TODO: implement messagesStream
    throw UnimplementedError();
  }

  @override
  Future<ChatMessage> saveMessage(String text, User user) {
    // TODO: implement saveMessage
    throw UnimplementedError();
  }
}