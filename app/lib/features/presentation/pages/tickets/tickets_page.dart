import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/widgets/widgets.dart';

class TicketsPage extends StatefulWidget {
  final List<Ticket> tickets;

  const TicketsPage({super.key, required this.tickets});

  @override
  _TicketsPageState createState() => _TicketsPageState();
}



class _TicketsPageState extends State<TicketsPage> {
  List<Ticket> _filteredTickets = [];

  @override
  void initState() {
    super.initState();
    _filteredTickets = widget.tickets;
  }

  void _filter(List<Ticket> filteredList){
    setState(() {
      _filteredTickets = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Tickets", isMainScreen: false),
      body: Column(
        children: [
          FilterWidget(
            allSolicitudes: widget.tickets,
            onFilterApplied: _filter,
          ),
          Expanded(
            child: _filteredTickets.isEmpty
                ? const Center(child: Text('No hay tickets para mostrar'))
                : ListView.builder(
              itemCount: _filteredTickets.length,
              itemBuilder: (context, index) {
                final ticket = _filteredTickets[index];
                return TicketCard(
                  ticket: ticket,
                  onDelete: () {
                    // Implement delete functionality
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}