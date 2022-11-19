import 'dart:convert';

import 'package:logger/logger.dart';

/// Use logger to debug, it will not show in release mode
final Logger logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 120,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: true // Should each log print contain a timestamp
  ),
);

class Log {
  static void obj(Object obj) {
    logger.i('DEBUG ' + jsonEncode(obj));// mã hóa Object từ một đối tượng Dart thành văn bản json và in ra với DEBUG
  }

  static void info(String string) {
    logger.i('INFO ' + string);
  }
}
