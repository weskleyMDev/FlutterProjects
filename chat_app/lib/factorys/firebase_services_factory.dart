import 'package:chat_app/services/authentication/auth_service.dart';
import 'package:chat_app/services/data/data_service.dart';

import '../services/authentication/firebase_auth_service.dart';
import '../services/data/firebase_data_service.dart';
import '../services/notification/firebase_notification_service.dart';
import 'services_factory.dart';

class FirebaseServicesFactory implements ServicesFactory {
  static FirebaseServicesFactory? _instance;

  FirebaseServicesFactory._internal();

  static FirebaseServicesFactory get instance =>
      _instance ??= FirebaseServicesFactory._internal();

  @override
  AuthService createAuthService() => FirebaseAuthService();

  @override
  DataService createDataService() => FirebaseDataService();

  @override
  FirebaseNotificationService createNotificationService() =>
      FirebaseNotificationService();
}
