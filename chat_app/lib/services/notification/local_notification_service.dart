import 'package:flutter/material.dart';

import '../../models/chat_notification.dart';
import 'notification_service.dart';

class LocalNotificationService
    with ChangeNotifier
    implements NotificationService {
  final List<ChatNotification> _items = [];

  List<ChatNotification> get items => List.unmodifiable(_items);

  int get count => _items.length;

  @override
  void addNotification(ChatNotification notification) {
    _items.add(notification);
    notifyListeners();
  }

  @override
  void removeAt(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
