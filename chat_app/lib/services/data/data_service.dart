import '../../models/chat_message.dart';
import '../../models/chat_user.dart';

abstract class DataService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage> saveMessage(String text, ChatUser user);
}
