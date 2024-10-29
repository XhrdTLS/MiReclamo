import 'package:flutter/material.dart';

import 'package:mi_reclamo/core/core.dart';

class HomePage extends StatelessWidget {
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}