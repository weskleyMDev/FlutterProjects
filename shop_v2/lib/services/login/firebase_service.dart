import 'package:shop_v2/models/user/app_user.dart';
import 'package:shop_v2/services/login/ilogin_service.dart';

class FirebaseService implements ILoginService {
  @override
  Stream<AppUser?> get userChanges => throw UnimplementedError();
}
