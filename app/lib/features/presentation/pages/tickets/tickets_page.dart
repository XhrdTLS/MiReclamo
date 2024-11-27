import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';

import 'widgets/widgets.dart';

class TicketsPage extends StatefulWidget {
  final String? category;

  const TicketsPage({super.key, this.category});

  @override
  _TicketsPageState createState() => _TicketsPageState();
}



class _TicketsPageState extends State<TicketsPage> {
  List<Ticket> ticketsList = [];

  @override
  void initState() {
    super.initState();
    _loadTickets();
    // ticketsList = globalTicket;
  }

  Future<void> _loadTickets() async {
    try {
      await initializeTickets();
      setState(() {
        if (widget.category != null && widget.category!.isNotEmpty) {
          ticketsList = globalTicket.where((ticket) => ticket.type.name == widget.category).toList();
        } else {
          ticketsList = globalTicket;
        }
      });
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  /// TODO ESTO DEBO CAMBIARLO PARA QUE CAMBIE EL CATEGORY Y VUELVA A LLAMAR EL _LOADTICKETs
  void _filter(List<Ticket> filteredList){
    setState(() {
      ticketsList = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Tickets", isMainScreen: false),
      body: Column(
        children: [
          FilterWidget(
            allSolicitudes: ticketsList,
            onFilterApplied: _filter,
          ),
          Expanded(
            child: ticketsList.isEmpty
                ? const Center(child: Text('No hay tickets para mostrar'))
                : ListView.builder(
              itemCount: ticketsList.length,
              itemBuilder: (context, index) {
                final ticket = ticketsList[index];
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
      ),
    );
  }
}