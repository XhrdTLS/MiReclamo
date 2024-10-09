import 'package:cm/screens/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../screens/home_screen.dart';
import '../features/Notes/screens/notas_screen.dart';

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
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
                _logger.i('Home');
              },
              child: const Text('Home'),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotasScreen()),
              );
              _logger.i('Notas');
            },
            child: const Text('Notas'),
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TestScreen()),
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