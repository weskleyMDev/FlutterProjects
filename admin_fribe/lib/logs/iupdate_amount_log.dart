part of 'update_amount_log.dart';

abstract interface class IUpdateAmountLog {
  Future<void> writeLog({required String logEntry});
}
