import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/widgets/styles/icons.dart';
import 'package:mi_reclamo/core/widgets/navigation/navigation.dart';
import 'package:mi_reclamo/features/presentation/pages/profile/profile_page.dart';
import 'package:mi_reclamo/features/presentation/pages/views.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int idx = 0;
  final List<NavigationItem> screens = [
    NavigationItem(destination: const HomePage(), label: "Inicio", icon: AppIcons.home),
    NavigationItem(destination: TicketsPage(), label: "Solicitudes", icon: AppIcons.ticket),
    NavigationItem(destination: const NotasPage(), label: "Notas", icon: AppIcons.notes),
    NavigationItem(destination: const ProfilePage(), label: "Perfil", icon: AppIcons.profile),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    bottomNavigationBar: NavigationBar(
      onDestinationSelected: (idx) => setState(() => this.idx = idx),
      selectedIndex: idx,
      destinations: screens.map((e) => NavigationDestination(
        selectedIcon: Icon(e.icon, fill: 1),
        icon: Icon(e.icon, weight: 600),
        label: e.label,
      )).toList(),
    ),
    body: SafeArea(child: screens[idx].destination),
  );
}
