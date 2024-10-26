import 'package:logger/logger.dart';
import 'package:cm/features/data/data_sources/api_seba/v0_infoService.dart';

class V0Info {
  final Logger _logger = Logger();
  final V0Infoservice _infoService = V0Infoservice();

  Future<void> fetchTypes() async {
    Map<String, dynamic> requestBody = {};
    try {
      List<dynamic> response = await _infoService.getTypes(requestBody);
      _logger.i('Types Response: $response');
    } catch (error) {
      _logger.e('Error fetching types: $error');
    }
  }

  Future<void> fetchStatus() async {
    Map<String, dynamic> requestBody = {};
    try {
      List<dynamic> response = await _infoService.getStatus(requestBody);
      _logger.i('Status Response: $response');
    } catch (error) {
      _logger.e('Error fetching status: $error');
    }
  }

  Future<void> fetchCategories() async {
    Map<String, dynamic> requestBody = {};
    try {
      List<dynamic> response = await _infoService.getCategory(requestBody);
      _logger.i('Categories Response: $response');
    } catch (error) {
      _logger.e('Error fetching categories: $error');
    }
  }

  Future<void> fetchAccess() async {
    Map<String, dynamic> requestBody = {};
    try {
      List<dynamic> response = await _infoService.getAccess(requestBody);
      _logger.i('Access Response: $response');
    } catch (error) {
      _logger.e('Error fetching access: $error');
    }
  }
}