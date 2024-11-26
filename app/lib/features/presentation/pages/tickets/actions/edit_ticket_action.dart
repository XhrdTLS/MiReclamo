import 'package:mi_reclamo/core/globals.dart';
import 'package:mi_reclamo/features/presentation/controllers/ticket/icsoController.dart';

class EditTicketActions {
  final IcsoController _icsoController = IcsoController();

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
}