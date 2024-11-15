import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';

class ViewTicketDialog extends StatelessWidget {
  final Ticket ticket;

  const ViewTicketDialog({required this.ticket, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}