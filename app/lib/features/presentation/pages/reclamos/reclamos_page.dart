import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/globals.dart';
import 'package:mi_reclamo/core/widgets/navigation/top_navigation.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/controllers/test/icsoController.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/tickets_page.dart';

class ReclamosPage extends StatelessWidget {
  final IcsoController _testViewModel = IcsoController();

  ReclamosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Solicitudes", isMainScreen: false),
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
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketsPage(tickets: tickets),
                    ),
                  );
                },
                child: const Text('View All Tickets'),
              ),
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