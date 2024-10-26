import 'package:cm/features/data/data_sources/local/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';


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

  Future<http.Response> get(String endpoint) async {
    Uri url = Uri.parse('$_baseUrl$endpoint');
    Map<String, String> headers = await _getHeaders();
    try {
      final response = await http.get(url, headers: headers);
      // _logger.d(jsonDecode(response.body));
      return response;
    } catch (error) {
      // _logger.e('Error al obtener los datos: $error');
      /*ExceptionHandler.handleException(error);*/
      rethrow;
    }
  }

}