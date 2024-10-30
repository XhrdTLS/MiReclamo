import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_reclamo/core/core.dart';

class AppTheme {
  static Color get lightGrey => const Color(0xFFBBBBBB);

  static Color get lightOrange => const Color(0xFFFFD6A5);
  static Color get darkOrange => const Color(0xFFA05B07);

  static Color get lightGreenCard => const Color(0xFFB3E6CC);
  static Color get darkGreenCard => const Color(0xFFB3E6CC);

  static Color get lightBlueCard => const Color(0xFFB8E8FC);
  static Color get darkBlueCard => const Color(0xFFB8E8FC);

  static Color get lightRed => const Color(0xFFFFBDBD);
  static Color get darkRed => const Color(0xFFFFBDBD);

  static ColorScheme get colorScheme => ColorScheme.fromSeed(
        seedColor: const Color(0xFF1D8E5C),
        primary: const Color(0xFF1D8E5C),
        secondary: const Color(0xFF06607A),
      );

  static ThemeData getTheme(BuildContext context) => ThemeData.light().copyWith(
        /// Esquema de colores
        colorScheme: colorScheme,
        canvasColor: colorScheme.secondaryContainer, 
        dividerColor: lightGrey,

        /// Fondo de la aplicación
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),

        /// Tema de la barra de navegación
        navigationBarTheme: NavigationBarTheme.of(context).copyWith(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
        ),

        /// Tema de texto
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
            .copyWith(
              headlineMedium: GoogleFonts.inter(
                  textStyle: StyleText.headline),
            )
            .apply(
              bodyColor: const Color(0xFF333333),
              displayColor: const Color(0xFF333333),
            ),
      );
}
