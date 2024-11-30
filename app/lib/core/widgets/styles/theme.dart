import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_reclamo/core/core.dart';

class AppTheme {
  static Color get lightStone => const Color(0xFFDDDDDD);

  static Color get lightGray => const Color(0xFFBBBBBB);
  static Color get darkGray => const Color(0xFF333333);

  static Color get lightOrange => const Color(0xFFFFD6A5);
  static Color get darkOrange => const Color(0xFFA05B07);

  static Color get lightGreen => const Color(0xFFC7E9B0);
  static Color get darkGreen => const Color(0xFF3A7E0B);

  static Color get lightBlue => const Color(0xFFB6E0F7);
  static Color get darkBlue => const Color.fromARGB(255, 12, 61, 82);

  static Color get lightRed => const Color(0xFFFFBDBD);
  static Color get darkRed => const Color(0xFF490C0C);

  static ColorScheme get colorScheme => ColorScheme.fromSeed(
        seedColor: const Color(0xFF1D8E5C),
        primary: const Color(0xFF1D8E5C),
      );

  static ThemeData getLight(BuildContext context) => ThemeData.light().copyWith(
        /// Esquema de colores
        colorScheme: colorScheme,
        canvasColor: colorScheme.secondaryContainer,
        dividerColor: lightGray,

        /// Fondo de la aplicación
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),

        /// Tema de la Appbar
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          elevation: 0,
        ),

        /// Tema de la barra de navegación
        navigationBarTheme: NavigationBarTheme.of(context).copyWith(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
        ),

        /// Tema de texto
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
            .copyWith(
              headlineMedium: GoogleFonts.inter(textStyle: StyleText.headline),
            )
            .apply(
              bodyColor: const Color(0xFF333333),
              displayColor: const Color(0xFF333333),
            ),
      );
  static ThemeData getDark(BuildContext context) => ThemeData.dark().copyWith(
        /// Esquema de colores
        colorScheme: colorScheme,
        canvasColor: colorScheme.secondaryContainer,
        dividerColor: lightGray,

        /// Fondo de la aplicación
        scaffoldBackgroundColor: const Color(0xFF171918),

        /// Tema de la Appbar
        appBarTheme: AppBarTheme.of(context).copyWith(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.black,
          elevation: 0,
        ),

        /// Tema de la barra de navegación
        navigationBarTheme: NavigationBarTheme.of(context).copyWith(
          backgroundColor: const Color(0xFF000000),
          elevation: 0,
        ),

        /// Tema de texto
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)
            .copyWith(
              headlineLarge: GoogleFonts.inter(textStyle: StyleText.headline),
            )
            .apply(
              bodyColor: const Color(0xFFFAFAFA),
              displayColor: const Color(0xFFFAFAFA),
            ),
      );

  static of(BuildContext context) {}
}
