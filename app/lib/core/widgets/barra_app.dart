import 'package:flutter/material.dart';

class BarraApp extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const BarraApp({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle:
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      backgroundColor: Colors.deepOrangeAccent,
      title: Text(titulo),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
