import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mi_reclamo/core/widgets/icons.dart';
import 'package:mi_reclamo/core/widgets/navigation/navigation.dart';
import 'package:mi_reclamo/features/presentation/pages/views.dart';

/* class FooterApp extends StatelessWidget {
  static final Logger _logger = Logger();
  const FooterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                _logger.i('Home');
              },
              child: const Text('Home'),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotasPage()),
              );
              _logger.i('Notas');
            },
            child: const Text('Notas'),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TestScreen()),
              );
              _logger.i('Test');
            },
            child: const Text('Test'),

          ),
        ],
      ),
    );
  }
} */

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int idx = 0;
  final List<NavigationItem> screens = [
    NavigationItem(destination: const HomePage(), label: "Inicio", icon: AppIcons.home),
    NavigationItem(destination: const NotasPage(), label: "Asignaturas", icon: AppIcons.subjects),
    NavigationItem(destination: TestScreen(), label: "Apuntes", icon: AppIcons.notes),
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
