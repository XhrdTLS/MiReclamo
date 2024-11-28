import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/main.dart';

class ExceptionHandler {

  static void handleException(dynamic error) {
    String errorMessage;

    if (error is NotFoundException) {
      errorMessage = 'NotFoundException: ${error.message}';
    } else if (error is Map<String, dynamic>) {
      errorMessage = 'Error: ${error['title']}\nDetail: ${error['detail']}\nStatus: ${error['status']}';
    } else {
      errorMessage = 'Unhandled exception: $error';
    }

    logger.e(errorMessage);

    // Show SnackBar with error message
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating, // This makes the SnackBar float above other UI elements
      ),
    );
  }
}

class NotFoundException implements Exception {
  final String message;
  NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}