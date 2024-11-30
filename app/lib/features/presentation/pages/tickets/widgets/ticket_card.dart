import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import '../../../../../core/core.dart';
import '../screens/screens.dart';
import 'widgets.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback onDelete;
  final VoidCallback onReloadTickets;
  final Function(Ticket) onNavigateToEditTicket;

  const TicketCard({
    required this.ticket,
    required this.onDelete,
    required this.onReloadTickets,
    required this.onNavigateToEditTicket,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String tipo = ticket.type.name;
    String asunto = ticket.subject;
    String estado = ticket.status.name;
    String mensaje = ticket.message;
    String categoria = ticket.category.name;

    return GestureDetector(
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) => ViewTicketDialog(ticket: ticket),
        );
      },
      onTap: () {
        onNavigateToEditTicket(ticket);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppTheme.lightGray,
            width: 1,
          ),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              left: BorderSide(color: getTipoColor(context, tipo), width: 8),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  getTipoIcon(tipo), // Updated to use IconData
                  weight: 700,
                  color: getTipoTextColor(tipo), // Updated to use getTipoTextColor
                  size: 25,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              categoria,
                              style: StyleText.header.copyWith(
                                color: getTipoTextColor(tipo), // Updated to use getTipoTextColor
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: getEstadoColor(estado),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              estado,
                              style: StyleText.labelSmall.copyWith(
                                color: getEstadoTextColor(estado),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        asunto,
                        style: StyleText.description.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                      if (mensaje.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            mensaje,
                            style: StyleText.body.copyWith(
                              color: AppTheme.darkGray,
                            ),
                            maxLines: 3, 
                            overflow: TextOverflow.ellipsis, 
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
