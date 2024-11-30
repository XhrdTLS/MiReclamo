import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/globals.dart';
import 'package:mi_reclamo/core/widgets/widgets.dart';
import 'package:mi_reclamo/features/domain/entities/enum/StatusEnum.dart';
import 'package:mi_reclamo/features/domain/entities/enum/TypesEnum.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/pages/home/widgets/statics_card.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/tickets_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mi_reclamo/features/presentation/pages/views.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'widgets/status_stat_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isLoading = true;
  String _userName = '';
  String solicitudesTotales = '0';
  String reclamo_number = '0';
  String sugerencia_number = '0';
  String informations_number = '0';

  /// TODO - Agregar los nuevos estados
  /* Estos son los nuevos a agregar en los cards, ya se cargan automaticamente */
  String error_number = '0';
  String under_review_number = '0';
  String in_progress_number = '0';
  String pending_information_number = '0';
  String resolved_number = '0';
  String closed_number = '0';
  String cancelled_number = '0';
  /// TODO - Agregar los nuevos estados

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadCounts();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadUserName() async {
    _showSkeletonizer();
    final prefs = await SharedPreferences.getInstance();
    String fullName = prefs.getString('name') ?? 'Usuario';
    setState(() {
      String firstName = fullName.split(' ').first;
      _userName =
          firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
    });
  }

  void _loadCounts() async {
    _showSkeletonizer();
    final tickets = await _loadTickets();
    int total = tickets.length;
    int reclamo = tickets.where((ticket) => ticket.type.name == Types.CLAIM.name).length;
    int sugerencia = tickets.where((ticket) => ticket.type.name == Types.SUGGESTION.name).length;
    int information = tickets.where((ticket) => ticket.type.name == Types.INFORMATION.name).length;
    int error = tickets.where((ticket) => ticket.status.name == Status.ERROR.name).length;
    int under_review = tickets.where((ticket) => ticket.status.name == Status.UNDER_REVIEW.name).length;
    int in_progress = tickets.where((ticket) => ticket.status.name == Status.IN_PROGRESS.name).length;
    int pending_information = tickets.where((ticket) => ticket.status.name == Status.PENDING_INFORMATION.name).length;
    int resolved = tickets.where((ticket) => ticket.status.name == Status.RESOLVED.name).length;
    int closed = tickets.where((ticket) => ticket.status.name == Status.CLOSED.name).length;
    int cancelled = tickets.where((ticket) => ticket.status.name == Status.CANCELLED.name).length;
    setState(() {
      solicitudesTotales = total.toString();
      reclamo_number = reclamo.toString();
      sugerencia_number = sugerencia.toString();
      informations_number = information.toString();
      error_number = error.toString();
      under_review_number = under_review.toString();
      in_progress_number = in_progress.toString();
      pending_information_number = pending_information.toString();
      resolved_number = resolved.toString();
      closed_number = closed.toString();
      cancelled_number = cancelled.toString();
      isLoading = false;
    });
  }

  Future<List<Ticket>> _loadTickets() async {
    _showSkeletonizer();
    if (globalTicket.isNotEmpty) {
      return globalTicket;
    } else {
      await initializeTickets();
      return globalTicket;
    }
  }

  void _showSkeletonizer() {
    setState(() {
      isLoading = true;
    });
  }

  Future<void> reload() async {
    _showSkeletonizer();
    await initializeTickets();
    _loadCounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(
        title: 'Inicio',
        isMainScreen: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: reload,
          child: Skeletonizer(
            enabled: isLoading,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("¡Hola $_userName!", style: StyleText.headline),
                    const SizedBox(height: 20),
                    // Tablero de Estadísticas
                    Text("Resumen de las Solicitudes", style: StyleText.label),
                    const SizedBox(height: 12),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        StatCard(
                          icon: AppIcons.ticket,
                          value: solicitudesTotales,
                          label: "Solicitudes Totales",
                          color: AppTheme.lightBlue,
                          onTap: () {
                            globalCategoryFilter = null;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatCard(
                          icon: AppIcons.claim,
                          value: reclamo_number,
                          label: "Reclamos",
                          color: AppTheme.lightOrange,
                          onTap: () {
                            globalCategoryFilter = Types.CLAIM.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatCard(
                          icon: AppIcons.pending,
                          value: sugerencia_number,
                          label: "Sugerencia",
                          color: AppTheme.lightGreen,
                          onTap: () {
                            globalCategoryFilter = Types.SUGGESTION.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatCard(
                          icon: AppIcons.done,
                          value: informations_number,
                          label: "Informacion",
                          color: AppTheme.lightBlue,
                          onTap: () {
                            globalCategoryFilter = Types.INFORMATION.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text("Resumen de los Estados", style: StyleText.label),
                    const SizedBox(height: 12),
                    Column(
                      children: [
                        StatusStatCard(
                          status: "Sin Resolver",
                          count: reclamo_number,
                          color: AppTheme.lightRed,
                          onTap: () {
                            globalCategoryFilter = Types.CLAIM.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatusStatCard(
                          status: "Pendientes",
                          count: sugerencia_number,
                          color: AppTheme.lightOrange,
                          onTap: () {
                            globalCategoryFilter = Types.SUGGESTION.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatusStatCard(
                          status: "Resueltos",
                          count: informations_number,
                          color: AppTheme.lightGreen,
                          onTap: () {
                            globalCategoryFilter = Types.INFORMATION.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
