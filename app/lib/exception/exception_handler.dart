import 'package:logger/logger.dart';

class ExceptionHandler {
  static final Logger _logger = Logger();

  static void handleException(dynamic error) {
    if (error is NotFoundException) {
      _logger.e('NotFoundException: ${error.message}');
    } else {
      _logger.e('Unhandled exception: $error');
    }
  }

}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}