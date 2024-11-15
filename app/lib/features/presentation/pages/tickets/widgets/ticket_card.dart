import 'package:flutter/material.dart';

class TicketCard extends StatelessWidget {
  final Map<String, dynamic> ticket;

  const TicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(ticket['name']),
        subtitle: Text(ticket['description']),
      ),
    );
  }
}
