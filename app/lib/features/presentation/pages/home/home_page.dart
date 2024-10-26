


import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'package:cm/core/core.dart';

class HomePage extends StatelessWidget {
  static final Logger _logger = Logger();
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Home Page'),
      ),
      bottomNavigationBar: const FooterApp(),
    );
  }
}