<<<<<<< Updated upstream
import 'package:mi_reclamo/features/presentation/controllers/test/InfoController.dart';
=======
import 'package:mi_reclamo/core/widgets/navigation/top_navigation.dart';
import 'package:mi_reclamo/features/presentation/controllers/test/test_controller.dart';
>>>>>>> Stashed changes
import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/presentation/pages/views.dart';

class TicketsPage extends StatelessWidget {
  final infoController _testViewModel = infoController();


  TicketsPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TopNavigation(
          title: "Solicitudes Pendientes",
          isMainScreen: true,
        ),
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
            ElevatedButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ReclamosPage())), child: const Text('Ir a Reclamos Page'),)
          ],
        ),
      );
  }
}