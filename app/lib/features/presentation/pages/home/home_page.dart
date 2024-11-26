import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/globals.dart';
import 'package:mi_reclamo/core/widgets/widgets.dart';
import 'package:mi_reclamo/features/domain/entities/enum/TypesEnum.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';
import 'package:mi_reclamo/features/presentation/controllers/ticket/icsoController.dart';
import 'package:mi_reclamo/features/presentation/pages/home/widgets/assigned_claim.dart';
import 'package:mi_reclamo/features/presentation/pages/home/widgets/statics_card.dart';
import 'package:mi_reclamo/features/presentation/pages/tickets/tickets_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
   String _userName = '';
   final IcsoController _testViewModel = IcsoController();
   String solicitudesTotales = '0';
   String sinResolver = '0';
   String pendientes = '0';
   String resueltos = '0';


  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadCounts();
  }

   Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    String fullName = prefs.getString('name') ?? 'Usuario';
    setState(() {
      String firstName = fullName.split(' ').first;
      _userName = firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
    });
  }


   void _loadCounts() async {
      final tickets = await _loadTickets();
       int total = tickets.length;
       int unresolved = tickets.where((ticket) => ticket.type.name == Types.CLAIM.name).length;
       int pending = tickets.where((ticket) => ticket.type.name == Types.SUGGESTION.name).length;
       int resolved = tickets.where((ticket) => ticket.type.name == Types.INFORMATION.name).length;
       setState(() {
         solicitudesTotales = total.toString();
         sinResolver = unresolved.toString();
         pendientes = pending.toString();
         resueltos = resolved.toString();
       });
   }

   Future<List<Ticket>> _loadTickets() async {
     if (globalTicket.isNotEmpty) {
       return globalTicket;
     } else {
       await initializeTickets();
       return globalTicket;
     }
   }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TicketsPage(tickets: globalTicket),
                  ),
                  );
                },
              ),
              StatCard(
                icon: AppIcons.claim,
                value: sinResolver,
                label: "Sin Resolver",
                color: AppTheme.lightRed,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketsPage(tickets: globalTicket.where((ticket) => ticket.type.name == Types.CLAIM.name).toList()),
                    ),
                  );
                },
              ),
              StatCard(
                icon: AppIcons.pending,
                value: pendientes,
                label: "Pendientes",
                color: AppTheme.lightOrange,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketsPage(tickets: globalTicket.where((ticket) => ticket.type.name == Types.SUGGESTION.name).toList()),
                    ),
                  );
                },
              ),
              StatCard(
                icon: AppIcons.done,
                value: resueltos,
                label: "Resueltos",
                color: AppTheme.lightGreen,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TicketsPage(tickets: globalTicket.where((ticket) => ticket.type.name == Types.INFORMATION.name).toList()),
                    ),
                  );
                },
              ),
              ],
            ),

              const SizedBox(height: 24),
              // Asignados
              Text("Solicitudes Asignadas", style: StyleText.label),
              const SizedBox(height: 12),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => const AssignedClaim(),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      );
  }
}

/*class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        clipBehavior: Clip.none,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TopNavigation(titulo: "Administrador"),
            Text("Hola! ", style: StyleText.headline),
            const SizedBox(height: 20),
            // Tablero de Estadísticas
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
                value: "25",
                label: "Solicitudes Totales",
                color: AppTheme.lightBlue, 
              ),
              StatCard(
                icon: AppIcons.claim,
                value: "10",
                label: "Sin Resolver",
                color: AppTheme.lightRed,
              ),
              StatCard(
                icon: AppIcons.pending,
                value: "12",
                label: "Pendientes",
                color: AppTheme.lightOrange,
              ),
              StatCard(
                icon: AppIcons.done,
                value: "3",
                label: "Resueltos",
                color: AppTheme.lightGreen,
              ),
              ],
            ),

            const SizedBox(height: 24),
            // Asignados
            Text("Solicitudes Asignadas", style: StyleText.label),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) => const AssignedClaim(),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}*/


