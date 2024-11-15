
import 'package:logger/logger.dart';
import 'package:mi_reclamo/features/data/data_sources/api_seba/IcsoService.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';

final logger = Logger(printer: PrettyPrinter());


List<Ticket> globalTicket = [];

Future<void> initializeTickets() async {
  IcsoService icsoService = IcsoService();
  globalTicket = await icsoService.getAllTickets();
  logger.i(globalTicket);
}