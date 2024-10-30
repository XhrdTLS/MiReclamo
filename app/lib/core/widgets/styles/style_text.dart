import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StyleText {
///Titulos y Textos grandes y cortos
  static TextStyle headline = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    letterSpacing: 0,
    height: 1.2,
  );

  //Titulos y encabezados de secciones
  static TextStyle headlineSmall = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );
  
//Titulos y encabezados de secciones
  static TextStyle header = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );

///Titulos de Secciones y tarjetas
  static TextStyle label = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

///Textos importantes o Relevantes cortos
  static TextStyle descriptionBold = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

///Textos de las descripciones
  static TextStyle description = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.2,
  );

///Parrafos y textos largos
  static TextStyle bodyBold = GoogleFonts.roboto(
    
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

///Parrafos y textos largos
  static TextStyle body = GoogleFonts.roboto( 
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}