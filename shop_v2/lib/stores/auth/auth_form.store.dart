import 'package:mobx/mobx.dart';
import 'package:shop_v2/services/auth/iauth_service.dart';

part 'auth_form.store.g.dart';

class AuthFormStore = AuthFormStoreBase with _$AuthFormStore;

abstract class AuthFormStoreBase with Store {
  AuthFormStoreBase({required this.authService});
  final IAuthService authService;

  @observable
  ObservableMap<String, dynamic> _authFormdata = ObservableMap();

  @computed
  ObservableMap<String, dynamic> get authFormdata => _authFormdata;

  set authFormdata(ObservableMap<String, dynamic> value) {
    _authFormdata = value;
  }

  @action
  Future<void> registerUser() async {
    try {
      await authService.signUp(data: _authFormdata);
    } catch (e) {
      rethrow;
    }
  }

  @action
  void dispose() {
    _authFormdata.clear();
  }
}
