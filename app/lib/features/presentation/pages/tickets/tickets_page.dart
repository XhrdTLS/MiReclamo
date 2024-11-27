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
  String? currentCategory;

  @override
  void initState() {
    super.initState();
    currentCategory = widget.category;
    _loadTickets();
    // ticketsList = globalTicket;
  }

  Future<void> _loadTickets() async {
    try {
      if (globalTicket.isEmpty){
        await initializeTickets();
      }
      // await initializeTickets();
      setState(() {
        if (currentCategory != null && currentCategory!.isNotEmpty) {
          ticketsList = globalTicket.where((ticket) => ticket.type.name == currentCategory).toList();
        } else {
          ticketsList = globalTicket;
        }
      });
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _updateCategory(String? category) {
    setState(() {
      currentCategory = category;
      _loadTickets();
    });
  }

  Future<void> _reloadTickets() async {
    await initializeTickets();
    setState(() {
      ticketsList.clear();
    });
    await _loadTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Tickets", isMainScreen: false),
      body: Column(
        children: [
          FilterWidget(
            onCategoryChanged: _updateCategory,
          ),
          Expanded(
            child: RefreshIndicator(
                onRefresh: _reloadTickets,
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
            )

          ),
        ],
      ),
    );
  }
}