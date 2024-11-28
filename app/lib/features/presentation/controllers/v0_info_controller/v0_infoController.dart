import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/core/exception/exception_handler.dart';
import 'package:mi_reclamo/features/data/data_sources/api_seba/v0_infoService.dart';

class V0Info {
  final V0Infoservice _infoService = V0Infoservice();

  Future<void> fetchTypes() async {
    Map<String, dynamic> requestBody = {};
    try {
      List<dynamic> response = await _infoService.getTypes(requestBody);
      logger.i('Types Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  Future<void> fetchStatus() async {
    Map<String, dynamic> requestBody = {};
    try {
      List<dynamic> response = await _infoService.getStatus(requestBody);
      logger.i('Status Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  Future<void> fetchCategories() async {
    try {
      List<dynamic> response = await _infoService.getCategory();
      logger.i('Categories Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  Future<void> fetchAccess() async {
    Map<String, dynamic> requestBody = {};
    try {
      List<dynamic> response = await _infoService.getAccess(requestBody);
      logger.i('Access Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }
}