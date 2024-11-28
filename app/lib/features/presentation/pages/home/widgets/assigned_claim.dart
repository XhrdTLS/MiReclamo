import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/exception/exception_handler.dart';
import 'package:mi_reclamo/core/widgets/styles/icons.dart';

class AssignedClaim extends StatelessWidget {
  const AssignedClaim({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(child: Icon(AppIcons.info)),
      title: const Text("Reclamo"),
      subtitle: const Text("Descripción del reclamo"),
      trailing: const Icon(AppIcons.dropdown),
      onTap: () {
        ExceptionHandler.handleException('Error de prueba');
      },
    );
  }
}