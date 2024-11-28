import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/core/exception/exception_handler.dart';
import 'package:mi_reclamo/features/data/data_sources/api_seba/IcsoService.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';

class IcsoController {
  final IcsoService _icsoService = IcsoService();

  /// Obtiene todos los tickets de una categoría
  Future<void> fetchAllTokenByCategory(Map<String, dynamic> headers) async {
    try {
      List<dynamic> response = await _icsoService.getAllTokenByCategory(headers);
      Map<String, dynamic> responseMap = {for (var item in response) item['key']: item['value']};
      verifyResponse(responseMap);
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  /// Crea un nuevo ticket
  Future<void> fetchCreateTicket(Map<String, dynamic> headers, Map<String, dynamic> requestBody) async {
    try {
      Map<String, dynamic> response = await _icsoService.createTicket(headers, requestBody);
      verifyResponse(response);
      // _logger.i('CreateTicket Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  /// Obtiene un ticket por token
  Future<Map<String, dynamic>> fetchTicketByToken(String headers) async {
    try {
      Map<String, dynamic> response = await _icsoService.getTicketByToken(headers);
      verifyResponse(response);
      return response;
      // _logger.i('TicketByToken Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
      rethrow;
    }
  }

  /// Actualiza un ticket por token
  Future<void> updateTicketByToken(Ticket update) async {
    try {
      Map<String, dynamic> response = await _icsoService.responseTicket(update);
      verifyResponse(response);
      // _logger.i('UpdateTicketByToken Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  /// Elimina un ticket por token
  Future<void> deleteTicketByToken(String token) async {
    try {
      _icsoService.deleteTicket(token);
      // _logger.i('DeleteTicketByToken Response: $response');
    } catch (error) {
      ExceptionHandler.handleException(error);
    }
  }

  Future<List<Ticket>> fetchAll() async {
    try {
      List<Ticket> response = await _icsoService.getAllTickets();
      // logger.i('Reclamos Response: $response');
      return response;
    } catch (error) {
      ExceptionHandler.handleException(error);
      return [];
    }
  }

  Future<Map<String,dynamic>> fetchAttachedFile(String token, String attatchmentToken) async {
    try {
      Map<String,dynamic> response = await _icsoService.fetchAttachedFile(token, attatchmentToken);
      verifyResponse(response);
      return response;
    } catch (error) {
      logger.e('Error fetching attached file: $error');
      ExceptionHandler.handleException(error);
      rethrow;
    }
  }

  bool isProblemDetail(Map<String, dynamic> response) {
    return response.containsKey('type') &&
        response.containsKey('title') &&
        response.containsKey('status') &&
        response.containsKey('detail') &&
        response.containsKey('instance');
  }

  void verifyResponse(Map<String, dynamic> response) {
    if (isProblemDetail(response)) {
      logger.i('PROBLEMDETAIL');
      logger.e('Error: ${response['detail']}');
      ExceptionHandler.handleException(response);
    }
  }
}



