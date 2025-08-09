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
  // UTILIZAR NO OBSERVER O userChanges.status

  @computed
  AppUser? get currentUser => _currentUser;
}

// Observer(
// builder: (_) {
// final status = authStore.userChanges.status;
// final user = authStore.userChanges.value;
//
// switch (status) {
// case ObservableStreamStatus.waiting:
// return const CircularProgressIndicator();
//
// case ObservableStreamStatus.active:
// if (user == null) {
// return const Text('Usuário não está logado');
// } else {
// return Text('Olá, ${user.name}');
// }
//
// case ObservableStreamStatus.none:
// case ObservableStreamStatus.done:
// default:
// return const Text('Sem dados ou stream finalizada');
// }
// },
// )
