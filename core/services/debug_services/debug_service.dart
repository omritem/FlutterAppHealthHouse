import 'package:logger/logger.dart';

class DebugServices {
  static final DebugServices _instance = DebugServices._internal();

  factory DebugServices() => _instance;

  DebugServices._internal();

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
    ),
  );

  void logInfo(String message) {
    _logger.i(message);
  }

  void logDebug(String message) {
    _logger.d(message);
  }

  void logWarning(String message) {
    _logger.w(message);
  }

  void logError(String message) {
    _logger.e(message);
  }

  void logVerbose(String message) {
    _logger.t(message);
  }
}