import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import '../../../../../core/core.dart';
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

    final brightness = Theme.of(context).brightness;
    Color tipoColor;
    Color textColor;
    IconData typeIcon;

    switch (tipo) {
      case 'CLAIM':
        tipoColor = brightness == Brightness.light
            ? AppTheme.lightOrange
            : AppTheme.darkOrange;
        textColor = AppTheme.darkOrange;
        typeIcon = Icons.warning_rounded;
        break;
      case 'SUGGESTION':
        tipoColor = brightness == Brightness.light
            ? AppTheme.lightGreen
            : AppTheme.darkGreen;
        textColor = AppTheme.darkGreen;
        typeIcon = Icons.lightbulb_rounded;
        break;
      case 'INFORMATION':
        tipoColor = brightness == Brightness.light
            ? AppTheme.lightBlue
            : AppTheme.darkBlue;
        textColor = AppTheme.darkBlue;
        typeIcon = Icons.info_rounded;
        break;
      default:
        tipoColor = AppTheme.lightGray;
        textColor = AppTheme.lightGray;
        typeIcon = Icons.help_rounded;
    }

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
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border(
              left: BorderSide(color: tipoColor, width: 4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          typeIcon,
                          color: textColor,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          categoria,
                          style: StyleText.header.copyWith(
                            color: textColor,
                          ),)
                      ],),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: tipoColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        estado,
                        style: StyleText.labelSmall.copyWith(
                          color: textColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  asunto,
                  style: StyleText.body.copyWith(                  ),
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                if (mensaje.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      mensaje,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        color: Colors.grey,
                      ),
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
