import 'package:cm/features/data/data_sources/local/storage_service.dart';
import 'package:http/http.dart' as http;

import '../../../../core/exception/exception_handler.dart';


class BaseService {
  static const String _baseUrl = 'https://api.sebastian.cl/oirs-utem';
  static const String _contentType = "application/json";

  Future<Map<String, String>> _getHeaders() async {
    String jwt = await StorageService.getValue('idToken');
    return {
      'accept': _contentType,
      'Content-Type': _contentType,
      'Authorization': "Bearer $jwt"
    };
  }

  /// Base Get
  ///
  Future<http.Response> get(String endpoint) async {
    Uri url = Uri.parse('$_baseUrl$endpoint');
    Map<String, String> headers = await _getHeaders();
    try {
      final response = await http.get(url, headers: headers);
      // _logger.d(jsonDecode(response.body));
      return response;
    } catch (error) {
      // _logger.e('Error al obtener los datos: $error');
      ExceptionHandler.handleException(error);
      rethrow;
    }
  }

  /// Base Post
  /// todo probar
  Future<http.Response> post(String endpoint, Map<String, dynamic> requestBody) async {
    Uri url = Uri.parse('$_baseUrl$endpoint');
    Map<String, String> headers = await _getHeaders();
    try {
      final response = await http.post(url, headers: headers, body: requestBody);
      // _logger.d(jsonDecode(response.body));
      return response;
    } catch (error) {
      // _logger.e('Error al obtener los datos: $error');
      ExceptionHandler.handleException(error);
      rethrow;
    }
  }

  /// Base Put
  /// todo probar
  Future<http.Response> put(String endpoint, Map<String, dynamic> requestBody) async {
    Uri url = Uri.parse('$_baseUrl$endpoint');
    Map<String, String> headers = await _getHeaders();
    try {
      final response = await http.put(url, headers: headers, body: requestBody);
      // _logger.d(jsonDecode(response.body));
      return response;
    } catch (error) {
      // _logger.e('Error al obtener los datos: $error');
      ExceptionHandler.handleException(error);
      rethrow;
    }
  }

  /// Base Delete
  /// todo probar
  Future<http.Response> delete(String endpoint) async {
    Uri url = Uri.parse('$_baseUrl$endpoint');
    Map<String, String> headers = await _getHeaders();
    try {
      final response = await http.delete(url, headers: headers);
      // _logger.d(jsonDecode(response.body));
      return response;
    } catch (error) {
      // _logger.e('Error al obtener los datos: $error');
      ExceptionHandler.handleException(error);
      rethrow;
    }
  }


}