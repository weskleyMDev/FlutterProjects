import 'package:mobx/mobx.dart';

import '../../models/app_user.dart';
import '../../services/auth/iauth_service.dart';

part 'auth.store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  AuthStoreBase({required this.authService}) {
    _userChanges = ObservableStream(authService.userChanges);
  }
  final IAuthService authService;

  @observable
  ObservableStream<AppUser?> _userChanges = ObservableStream(
    Stream<AppUser?>.empty(),
  );

  @computed
  Stream<AppUser?> get userChanges => _userChanges;

  @computed
  AppUser? get currentUser => _userChanges.value;

  @action
  Future<void> login({required String email, required String password}) async {
    await authService.login(email: email, password: password);
  }

  @action
  Future<void> signup({required String email, required String password}) async {
    await authService.signup(email: email, password: password);
  }

  @action
  Future<void> logout() async {
    await authService.logout();
  }
}
