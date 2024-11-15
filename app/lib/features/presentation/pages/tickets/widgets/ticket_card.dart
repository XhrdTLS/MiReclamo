import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';

import 'widgets.dart';

class TicketCard extends StatelessWidget {
  final Ticket ticket;
  final VoidCallback onDelete;

  const TicketCard({
    required this.ticket,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(ticket.subject),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Type: ${ticket.type.name}'),
            Text('Status: ${ticket.status.name}'),
            Text('Category: ${ticket.category.name}'),
            Text('Message: ${ticket.message}'),
            // Text('Category Description: ${ticket.category.description}'),
            Text('Token: ${ticket.token}'),
            // Text('Created: ${ticket.created}'),
            // Text('Updated: ${ticket.updated}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_forever_outlined),
          onPressed: onDelete,
        ),
        onTap: () => showDialog(
          context: context,
          builder: (context) => ViewTicketDialog(ticket: ticket),
        ),
      ),
    );
  }
}