import 'package:cm/core/widgets/barra_app.dart';
import 'package:cm/core/widgets/footer_app.dart';
import 'package:cm/core/widgets/menu_app.dart';
import 'package:cm/features/presentation/controllers/test/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:cm/features/data/data_sources/api_seba/testService.dart';

class TestScreen extends StatelessWidget {
  final TestViewModel _testViewModel = TestViewModel();
  static final Logger _logger = Logger();
  final TestService _testService = TestService();

  TestScreen({super.key});

  Future<void> _fetchTest() async {
    Map<String, dynamic> requestBody = {};
    try {
      List<dynamic> response = await _testService.getTest(requestBody);
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
          ],
        ),
      ),
      bottomNavigationBar: const FooterApp(),
    );
  }
}