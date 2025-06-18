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
  static final Stream<ChatUser?> _userStream = Stream<ChatUser?>.multi((
    controller,
  ) async {
    try {
      final authChanges = _firebaseAuth.authStateChanges();
      await for (final user in authChanges) {
        _currentUser = user == null ? null : await _toChatUser(user);
        controller.add(_currentUser);
      }
    } catch (_) {
      rethrow;
    }
  });
  /* static final Stream<ChatUser?> _userStream = _firebaseAuth
      .authStateChanges()
      .asyncMap((user) async {
        if (user == null) {
          _currentUser = null;
          return null;
        }
        final doc = await _firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          _currentUser = ChatUser.fromMap(doc.data()!, user.uid);
          return _currentUser;
        }
        return null;
      }); */

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  static Future<ChatUser> _toChatUser(User user) async {
    final doc = await _firebaseFirestore
        .collection('users')
        .doc(user.uid)
        .get();
    return ChatUser.fromMap(doc.data()!, user.uid);
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final cred = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = cred.user;
      if (user != null) {
        final doc = await _firebaseFirestore
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          _currentUser = ChatUser.fromMap(doc.data()!, user.uid);
        }
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    _currentUser = null;
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

      final newUser = ChatUser(
        id: user.uid,
        name: name,
        email: email,
        imageUrl: image?.path ?? 'assets/images/user_image_pattern.png',
      );

      await _firebaseFirestore
          .collection('users')
          .doc(user.uid)
          .set(newUser.toMap());

      _currentUser = newUser;
    } catch (_) {
      rethrow;
    }
  }
}
