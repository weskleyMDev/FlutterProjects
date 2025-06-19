import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../models/chat_notification.dart';
import 'notification_service.dart';

class LocalNotificationService
    with ChangeNotifier
    implements NotificationService {
  final _messaging = FirebaseMessaging.instance;
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

  Future<void> init() async {
    await _configureTerminated();
    await _configureForeground();
    await _configureBackground();
  }

  Future<bool> get _isAuthorized async {
    final settings = await _messaging.requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  Future<void> _configureForeground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessage.listen(_messageHandler);
    }
  }

  Future<void> _configureBackground() async {
    if (await _isAuthorized) {
      FirebaseMessaging.onMessageOpenedApp.listen(_messageHandler);
    }
  }

  Future<void> _configureTerminated() async {
    if (await _isAuthorized) {
      RemoteMessage? initalMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (initalMessage == null) return;
      _messageHandler(initalMessage);
    }
  }

  void _messageHandler(RemoteMessage? message) {
    if (message == null || message.notification == null) return;
    addNotification(
      ChatNotification(
        title: message.notification!.title ?? 'Não informado!',
        body: message.notification!.body ?? 'Não informado!',
      ),
    );
  }
}
