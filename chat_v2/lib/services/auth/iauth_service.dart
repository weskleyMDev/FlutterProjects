import 'package:chat_v2/models/app_user.dart';

abstract class IAuthService {
  AppUser? get currentUser;
  Stream<AppUser?> get userChanges;
  Future<void> signIn({required String mail, required String password});
  Future<void> signUp({
    required String name,
    required String email,
    required String? imageUrl,
    required String password,
  });
  Future<void> signOut();
}
