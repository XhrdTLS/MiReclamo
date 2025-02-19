import 'package:mi_reclamo/core/globals.dart';
import 'package:mi_reclamo/features/data/data_sources/api_seba/IcsoService.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/controllers/ticket/icsoController.dart';

class EditTicketActions {
  final IcsoController _icsoController = IcsoController();
  final IcsoService _icsoService = IcsoService();

  Future<void> chargeTicket(String token, Function(List<dynamic>) onSuccess) async {
    logger.i('Charging ticket $token');
    try {
      final result = await _icsoController.fetchTicketByToken(token);
      logger.i('Test: $result');
      onSuccess(result['attachedTokens'] ?? []);
    } catch (e) {
      logger.e('Error fetching ticket: $e');
    }
  }

  Future<void> fetchAndDisplayFile(String ticketToken, String attachedToken, Function(Map<String, dynamic>) onSuccess) async {
    try {
      final fileResult = await _icsoController.fetchAttachedFile(ticketToken, attachedToken);
      logger.i('Attached file: $fileResult');
      onSuccess(fileResult);
    } catch (e) {
      logger.e('Error fetching attached file: $e');
    }
  }


  Future<void> deleteTicket(String token, Function() onSuccess) async {
    try {
      await _icsoController.deleteTicketByToken(token);
      onSuccess();
    } catch (e) {
      logger.e('Error deleting ticket: $e');
    }
  }

  Future<void> updateTicket(Ticket updatedTicket, Function() onSuccess) async {
    try {
      await _icsoController.updateTicketByToken(updatedTicket);
      onSuccess();
    } catch (e) {
      logger.e('Error updating ticket: $e');
    }
  }



}