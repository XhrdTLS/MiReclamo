import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../core/core.dart';
import '../../../data/data_sources/google/google_service.dart';
import '../views.dart';

class LoginPage extends StatelessWidget {
  static final Logger _logger = Logger();

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> checkCondition() async {
    await GoogleService.logIn();
    return true; // Change this condition as needed
  }
    return Scaffold(
      appBar: const TopNavigation(titulo: "Iniciar Sesión"),
      body: FutureBuilder<bool>(
        future: GoogleService.logIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data == true) {
            // Navigate to the SecondScreen
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const BottomNavBar()),
              );
            });
          }
          return Center(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Column(
             children: [
               OutlinedButton(
                  onPressed: () {
                    GoogleService.logIn().then((result) {
                      if (result) {
                        _logger.i('Sesión Iniciada');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
               
                                ///Retorna a BottomNavBar ya que es un Scaffold, y ayuda con el manejo de rutas
                                builder: (context) => const BottomNavBar()));
                      } else {
                        _logger.e('Error al Iniciar Sesión');
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ErrorScreen();
                        }));
                      }
                    });
                  },
                  child: Row(
                    children: [ const Icon(AppIcons.profile), Text('Iniciar Sesión',style: StyleText.bodyBold)],
                  )),
             ],
           ),
        ),
      );
        },
      ),
    );
  }
}
