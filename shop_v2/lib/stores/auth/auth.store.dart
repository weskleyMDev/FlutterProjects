import 'package:mobx/mobx.dart';
import 'package:shop_v2/models/user/app_user.dart';
import 'package:shop_v2/services/auth/iauth_service.dart';

part 'auth.store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  AuthStoreBase({required this.authService}) {
    _userChanges = ObservableStream(authService.userChanges);
    _userChanges.listen((user) => _currentUser = user);
  }
  final IAuthService authService;

  @observable
  ObservableStream<AppUser?> _userChanges = ObservableStream(Stream.empty());

  @observable
  AppUser? _currentUser;

  @computed
  ObservableStream<AppUser?> get userChanges => _userChanges;

  @computed
  AppUser? get currentUser => _currentUser;

  @action
  Future<void> signOutUser() async => authService.signOut();

  @action
  Future<void> init() async {
    final user = await authService.userChanges.first;
    _currentUser = user;
  }
}
