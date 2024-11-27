import 'package:mi_reclamo/core/globals.dart';
import 'package:mi_reclamo/core/widgets/navigation/top_navigation.dart';
import 'package:mi_reclamo/features/presentation/controllers/test/InfoController.dart';
import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/presentation/controllers/ticket/icsoController.dart';
import 'package:mi_reclamo/features/presentation/pages/views.dart';

class TestPage extends StatelessWidget {
  final infoController _testViewModel = infoController();
  final IcsoController _icsoController = IcsoController();


  TestPage({super.key});

  Future<void> _initializeTickets() async {
    await initializeTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Todas las Solicitudes", isMainScreen: false),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _testViewModel.fetchTypes,
              child: const Text('Fetch Types Data'),
            ),
            ElevatedButton(
              onPressed: _testViewModel.fetchStatus,
              child:  const Text('Fetch Status Data'),
            ),
            ElevatedButton(
              onPressed: _testViewModel.fetchCategories,
              child: const Text('Fetch Categories Data'),
            ),
            ElevatedButton(
              onPressed: _testViewModel.fetchAccess,
              child: const Text('Fetch Access Data'),
            ),
            ElevatedButton(
              onPressed: _icsoController.fetchAll,
              child: const Text('Logger all tokens'),
            ),
            ElevatedButton(
              onPressed: _initializeTickets,
              child: const Text('Initialize Tickets'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketsPage()),
              ),
              child: const Text('Ir a Reclamos Page'),
            ),
          ],
        ),
      ),
    );
  }
}