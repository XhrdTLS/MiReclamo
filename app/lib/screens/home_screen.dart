import 'package:cm/widgets/barra_app.dart';
import 'package:cm/widgets/footer_app.dart';
import 'package:cm/widgets/menu_app.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class HomeScreen extends StatelessWidget {
  static final Logger _logger = Logger();

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: BarraApp(titulo: 'Inicio'),
        drawer: MenuApp(),
        body: Center(child: Text('Estoy dentro')),
        bottomNavigationBar:  FooterApp()
    );

  }
}
