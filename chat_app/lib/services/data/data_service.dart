import '../../models/chat_message.dart';
import '../../models/user.dart';

abstract class DataService {
  Stream<List<ChatMessage>> messagesStream();
  Future<ChatMessage> saveMessage(String text, User user);
}
