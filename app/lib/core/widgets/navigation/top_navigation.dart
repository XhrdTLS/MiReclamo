import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/widgets/styles/icons.dart';

class TopNavigation extends StatelessWidget implements PreferredSizeWidget {
  final String titulo;

  const TopNavigation({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20, // Ajusta el tamaño del texto si lo deseas
            ),
          ),
          // Aquí puedes agregar otros elementos como iconos o botones
          IconButton(
            icon: const Icon(AppIcons.add),
            onPressed: () {
              // Acción al presionar el icono de búsqueda
            },
          ),
        ],
      );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}