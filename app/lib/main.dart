import 'package:flutter/material.dart';
import 'package:mi_reclamo/features/presentation/pages/login/login_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Reclamo UTEM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1D8E5C)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
