
import 'dart:convert';

import 'package:mi_reclamo/features/data/data_sources/api_seba/baseService.dart';
import 'package:logger/logger.dart';

class InfoService extends BaseService {
  final Logger _logger = Logger();

  /// url informacion
  String get v1 => '/v1/info';

  /// Obtener todos los tipos de requerimientos
  Future<List<dynamic>> getTypes() async {
    try {
      final response = await get('$v1/types');
      // _logger.d(json.decode(utf8.decode(response.bodyBytes)));
      final data = json.decode(utf8.decode(response.bodyBytes));
      _logger.i('Response Data: $data');
      final List<dynamic> types = json.decode(utf8.decode(response.bodyBytes));
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch types: $error');
    }
  }

  /// Obtener todos los estados de requerimientos
  Future<List<dynamic>> getStatus() async {
    try {
      final response = await get('$v1/status');
      _logger.d(json.decode(utf8.decode(response.bodyBytes)));
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
      _logger.d(json.decode(utf8.decode(response.bodyBytes)));
      final List<dynamic> types = json.decode(utf8.decode(response.bodyBytes));
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch types: $error');
    }
  }
  /// Obtener todas los accesos al servicio
  Future<List<dynamic>> getAccess() async {
    try {
      final response = await get('$v1/access');
      _logger.d(json.decode(utf8.decode(response.bodyBytes)));
      final List<dynamic> types = json.decode(utf8.decode(response.bodyBytes));
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch types: $error');
    }
  }



}