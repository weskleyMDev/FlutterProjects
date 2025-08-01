import 'package:chat_v2/models/message.dart';

abstract class IDatabaseService {
  Stream<List<Message>> get messages;
  Future<void> sendMessage(Message message);
}
