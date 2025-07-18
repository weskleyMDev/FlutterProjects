import '../../models/app_user.dart';

abstract class IAuthService {
  AppUser? get currentUser;
  Stream<AppUser?> get userChanges;
  Future<void> login({required String email, required String password});
  Future<void> signup({required String email, required String password});
  Future<void> logout();
}
