import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/widgets/navigation/top_navigation.dart';
import 'package:mi_reclamo/features/presentation/controllers/test/InfoController.dart';

class ReclamosPage extends StatelessWidget {
  final infoController _testViewModel = infoController();

  ReclamosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Solicitudes", isMainScreen: false),
      body: FutureBuilder(
        future: _testViewModel.fetchReclamos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return Container(); // Return an empty container if no reclamos
          } else {
            final reclamos = snapshot.data as List;
            return ListView.builder(
              itemCount: reclamos.length,
              itemBuilder: (context, index) {
                final reclamo = reclamos[index];
                return Card(
                  child: ListTile(
                    title: Text(reclamo['subject'] ?? 'No Subject'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type: ${reclamo['type'] ?? 'No Type'}'),
                        Text('Message: ${reclamo['message'] ?? 'No Message'}'),
                        Text('Category: ${reclamo['category']?['name'] ?? 'No Category'}'),
                        Text('Category Description: ${reclamo['category']?['description'] ?? 'No Description'}'),
                        Text('Token: ${reclamo['token'] ?? 'No Token'}'),
                        Text('Status: ${reclamo['status'] ?? 'No Status'}'),
                        Text('Created: ${reclamo['created'] ?? 'No Created Date'}'),
                        Text('Updated: ${reclamo['updated'] ?? 'No Updated Date'}'),
                      ],
                    ),
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