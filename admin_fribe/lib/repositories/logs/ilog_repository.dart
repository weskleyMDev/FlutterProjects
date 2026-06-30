part of 'log_repository.dart';

abstract interface class ILogRepository {
  Future<void> saveLog(LogModel log);
  Future<List<LogViewModel>> getLogsByProductID({
    required String productId,
    LogAction? action,
  });
  Future<List<LogViewModel>> getLast20Logs(LogAction? action);
}
