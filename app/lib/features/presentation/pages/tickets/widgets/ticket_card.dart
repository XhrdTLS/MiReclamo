import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';

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

    Color tipoColor;
    switch (tipo) {
      case 'CLAIM':
        tipoColor = Colors.red;
        break;
      case 'SUGGESTION':
        tipoColor = Colors.green;
        break;
      case 'INFORMATION':
        tipoColor = Colors.blue;
        break;
      default:
        tipoColor = Colors.grey;
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
        // final manageTicket = await Navigator.of(context).push(
        //     MaterialPageRoute(
        //       builder: (context) => EditTicketScreen(ticket: ticket),
        //     )
        // );
        // if (manageTicket != null) {
        //   onReloadTickets();
        // }
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
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
                    Text(
                      categoria,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: tipoColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: tipoColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        estado,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  asunto,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                  ),
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



