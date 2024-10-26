import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'baseService.dart';

class TestService extends BaseService {
  final Logger _logger = Logger();

  /// Informacion
  String get v1 => '/v1/info';

  Future<List<dynamic>> getTest(Map<String, dynamic> requestBody) async {
    try {
      final response = await get('$v1/types');
      // final response = await get('/v1/info/types');
      _logger.d(jsonDecode(response.body));
      return [];
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      return [];
    }
  }

}