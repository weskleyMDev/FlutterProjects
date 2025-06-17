import '../services/authentication/auth_service.dart';
import '../services/data/data_service.dart';
import '../services/notification/notification_service.dart';

abstract class ServicesFactory {
  AuthService createAuthService();
  DataService createDataService();
  NotificationService createNotificationService();
}
