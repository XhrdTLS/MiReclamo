import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class testService {
  static const String _baseUrl = 'https://api.sebastian.cl/oirs-utem';
  static const String _var1 = "application/json";
  static final Logger _logger = Logger();

  static Future<List<dynamic>> getTest(String jwt, Map<String, dynamic> requestBody) async {
    Uri _url = Uri.parse('$_baseUrl/v1/info/types');
    Map<String, String> _headers = {
      'accept': _var1,
      'Content-Type': _var1,
      'Authorization': "Bearer $jwt"
    };

    try {
      final response = await http.get(_url, headers: _headers);
      _logger.d(jsonDecode(response.body));
      return [];
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      return [];
    }
  }

}