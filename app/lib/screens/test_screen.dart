import 'package:cm/widgets/barra_app.dart';
import 'package:cm/widgets/footer_app.dart';
import 'package:cm/widgets/menu_app.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:cm/services/storage_service.dart';
import 'package:cm/services/testService.dart';

class TestScreen extends StatelessWidget {
  static final Logger _logger = Logger();

  const TestScreen({super.key});

  Future<void> _fetchTest() async {
    String jwt = await StorageService.getValue('idToken');
    Map<String, dynamic> requestBody = {}; // Define your request body here
    try {
      List<dynamic> response = await testService.getTest(jwt, requestBody);
      _logger.i('Response: $response');
    } catch (error) {
      _logger.e('Error fetching test: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraApp(titulo: 'Test'),
      drawer: const MenuApp(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _fetchTest,
              child: const Text('Fetch Test Data'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FooterApp(),
    );
  }
}