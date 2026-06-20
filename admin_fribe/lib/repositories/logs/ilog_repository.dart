part of 'log_repository.dart';

abstract interface class ILogRepository {
  Future<void> saveLog(LogModel log);
  Future<List<LogModel>> getLogs({
    required String productId,
    LogAction? action,
  });
}
