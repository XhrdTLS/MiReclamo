import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/widgets/styles/icons.dart';
import 'package:mi_reclamo/core/widgets/navigation/navigation.dart';
import 'package:mi_reclamo/features/presentation/pages/views.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with SingleTickerProviderStateMixin {

  int idx = 0;
late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  final List<NavigationItem> screens = [
    NavigationItem(destination: const HomePage(), label: "Inicio", icon: AppIcons.home),
    NavigationItem(destination: const TicketsPage(), label: "Solicitudes", icon: AppIcons.ticket),
    NavigationItem(destination: const NotasPage(), label: "Notas", icon: AppIcons.notes),
    NavigationItem(destination: const ProfilePage(), label: "Perfil", icon: AppIcons.profile),
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuart,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    body: SafeArea(
      child: SlideTransition(
        position: _slideAnimation,
        child: screens[idx].destination,
      ),
    ),
  );
}
