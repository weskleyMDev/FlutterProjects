import 'package:shop_v2/models/user/app_user.dart';

abstract class IAuthService {
  AppUser? get currentUser;
  Stream<AppUser?> get userChanges;
  Future<void> signIn({required Map<String, dynamic> data});
  Future<void> signUp({required Map<String, dynamic> data});
  Future<void> signOut();
}
