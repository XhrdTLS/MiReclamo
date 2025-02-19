import 'dart:convert';
import 'package:logger/logger.dart';
import 'baseService.dart';

class V0Infoservice extends BaseService {
  final Logger _logger = Logger();

  /// Informacion
  String get v1 => '/v1/info';

  /// Obtener todos los tipos de requerimientos
  Future<List<dynamic>> getTypes(Map<String, dynamic> requestBody) async {
    try {
      final response = await get('$v1/types');
      _logger.d(jsonDecode(response.body));
      final List<dynamic> types = jsonDecode(response.body);
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch types: $error');
    }
  }

  /// Obtener todos los estados de requerimientos
  Future<List<dynamic>> getStatus(Map<String, dynamic> requestBody) async {
    try {
      final response = await get('$v1/status');
      _logger.d(jsonDecode(response.body));
      final List<dynamic> types = jsonDecode(response.body);
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch types: $error');
    }
  }

  /// Obtener todas las categorias
  Future<List<dynamic>> getCategory() async {
    try {
      final response = await get('$v1/categories');
      _logger.d(jsonDecode(response.body));
      final List<dynamic> types = jsonDecode(response.body);
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch types: $error');
    }
  }
  /// Obtener todas los accesos al servicio
  Future<List<dynamic>> getAccess(Map<String, dynamic> requestBody) async {
    try {
      final response = await get('$v1/access');
      _logger.d(jsonDecode(response.body));
      final List<dynamic> types = jsonDecode(response.body);
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch types: $error');
    }
  }

}