import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/app_user.dart';
import 'iauth_service.dart';

class FirebaseAuthService implements IAuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Stream<AppUser?> get userChanges =>
      _firebaseAuth.authStateChanges().asyncMap((user) async {
        if (user == null) {
          _currentUser = null;
          return null;
        }
        _currentUser = await _getChatUser(user);
        return _currentUser;
      });

  Future<AppUser?> _getChatUser(User user) async {
    try {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final chatUser = AppUser.fromMap(doc.data()!, user.uid);
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

  Future<void> _registerChatUser(AppUser chatUser, String id) async {
    try {
      await _firestore.collection('users').doc(id).set(chatUser.toMap());
    } catch (e) {
      throw Exception('Error registering user: $e');
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> signup({required String email, required String password}) async {
    try {
      final cred = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = cred.user;
      if (user == null) throw Exception('User creation failed');
      final newUser = AppUser(id: user.uid, email: email);
      await _registerChatUser(newUser, user.uid);
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
    _currentUser = null;
  }
}
