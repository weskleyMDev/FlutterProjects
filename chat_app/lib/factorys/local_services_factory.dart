import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:chat_app/services/data/data_service.dart';

import '../services/authentication/local_auth_service.dart';
import '../services/data/local_data_service.dart';
import '../services/notification/local_notification_service.dart';
import 'services_factory.dart';

class LocalServicesFactory implements ServicesFactory {
  static LocalServicesFactory? _instance;

  LocalServicesFactory._internal();

  static LocalServicesFactory get instance =>
      _instance ??= LocalServicesFactory._internal();

  @override
  AuthService createAuthService() => LocalAuthService();

  @override
  DataService createDataService() => LocalDataService();

  @override
  LocalNotificationService createNotificationService() =>
      LocalNotificationService();
}
