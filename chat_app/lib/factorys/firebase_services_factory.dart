import 'package:chat_app/services/auth/auth_service.dart';

import '../services/auth/firebase_auth_service.dart';
import 'services_factory.dart';

class FirebaseServicesFactory implements ServicesFactory {
  @override
  AuthService createAuthService() {
    return FirebaseAuthService();
  }
}
