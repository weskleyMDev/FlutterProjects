import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat_app/models/chat_user.dart';

import 'auth_service.dart';

class LocalAuthService implements AuthService {
  static final _defaultUser = ChatUser(
    id: 'a',
    name: 'Juca',
    email: 'juca@fribe.com',
    imageUrl: 'assets/images/user_image_pattern.png',
  );
  static ChatUser? _currentUser;
  static MultiStreamController<ChatUser?>? _controller;
  static final Map<String, ChatUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static final Stream<ChatUser?> _userStream = Stream<ChatUser?>.multi((
    controller,
  ) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  static void _updateUser(ChatUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  @override
  Future<void> signIn(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> signOut() async {
    _updateUser(null);
  }

  @override
  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = ChatUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/user_image_pattern.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }
}
