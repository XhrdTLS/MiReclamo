import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/features/domain/entities/enum/StatusEnum.dart';
import 'package:mi_reclamo/features/domain/entities/enum/TypesEnum.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'actions/actions.dart';
import 'screens/screens.dart';
import 'widgets/widgets.dart';

class TicketsPage extends StatefulWidget {
  final bool isMainScreen;

  const TicketsPage({super.key, this.isMainScreen = true});

  @override
  TicketsPageState createState() => TicketsPageState();
}

class TicketsPageState extends State<TicketsPage> {
  List<Ticket> ticketsList = [];
  bool isLoading = true;
  String? globalFilter;


  @override
  void initState() {
    super.initState();
    _loadTickets();
  }

  Future<void> _loadTickets() async {
    _showSkeletonizer();
    try {
      if (globalTicket.isEmpty){
        await initializeTickets();
      }
      globalFilter = globalCategoryFilter;
      setState(() {
        if (globalFilter != null && globalFilter!.isNotEmpty) {
          if (Types.values.any((type) => type.name == globalFilter)) {
            ticketsList = globalTicket.where((ticket) => ticket.type.name == globalFilter).toList();
          } else if (Status.values.any((status) => status.name == globalFilter)) {
            ticketsList = globalTicket.where((ticket) => ticket.status.name == globalFilter).toList();
          }
        }
          else {
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
      globalCategoryFilter = category;
      _loadTickets();
    });
  }

  void _updateStatus(String? status) {
    setState(() {
      globalFilter = status;
      _loadTickets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopNavigation(title: "Solicitudes", isMainScreen: widget.isMainScreen),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _reloadTickets,
          child: Skeletonizer(
            enabled: isLoading,
            child: Column(
              children: [
                FilterTipo(
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

