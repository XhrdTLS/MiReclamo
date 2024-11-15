import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/widgets/widgets.dart';

class TicketsPage extends StatelessWidget {
  final List<Ticket> tickets;

  const TicketsPage({super.key, required this.tickets});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tickets')),
      body: tickets.isEmpty
          ? const Center(child: Text('No hay tickets para mostrar'))
          : ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final ticket = tickets[index];
          return TicketCard(
            ticket: ticket,
            onDelete: () {
              // Implement delete functionality
            },
          );
        },
      ),
    );
  }
}