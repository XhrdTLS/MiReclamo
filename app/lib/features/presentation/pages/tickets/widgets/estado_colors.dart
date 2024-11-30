import 'package:flutter/material.dart';
import 'package:mi_reclamo/core/core.dart';

Color getEstadoColor(String estado) {
  switch (estado) {
    case 'ERROR' || 'REJECTED' || 'CANCELLED':
      return AppTheme.lightRed;
    case 'RESOLVED' || 'CLOSED':
      return AppTheme.lightGreen;
    default:
      return AppTheme.lightStone;
  }
}

Color getEstadoTextColor(String estado) {
  switch (estado) {
    case 'ERROR' || 'REJECTED' || 'CANCELLED':
      return AppTheme.darkRed;
    case 'RESOLVED' || 'CLOSED':
      return AppTheme.darkGreen;
    default:
      return AppTheme.darkGray;
  }
}