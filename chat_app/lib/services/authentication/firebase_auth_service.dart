import 'dart:async';
import 'dart:io';

import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService implements AuthService {
  static final _firebaseAuth = FirebaseAuth.instance;
  static final _firebaseFirestore = FirebaseFirestore.instance;
  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) {
    final authChanges = _firebaseAuth.authStateChanges();
    authChanges.listen(
      (user) async {
        if (user != null) {
          try {
            await _getChatUser(user);
            controller.add(_currentUser);
          } catch (e) {
            controller.addError('Erro ao obter usuário');
          }
        } else {
          controller.add(null);
        }
      },
      onError: (error) {
        controller.addError('Erro na autenticação');
      },
    );
  });
  /* static final Stream<ChatUser?> _userStream = _firebaseAuth
      .authStateChanges()
      .asyncMap((user) async {
        if (user == null) {
          _currentUser = null;
          return null;
        } else {
          return await _getChatUser(user);
        }
      }); */

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  static Future<ChatUser?> _getChatUser(User user) async {
    try {
      final doc = await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .get();
      if (doc.exists) {
        final chatUser = ChatUser.fromMap(doc.data()!, user.uid);
        _currentUser = chatUser;
        return chatUser;
      } else {
        _currentUser = null;
        return null;
      }
    } catch (e) {
      _currentUser = null;
      return null;
    }
  }

  Future<void> _registerChatUser(ChatUser chatUser, String id) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(id)
          .set(chatUser.toMap());
    } catch (e) {
      throw Exception('Erro ao registrar o usuário no Firestore: $e');
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Erro ao fazer login: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> signUp(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    try {
      final cred = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = cred.user;
      if (user == null) {
        throw Exception('Falha ao criar usuário!');
      }
      final imagePath = image?.path ?? 'assets/images/user_image_pattern.png';
      final newUser = ChatUser(
        id: user.uid,
        name: name,
        email: email,
        imageUrl: imagePath,
      );
      await _registerChatUser(newUser, user.uid);
    } catch (e) {
      throw Exception('Erro ao registrar usuário: ${e.toString()}');
    }
  }
}
