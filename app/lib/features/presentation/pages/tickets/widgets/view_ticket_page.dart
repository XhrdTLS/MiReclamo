import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';

import '../../../../../core/core.dart';
import '../screens/screens.dart';

class ViewTicketScreen extends StatelessWidget {
  final Ticket ticket;

  const ViewTicketScreen({required this.ticket, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigation(title: ticket.subject, isMainScreen: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final manageTicket = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => EditTicketScreen(ticket: ticket),
            ),
          );
          if (manageTicket != null) {
            // Handle the updated ticket (e.g., save it to the repository)
          }
        },
        child: const Icon(AppIcons.edit),
      ),
    );
  }
}