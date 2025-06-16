import '../services/auth/auth_service.dart';

abstract class ServicesFactory {
  AuthService createAuthService();
}
