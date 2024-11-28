import 'package:logger/logger.dart';
import 'package:mi_reclamo/core/exception/exception_handler.dart';
import 'package:mi_reclamo/features/data/data_sources/api_seba/InfoService.dart';


class infoController {
  final Logger _logger = Logger();
  final InfoService _infoController = InfoService();

  Future<void> fetchTypes() async {
    try {
      List<dynamic> response = await _infoController.getTypes();
      _logger.i('Types Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  Future<void> fetchStatus() async {
    try {
      List<dynamic> response = await _infoController.getStatus();
      _logger.i('Status Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  Future<void> fetchCategories() async {
    try {
      List<dynamic> response = await _infoController.getCategory();
      _logger.i('Categories Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  Future<void> fetchAccess() async {
    try {
      List<dynamic> response = await _infoController.getAccess();
      _logger.i('Access Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  Future<dynamic> fetchReclamos() async {
    try {
      List<dynamic> response = await _infoController.getCategory();
      _logger.i('Reclamos Response: $response');
      return response;
    } catch (error) {
      ExceptionHandler.handleException(error);
      return [];
    }
  }

}