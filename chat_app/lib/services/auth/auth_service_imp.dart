import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:chat_app/models/user.dart';

import 'auth_service.dart';

class AuthServiceImp implements AuthService {
  static User? _currentUser;
  static MultiStreamController<User?>? _controller;
  static final Map<String, User> _users = {};
  static final Stream<User?> _userStream = Stream<User?>.multi((controller) {
    _controller = controller;
    _updateUser(null);
  });

  @override
  User? get currentUser => _currentUser;

  @override
  Stream<User?> get userChanges => _userStream;

  static void _updateUser(User? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  @override
  Future<void> signin(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> signout() async {
    _updateUser(null);
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    final newUser = User(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageUrl: image?.path ?? 'assets/images/user_image_pattern.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }
}
