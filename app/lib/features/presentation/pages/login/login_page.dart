import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../../core/core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../data/data_sources/google/google_service.dart';

class LoginPage extends StatelessWidget {
  static final Logger _logger = Logger();

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: "Iniciar Sesión", isMainScreen: true),
      body: FutureBuilder<bool>(
        future: GoogleService.logIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100, 
                    child: SvgPicture.asset(
                      'assets/logo-app.svg',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Validando inicio de sesión...',
                    style: StyleText.headlineSmall,
                  ),
                  const SizedBox(height: 32),
                  const CircularProgressIndicator(),
                ],
              ),
            );
          } else if (snapshot.hasData && snapshot.data == true) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const BottomNavBar()),
              );
            });
          } else if (snapshot.hasError) {
            _logger.e('Error al Iniciar Sesión');
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Row(
                  children: [
                    Icon(AppIcons.claim, weight: 700, color: Colors.white),
                    SizedBox(width: 10),
                    Text('Error al Iniciar Sesión, por favor intenta de nuevo'),
                  ],
                ),
                duration: Duration(seconds: 5),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(100.0),
            child: Column(
              children: [
                OutlinedButton(
                    onPressed: () {
                      GoogleService.logIn().then((result) {
                        if (!context.mounted) {
                          return;
                        }

                        if (result) {
                          _logger.i('Sesión Iniciada');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomNavBar()));
                        } else {
                          _logger.e('Error al Iniciar Sesión');
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Row(
                                children: [
                                  Icon(AppIcons.claim,
                                      weight: 700, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                      'Error al Iniciar Sesión, por favor intenta de nuevo'),
                                ],
                              ),
                              duration: Duration(seconds: 5),
                            ),
                          );
                        }
                      });
                    },
                    child: Row(
                      children: [
                        const Icon(AppIcons.profile),
                        Text('Iniciar Sesión', style: StyleText.bodyBold)
                      ],
                    )),
              ],
            ),
          );
        },
      ),
    );
  }
}
