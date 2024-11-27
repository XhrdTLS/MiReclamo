import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/widgets/widgets.dart';

class TicketsList extends StatefulWidget {
  final List<Ticket> tickets;

  const TicketsList({super.key, required this.tickets});

  @override
  TicketsListState createState() => TicketsListState();
}

class TicketsListState extends State<TicketsList> {
  List<Ticket> _filteredTickets = [];

  @override
  void initState() {
    super.initState();
    _filteredTickets = widget.tickets;
  }

  void _filter(List<Ticket> filteredList) {
    setState(() {
      _filteredTickets = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        /// TODO: Implement delete functionality
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }
}