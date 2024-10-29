
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mi_reclamo/core/widgets/icons.dart';

import '../../../../core/core.dart';
import '../../../data/data_sources/google/google_service.dart';
import '../views.dart';

class LoginPage extends StatelessWidget {
  static final Logger _logger = Logger();

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraApp(titulo: 'Página de Login'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: ElevatedButton(
              onPressed: () {
                GoogleService.logIn().then((result) {
                  if (result) {
                    _logger.i('Sesión Iniciada');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomNavBar()));
                  } else {
                    _logger.e('PROBLEMA con Login');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return const ErrorScreen();
                        }));
                  }
                });
              },
              child: const Row(
                children: [Icon(AppIcons.profile), Text('Login')],
              )),
        ),
      ),
    );
  }
}
