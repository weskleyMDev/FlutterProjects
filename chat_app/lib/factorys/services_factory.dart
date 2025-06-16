import '../services/auth/auth_service.dart';
import '../services/data/data_service.dart';

abstract class ServicesFactory {
  AuthService createAuthService();
  DataService createDataService();
}
