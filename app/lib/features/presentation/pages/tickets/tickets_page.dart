import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'screens/screens.dart';
import 'widgets/widgets.dart';

class TicketsPage extends StatefulWidget {
  final String? category;

  const TicketsPage({super.key, this.category});

  @override
  TicketsPageState createState() => TicketsPageState();
}

class TicketsPageState extends State<TicketsPage> {
  List<Ticket> ticketsList = [];
  String? currentCategory;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentCategory = widget.category;
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    _showSkeletonizer();
    try {
      if (globalTicket.isEmpty){
        await initializeTickets();
      }
      setState(() {
        if (currentCategory != null && currentCategory!.isNotEmpty) {
          ticketsList = globalTicket.where((ticket) => ticket.type.name == currentCategory).toList();
        } else {
          ticketsList = globalTicket;
        }
        isLoading = false;
      });
    } catch (e) {
      logger.e('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showSkeletonizer() {
    setState(() {
      isLoading = true;
    });
  }

  Future<void> _reloadTickets() async {
    _showSkeletonizer();
    await initializeTickets();
    setState(() {
      ticketsList.clear();
    });
    await _loadTickets();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Solicitudes", isMainScreen: true),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _reloadTickets,
          child: Skeletonizer(
            enabled: isLoading,
            child: Column(
              children: [
                FilterWidget(
                  onCategoryChanged: _updateCategory,
                ),
                Expanded(
                  child: ticketsList.isEmpty && !isLoading
                      ? const Center(child: Text('No hay tickets para mostrar'))
                      : ListView.builder(
                          itemCount: ticketsList.length,
                          itemBuilder: (context, index) {
                            final ticket = ticketsList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: TicketCard(
                                ticket: ticket,
                                onDelete: () {
                                  /// TODO: Implement delete functionality
                                },
                                onNavigateToEditTicket: _navigateToEditTicket,
                                onReloadTickets: _reloadTickets,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToEditTicket(Ticket ticket) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => EditTicketScreen(ticket: ticket),
      ),
    );

    if (result == true) {
      _reloadTickets(); // Reload tickets if a ticket was deleted
    }
  }
}

