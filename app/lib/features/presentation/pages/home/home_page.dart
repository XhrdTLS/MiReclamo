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
import 'widgets/status_statics_card.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/actions/filter_status.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  bool isLoading = true;
  String _userName = '';
  String solicitudesTotales = '0';
  String reclamoNumber = '0';
  String sugerenciaNumber = '0';
  String informationsNumber = '0';

  /* Estos son los nuevos a agregar en los cards, ya se cargan automaticamente */
  String receivedNumber = '0';
  String underReviewNumber = '0';
  String inProgressNumber = '0';
  String pendingInformationNumber = '0';
  String resolvedNumber = '0';
  String closedNumber = '0';
  String rejectedNumber = '0';
  String cancelledNumber = '0';

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
    int received = tickets.where((ticket) => ticket.status.name == Status.RECEIVED.name).length;
    int underReview = tickets.where((ticket) => ticket.status.name == Status.UNDER_REVIEW.name).length;
    int inProgress = tickets.where((ticket) => ticket.status.name == Status.IN_PROGRESS.name).length;
    int pendingInformation = tickets.where((ticket) => ticket.status.name == Status.PENDING_INFORMATION.name).length;
    int resolved = tickets.where((ticket) => ticket.status.name == Status.RESOLVED.name).length;
    int closed = tickets.where((ticket) => ticket.status.name == Status.CLOSED.name).length;
    int rejected = tickets.where((ticket) => ticket.status.name == Status.REJECTED.name).length;
    int cancelled = tickets.where((ticket) => ticket.status.name == Status.CANCELLED.name).length;
    setState(() {
      solicitudesTotales = total.toString();
      reclamoNumber = reclamo.toString();
      sugerenciaNumber = sugerencia.toString();
      informationsNumber = information.toString();
      
      receivedNumber = received.toString();
      underReviewNumber = underReview.toString();
      inProgressNumber = inProgress.toString();
      pendingInformationNumber = pendingInformation.toString();
      resolvedNumber = resolved.toString();
      closedNumber = closed.toString();
      rejectedNumber = rejected.toString();
      cancelledNumber = cancelled.toString();
      
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
        title: 'Administrador',
        isMainScreen: true,
      ),
      body: SafeArea(
        top: true,
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
                    const SizedBox(height: 12),
                    // Tablero de Estadísticas
                    Text("Resumen de las Solicitudes", style: StyleText.label),
                    const SizedBox(height: 8),
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
                          color: AppTheme.lightStone,
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
                          value: reclamoNumber,
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
                          value: sugerenciaNumber,
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
                          value: informationsNumber,
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
                    const SizedBox(height: 12),
                    // Tablero de Estadísticas de Estados
                    Text("Resumen de los Estados", style: StyleText.label),
                    const SizedBox(height: 8),
                    Column(
                      children: [
                        StatusStatCard(
                          status: "Recibido",
                          count: receivedNumber,
                          color: AppTheme.lightGray,
                          icon: AppIcons.received,
                          onTap: () {
                            globalStatusFilter = Status.RECEIVED.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatusStatCard(
                          status: "En Revisión",
                          count: underReviewNumber,
                          color: AppTheme.lightGray,
                          icon: AppIcons.review,
                          onTap: () {
                            globalStatusFilter = Status.UNDER_REVIEW.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatusStatCard(
                          status: "En Progreso",
                          count: inProgressNumber,
                          color: AppTheme.lightGray,
                          icon: AppIcons.pending,
                          onTap: () {
                            globalStatusFilter = Status.IN_PROGRESS.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatusStatCard(
                          status: "Solicitud de Información",
                          count: pendingInformationNumber,
                          color: AppTheme.lightGray,
                          icon: AppIcons.pending,
                          onTap: () {
                            globalStatusFilter = Status.PENDING_INFORMATION.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatusStatCard(
                          status: "Resuelto",
                          count: resolvedNumber,
                          color: AppTheme.lightGray,
                          icon: AppIcons.done,
                          onTap: () {
                            globalStatusFilter = Status.RESOLVED.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatusStatCard(
                          status: "Cerrado (Aprobado)",
                          count: closedNumber,
                          color: AppTheme.lightGray,
                          icon: AppIcons.done,
                          onTap: () {
                            globalStatusFilter = Status.CLOSED.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatusStatCard(
                          status: "Cerrado (Rechazado)",
                          count: rejectedNumber,
                          color: AppTheme.lightGray,
                          icon: AppIcons.rejected,
                          onTap: () {
                            globalStatusFilter = Status.REJECTED.name;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TicketsPage(isMainScreen: false),
                              ),
                            );
                          },
                        ),
                        StatusStatCard(
                          status: "Cancelado",
                          count: cancelledNumber,
                          color: AppTheme.lightGray,
                          icon: AppIcons.rejected,
                          onTap: () {
                            globalStatusFilter = Status.CANCELLED.name;
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
