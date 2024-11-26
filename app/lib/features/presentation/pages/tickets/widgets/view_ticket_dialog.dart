import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/screens/screens.dart';

class ViewTicketDialog extends StatelessWidget {
  final Ticket ticket;

  const ViewTicketDialog({required this.ticket, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final manageTicket = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTicketScreen(ticket: ticket),
            )
        );
        if (manageTicket != null) {
          // Handle the updated ticket (e.g., save it to the repository)
        }
      },
      child: AlertDialog(
        title: Text(ticket.subject),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Type: ${ticket.type.name}'),
              Text('Message: ${ticket.message}'),
              Text('Category: ${ticket.category.name}'),
              Text('Category Description: ${ticket.category.description}'),
              Text('Token: ${ticket.token}'),
              Text('Status: ${ticket.status.name}'),
              Text('Created: ${ticket.created}'),
              Text('Updated: ${ticket.updated}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}