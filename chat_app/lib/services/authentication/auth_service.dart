import 'dart:io';

import '../../models/chat_user.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<void> signUp(String name, String email, String password, File? image);
  Future<void> signIn(String email, String password);
  Future<void> signOut();
}
