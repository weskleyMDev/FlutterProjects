import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  static late final Logger _logger;

  static void init({bool isProduction = kReleaseMode}) {
    _logger = Logger(
      level: isProduction ? Level.error : Level.debug,
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 5,
        lineLength: 120,
        colors: true,
        printEmojis: true,
        dateTimeFormat: DateTimeFormat.dateAndTime,
      ),
    );
  }

  static void debug(dynamic message) => _logger.d(message);
  static void info(dynamic message) => _logger.i(message);
  static void warning(dynamic message) => _logger.w(message);
  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
}
