
import 'dart:convert';

import 'package:mi_reclamo/features/data/data_sources/api_seba/baseService.dart';
import 'package:logger/logger.dart';

class IcsoService extends BaseService{
  final Logger _logger = Logger();

  /// url
  /// {{baseUrl}}/v1/icso
  String get url => '/v1/icso';


  /// Obtiene todos los tickets de una categoría
  ///
  Future<List<dynamic>> getAllTokenByCategory(Map<String, dynamic> headers) async {
    final categoryToken = headers['categoryToken'];
    try {
      final response = await get('$url/$categoryToken/tickets');
      _logger.d(jsonDecode(response.body));
      final List<dynamic> types = jsonDecode(response.body);
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }

  /// Crea un nuevo ticket
  /// {{baseUrl}}/v1/icso/:categoryToken/ticket
  /// todo verificar si funciona este post, el baseurl lo cree recien
  Future<Map<String, dynamic>> createTicket(Map<String, dynamic> headers, Map<String, dynamic> requestBody) async {
    final categoryToken = headers['categoryToken'];
    try {
      final response = await post('$url/$categoryToken/ticket', requestBody);
      _logger.d(jsonDecode(response.body));
      final Map<String, dynamic> types = jsonDecode(response.body);
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }

  /// Obtiene un ticket por token
  /// {{baseUrl}}/v1/icso/:ticketToken/ticket
  ///
  Future<Map<String, dynamic>> getTicketByToken(Map<String, dynamic> headers) async {
    final ticketToken = headers['ticketToken'];
    try {
      final response = await get('$url/$ticketToken/ticket');
      _logger.d(jsonDecode(response.body));
      final Map<String, dynamic> types = jsonDecode(response.body);
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }

  /// Actualiza un ticket existente
  /// {{baseUrl}}/v1/icso/:ticketToken/ticket
  /// todo probar
  Future<Map<String, dynamic>> updateTicket(Map<String, dynamic> headers, Map<String, dynamic> requestBody) async {
    final ticketToken = headers['ticketToken'];
    try {
      final response = await post('$url/$ticketToken/ticket', requestBody);
      _logger.d(jsonDecode(response.body));
      final Map<String, dynamic> types = jsonDecode(response.body);
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }
  /// Elimina un ticket
  /// {{baseUrl}}/v1/icso/:ticketToken/ticket
  /// todo probar
  Future<Map<String, dynamic>> deleteTicket(Map<String, dynamic> headers) async {
    final ticketToken = headers['ticketToken'];
    try {
      final response = await delete('$url/$ticketToken/ticket');
      _logger.d(jsonDecode(response.body));
      final Map<String, dynamic> types = jsonDecode(response.body);
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }

}