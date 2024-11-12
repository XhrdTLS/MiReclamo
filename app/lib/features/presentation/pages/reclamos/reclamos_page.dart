
import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/presentation/controllers/test/test_controller.dart';

class ReclamosPage extends StatelessWidget {
  final TestViewModel _testViewModel = TestViewModel();

  ReclamosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reclamos'),
      ),
      body: FutureBuilder(
        future: _testViewModel.fetchReclamos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No reclamos found'));
          } else {
            final reclamos = snapshot.data as List;
            return ListView.builder(
              itemCount: reclamos.length,
              itemBuilder: (context, index) {
                final reclamo = reclamos[index];
                return Card(
                  child: ListTile(
                    title: Text(reclamo['nombre']),
                    subtitle: Text(reclamo['descripcion']),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}