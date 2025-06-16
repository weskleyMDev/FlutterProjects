import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/data/data_service.dart';

import '../services/auth/firebase_auth_service.dart';
import '../services/data/firebase_data_service.dart';
import 'services_factory.dart';

class FirebaseServicesFactory implements ServicesFactory {
  @override
  AuthService createAuthService() {
    return FirebaseAuthService();
  }

  @override
  DataService createDataService() {
    return FirebaseDataService();
  }
}
