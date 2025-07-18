import 'dart:async';

import 'package:uuid/uuid.dart';

import '../../models/app_user.dart';
import 'iauth_service.dart';

class LocalAuthService implements IAuthService {
  static final AppUser _adminUser = AppUser(
    id: 'a',
    email: 'admin@mail.com',
    role: 'user',
  );
  static final Map<String, AppUser> _users = {
    _adminUser.email: _adminUser,
  };
  static AppUser? _currentUser;
  static MultiStreamController<AppUser?>? _controller;
  static final _userStream = Stream<AppUser?>.multi((controller) {
    _controller = controller;
    _updateCurrentUser(_adminUser);
  });

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Stream<AppUser?> get userChanges => _userStream;

  static void _updateCurrentUser(AppUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }

  @override
  Future<void> login({required String email, required String password}) async {
    _updateCurrentUser(_users[email]);
  }

  @override
  Future<void> signup({required String email, required String password}) async {
    final newUser = AppUser(id: Uuid().v4(), email: email);
    _users.putIfAbsent(email, () => newUser);
  }

  @override
  Future<void> logout() async => _updateCurrentUser(null);
}
