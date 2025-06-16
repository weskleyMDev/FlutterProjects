import 'package:chat_app/services/auth/auth_service.dart';

import '../services/auth/local_auth_service.dart';
import 'services_factory.dart';

class LocalServicesFactory implements ServicesFactory {
  @override
  AuthService createAuthService() {
    return LocalAuthService();
  }  
}