import 'package:mobx/mobx.dart';
import 'package:shop_v2/services/auth/iauth_service.dart';

part 'auth_form.store.g.dart';

class AuthFormStore = AuthFormStoreBase with _$AuthFormStore;

abstract class AuthFormStoreBase with Store {
  AuthFormStoreBase({required this.authService});
  final IAuthService authService;

  @observable
  ObservableMap<String, dynamic> _authFormData = ObservableMap();

  @computed
  ObservableMap<String, dynamic> get authFormData => _authFormData;

  set authFormData(ObservableMap<String, dynamic> value) {
    _authFormData = value;
  }

  @action
  Future<void> registerUser() async {
    try {
      await authService.signUp(data: _authFormData);
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future<void> loginUser() async {
    try {
      await authService.signIn(data: _authFormData);
    } catch (e) {
      rethrow;
    }
  }

  @action
  void dispose() {
    _authFormData.clear();
  }
}
