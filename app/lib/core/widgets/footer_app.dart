import 'package:cm/features/presentation/pages/test/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:cm/features/presentation/pages/views.dart';

class FooterApp extends StatelessWidget {
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
}