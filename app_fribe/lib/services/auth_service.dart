import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> signup({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          );

      String userId = userCredential.user!.uid;

      await _firestore.collection('users').doc(userId).set({
        'email': email.trim(),
        'role': role,
      });

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      if (email.trim().isEmpty || password.trim().isEmpty) {
        return 'Preencha todos os campos.';
      }

      await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = await _firebaseAuth.authStateChanges().firstWhere(
        (u) => u != null,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user?.uid)
          .get();

      final data = userDoc.data();
      if (!userDoc.exists ||
          data == null ||
          !(data as Map<String, dynamic>).containsKey('role')) {
        return 'Usuário não encontrado ou sem função definida.';
      }

      final String? role = userDoc['role'];
      if (role == null || role.isEmpty) {
        return 'Função do usuário não definida.';
      }

      return role;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
        case 'wrong-password':
          return 'E-mail ou senha inválidos!';
        case 'invalid-email':
          return 'E-mail inválido!';
        case 'network-request-failed':
          return 'Sem conexão com a internet.';
        default:
          return 'Erro ao fazer login. Tente novamente.';
      }
    } catch (e) {
      return 'Erro inesperado. Tente novamente.';
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> getUserRole() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      return userDoc['role'];
    }
    return null;
  }

  Future<String?> updatePasswordByEmail({
    required String email,
    required String newPassword,
  }) async {
    try {
      User? user = _firebaseAuth.currentUser;

      if (user == null || user.email != email.trim()) {
        return "Usuário não autenticado ou email não encontrado.";
      }

      await user.updatePassword(newPassword.trim());

      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
