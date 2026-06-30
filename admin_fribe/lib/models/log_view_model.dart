import 'package:admin_fribe/logs/enum/log_action.dart';

class LogViewModel {
  final String productId;
  final String productName;

  final LogAction action;
  final String oldAmount;
  final String newAmount;
  final String addedAmount;
  final DateTime timestamp;

  const LogViewModel({
    required this.productId,
    required this.productName,
    required this.action,
    required this.oldAmount,
    required this.newAmount,
    required this.addedAmount,
    required this.timestamp,
  });
}