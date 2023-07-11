import 'dart:io';

import 'package:logger/logger.dart';

class RosaLogger {
  final Logger _con = Logger();
  final Logger _file = Logger(
      printer: PrettyPrinter(colors: false),
      output: FileOutput(
          file: File("rosa_Data/latest.log"), overrideExisting: true));
  void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _con.v(message, error, stackTrace);
    _file.v(message, error, stackTrace);
  }

  /// Log a message at level [Level.debug].
  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _con.d(message, error, stackTrace);
    _file.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.info].
  void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _con.i(message, error, stackTrace);
    _file.d(message, error, stackTrace);
  }

  /// Log a message at level [Level.warning].
  void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _con.w(message, error, stackTrace);
    _file.w(message, error, stackTrace);
  }

  /// Log a message at level [Level.error].
  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _con.e(message, error, stackTrace);
    _file.e(message, error, stackTrace);
  }

  /// Log a message at level [Level.wtf].
  void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _con.wtf(message, error, stackTrace);
    _file.wtf(message, error, stackTrace);
  }

  /// Log a message with [level].
  void log(Level level, dynamic message,
      [dynamic error, StackTrace? stackTrace]) {
    _con.log(level, message, error, stackTrace);
    _file.log(level, message, error, stackTrace);
  }

  Logger getFileLogger() {
    return _file;
  }

  Logger getConsoleLogger() {
    return _con;
  }
}
