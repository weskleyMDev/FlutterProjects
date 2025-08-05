import 'package:shop_v2/models/user/app_user.dart';

abstract class ILoginService {
  Stream<AppUser?> get userChanges;
}
