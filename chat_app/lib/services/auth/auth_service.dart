import 'dart:io';

import '../../models/user.dart';

abstract class AuthService {
  User? get currentUser;

  Stream<User?> get userChanges;

  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  );
  Future<void> signin(String email, String password);
  Future<void> signout();
}
