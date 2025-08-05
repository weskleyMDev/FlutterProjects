import 'package:mobx/mobx.dart';
import 'package:shop_v2/services/login/ilogin_service.dart';

part 'login.store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  LoginStoreBase({required this.loginService});
  final ILoginService loginService;
}
