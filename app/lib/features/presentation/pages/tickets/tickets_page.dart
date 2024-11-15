import 'package:mi_reclamo/core/widgets/navigation/top_navigation.dart';
import 'package:mi_reclamo/features/presentation/controllers/test/InfoController.dart';
import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/presentation/controllers/test/icsoController.dart';
import 'package:mi_reclamo/features/presentation/pages/views.dart';

class TicketsPage extends StatelessWidget {
  final infoController _testViewModel = infoController();
  final IcsoController _icsoController = IcsoController();

  TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Prueba de Solicitudes", isMainScreen: true),
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
              child: const Text('Fetch Status Data'),
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
              onPressed: _icsoController.fetchAll,
              child: const Text('Logger all'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ReclamosPage()),
              ),
              child: const Text('Ver Reclamos'),
            ),
          ],
        ),
      ),
    );
  }
}
