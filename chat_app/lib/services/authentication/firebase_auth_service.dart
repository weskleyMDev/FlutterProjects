import 'dart:io';

import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/authentication/auth_service.dart';

class FirebaseAuthService implements AuthService {
  @override
  // TODO: implement currentUser
  User? get currentUser => throw UnimplementedError();

  @override
  Future<void> signin(String email, String password) {
    // TODO: implement signin
    throw UnimplementedError();
  }

  @override
  Future<void> signout() {
    // TODO: implement signout
    throw UnimplementedError();
  }

  @override
  Future<void> signup(String name, String email, String password, File? image) {
    // TODO: implement signup
    throw UnimplementedError();
  }

  @override
  // TODO: implement userChanges
  Stream<User?> get userChanges => throw UnimplementedError();
}
