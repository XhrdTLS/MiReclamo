import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';

Color getTipoColor(BuildContext context, String tipo) {
  final brightness = Theme.of(context).brightness;
  Color tipoColor;
  switch (tipo) {
    case 'CLAIM':
      tipoColor = brightness == Brightness.light
          ? AppTheme.lightOrange
          : AppTheme.darkOrange;
      break;
    case 'SUGGESTION':
      tipoColor = brightness == Brightness.light
          ? AppTheme.lightGreen
          : AppTheme.darkGreen;
      break;
    case 'INFORMATION':
      tipoColor = brightness == Brightness.light
          ? AppTheme.lightBlue
          : AppTheme.darkBlue;
      break;
    default:
      tipoColor = AppTheme.lightGray;
  }
  return tipoColor;
}

Color getTipoTextColor(String tipo) {
  Color tipoTextColor;
  switch (tipo) {
    case 'CLAIM':
      tipoTextColor = AppTheme.darkOrange;
      break;
    case 'SUGGESTION':
      tipoTextColor = AppTheme.darkGreen;
      break;
    case 'INFORMATION':
      tipoTextColor = AppTheme.darkBlue;
      break;
    default:
      tipoTextColor = AppTheme.lightGray;
  }
  return tipoTextColor;
}

IconData getTipoIcon(String tipo) {
  switch (tipo) {
    case 'CLAIM':
      return AppIcons.claim;
    case 'SUGGESTION':
      return AppIcons.sugestion;
    case 'INFORMATION':
      return AppIcons.info;
    default:
      return AppIcons.question;
  }
}