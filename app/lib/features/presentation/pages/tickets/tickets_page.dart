import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/globals.dart';
import 'package:mi_reclamo/core/widgets/navigation/top_navigation.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/controllers/ticket/icsoController.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/widgets/tickets_list.dart';

class TicketsPage extends StatelessWidget {
  final IcsoController _testViewModel = IcsoController();

  TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Solicitudes", isMainScreen: true),
      body: FutureBuilder(
        future: _loadTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Container(); // Return an empty container if no tickets
          } else {
            final tickets = snapshot.data as List<Ticket>;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TicketsList(tickets: tickets),
            );
          }
        },
      ),
    );
  }

  Future<List<Ticket>> _loadTickets() async {
    if (globalTicket.isNotEmpty) {
      return globalTicket;
    } else {
      return await _testViewModel.fetchAll();
    }
  }
}
