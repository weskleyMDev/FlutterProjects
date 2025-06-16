import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/data/data_service.dart';

import '../services/auth/local_auth_service.dart';
import '../services/data/local_data_service.dart';
import 'services_factory.dart';

class LocalServicesFactory implements ServicesFactory {
  static LocalServicesFactory? _instance;

  LocalServicesFactory._internal();

  static LocalServicesFactory get instance =>
      _instance ??= LocalServicesFactory._internal();

  @override
  AuthService createAuthService() {
    return LocalAuthService();
  }

  @override
  DataService createDataService() {
    return LocalDataService();
  }
}
