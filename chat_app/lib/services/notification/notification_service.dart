import '../../models/chat_notification.dart';

abstract class NotificationService {
  void addNotification(ChatNotification notification);
  void removeAt(int index);
}
