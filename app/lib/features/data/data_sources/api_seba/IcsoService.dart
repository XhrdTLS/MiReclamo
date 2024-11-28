import 'dart:convert';

import 'package:mi_reclamo/features/data/data_sources/api_seba/InfoService.dart';
import 'package:mi_reclamo/features/data/data_sources/api_seba/baseService.dart';
import 'package:logger/logger.dart';
import 'package:mi_reclamo/features/domain/entities/ticket_entity.dart';

class IcsoService extends BaseService {
  final Logger _logger = Logger();
  final InfoService _infoService = InfoService();

  /// url
  /// {{baseUrl}}/v1/icso
  String get url => '/v1/icso';
  String get attatchmentUrl => '/v1/attachments';
  String get responseUrl => '/v1/response';

  /// Obtiene todos los tickets de una categoría
  ///
  Future<List<dynamic>> getAllTokenByCategory(
      Map<String, dynamic> headers) async {
    final categoryToken = headers['categoryToken'];
    try {
      final response = await get('$url/$categoryToken/tickets');
      _logger.d(json.decode(utf8.decode(response.bodyBytes)));
      final List<dynamic> types = json.decode(utf8.decode(response.bodyBytes));
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }

  /// Crea un nuevo ticket
  /// {{baseUrl}}/v1/icso/:categoryToken/ticket
  /// todo verificar si funciona este post, el baseurl lo cree recien
  Future<Map<String, dynamic>> createTicket(
      Map<String, dynamic> headers, Map<String, dynamic> requestBody) async {
    final categoryToken = headers['categoryToken'];
    try {
      final response = await post('$url/$categoryToken/ticket', requestBody);
      _logger.d(json.decode(utf8.decode(response.bodyBytes)));
      final Map<String, dynamic> types =
          json.decode(utf8.decode(response.bodyBytes));
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }

  /// Obtiene un ticket por token
  /// {{baseUrl}}/v1/icso/:ticketToken/ticket
  ///
  Future<Map<String, dynamic>> getTicketByToken(
      String headers) async {
    try {
      final response = await get('$url/$headers/ticket');
      // _logger.d(json.decode(utf8.decode(response.bodyBytes)));
      final Map<String, dynamic> types =
          json.decode(utf8.decode(response.bodyBytes));
      return types;
    } catch (error) {
      // _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }

  /// Actualiza un ticket existente
  /// {{baseUrl}}/v1/icso/:ticketToken/ticket
  /// todo probar
  Future<Map<String, dynamic>> updateTicket(
      Map<String, dynamic> headers, Map<String, dynamic> requestBody) async {
    final ticketToken = headers['ticketToken'];
    try {
      final response = await post('$url/$ticketToken/ticket', requestBody);
      _logger.d(json.decode(utf8.decode(response.bodyBytes)));
      final Map<String, dynamic> types =
          json.decode(utf8.decode(response.bodyBytes));
      return types;
    } catch (error) {
      _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }

  /// UPDATE TICKET ADMIN
  Future<Map<String, dynamic>> responseTicket(Ticket update) async {
    final ticketToken = update.token;
    // final requestBody = jsonEncode({
    //   "status": update.status.name,
    //   "response": update.response,
    // });
    Map<String, dynamic> requestBody = {
      "status": update.status.name,
      "response": update.response,
    };
    try {
      final response = await put('$responseUrl/$ticketToken/ticket', requestBody);
      // _logger.d(json.decode(utf8.decode(response.bodyBytes)));
      final Map<String, dynamic> types = json.decode(utf8.decode(response.bodyBytes));
      return types;
    } catch (error) {
      // _logger.e('Error al obtener los datos: $error');
      throw Exception('Failed to fetch Tokens by category: $error');
    }
  }

  /// Elimina un ticket
  /// {{baseUrl}}/v1/icso/:ticketToken/ticket
  Future<void> deleteTicket(
    String ticketToken) async {
  try {
    delete('$url/$ticketToken/ticket');
  } catch (error) {
    _logger.e('Error al obtener los datos: $error');
    throw Exception('Failed to fetch Tokens by category: $error');
  }
}

  /// Obtiene todos los tickets
  ///
  // Future<List<Ticket>> getAllTickets() async {
  //   /// Definimos algunos datos a utilizar
  //   List<dynamic> categories = await _infoService.getCategory();
  //   Set<String> ticket = {};
  //   List<Ticket> responses = [];
  //     for (var category in categories) {
  //       ticket.add(category['token']);
  //     }
  //   /// Hacemos llamadas al endpoint por cada token
  //   for(var token in ticket){
  //     try {
  //       final response = await get('$url/$token/tickets?type=&status=');
  //       if (response.statusCode == 200) {
  //         final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
  //         if (decodedResponse is List) {
  //           for (var item in decodedResponse) {
  //             responses.add(Ticket.fromJson(item));
  //           }
  //         } else if (decodedResponse is Map) {
  //           responses
  //               .add(Ticket.fromJson(decodedResponse as Map<String, dynamic>));
  //         }
  //       }
  //     } catch (error) {
  //       _logger.e('Error al obtener los datos: $error');
  //       throw Exception('Failed to fetch all tokens: $error');
  //     }
  //   }
  //   return responses;
  // }


  Future<List<Ticket>> getAllTickets() async {
    /// Definimos algunos datos a utilizar
    List<dynamic> categories = await _infoService.getCategory();
    Set<String> tokens = {};
    List<Ticket> responses = [];

    for (var category in categories) {
      tokens.add(category['token']);
    }

    /// Hacemos llamadas al endpoint por cada token usando ForkJoin
    List<Future> futures = tokens.map((token) async {
      try {
        final response = await get('$url/$token/tickets?type=&status=');
        if (response.statusCode == 200) {
          final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
          if (decodedResponse is List) {
            for (var item in decodedResponse) {
              responses.add(Ticket.fromJson(item));
            }
          } else if (decodedResponse is Map) {
            responses.add(Ticket.fromJson(decodedResponse as Map<String, dynamic>));
          }
        }
      } catch (error) {
        _logger.e('Error al obtener los datos: $error');
        throw Exception('Failed to fetch all tokens: $error');
      }
    }).toList();

    await Future.wait(futures);
    return responses;
  }

  Future<List<Ticket>> getAll() async {
    /// Definimos algunos datos a utilizar
    List<dynamic> categories = await _infoService.getCategory();
    Set<String> tokens = {};
    List<Ticket> responses = [];

    _logger.d('Categories fetched: $categories');

    for (var category in categories) {
      tokens.add(category['token']);
    }

    _logger.d('Tokens extracted: $tokens');

    /// Hacemos llamadas al endpoint por cada token
    for (var token in tokens) {
      try {
        final response = await get('$url/$token/tickets?type=&status=');
        _logger.d('Response for token $token: ${response.statusCode}');

        if (response.statusCode == 200) {
          final decodedResponse = json.decode(utf8.decode(response.bodyBytes));
          _logger.d('Decoded response for token $token: $decodedResponse');

          if (decodedResponse is List) {
            for (var item in decodedResponse) {
              responses.add(Ticket.fromJson(item));
            }
          } else if (decodedResponse is Map) {
            responses
                .add(Ticket.fromJson(decodedResponse as Map<String, dynamic>));
          }
        } else {
          _logger.e(
              'Failed to fetch tickets for token $token: ${response.statusCode}');
        }
      } catch (error) {
        _logger.e('Error al obtener los datos para token $token: $error');
        throw Exception('Failed to fetch all tokens: $error');
      }
    }

    _logger.d('Total tickets fetched: ${responses.length}');
    return responses;
  }

  /// ATATCHTMENT
  Future<Map<String,dynamic>> fetchAttachedFile(String token, String attachedTokens) async {
    try {
      final response = await get('$attatchmentUrl/$token/$attachedTokens');
      _logger.d(json.decode(utf8.decode(response.bodyBytes)));
      final Map<String, dynamic> files = json.decode(utf8.decode(response.bodyBytes));
      return files;
    } catch (error) {
      _logger.e('Error al obtener los objetos: $error');
      throw Exception('Failed to get attatchment: $error');
    }
  }

  /*
  import 'dart:convert';
import 'dart:io';

void saveFileFromJson(Map<String, dynamic> fileJson) async {
  try {
    // Extraer los datos del JSON
    final String fileName = fileJson['name'];
    final String mimeType = fileJson['mime']; // No se usa directamente aquí, pero puedes verificar el tipo.
    final String base64Data = fileJson['data'];

    // Decodificar los datos Base64
    final List<int> fileBytes = base64Decode(base64Data);

    // Obtener el directorio donde guardar el archivo
    final String directory = Directory.systemTemp.path; // Puedes cambiar esto a otro directorio adecuado
    final String filePath = '$directory/$fileName';

    // Crear y guardar el archivo
    final File file = File(filePath);
    await file.writeAsBytes(fileBytes);

    print('Archivo guardado en: $filePath');
  } catch (e) {
    print('Error al guardar el archivo: $e');
  }
}

void main() {
  // Ejemplo del JSON recibido
  final Map<String, dynamic> fileJson = {
    "name": "q5mTmO78CylE30LlX-vhmpZuuCoSMvP7mONP5gLIgKig3i5.jpg",
    "mime": "image/jpeg",
    "data":
        "/9j/4aRoRXhpZgAASUkqAAgAAAAMAAABBAABAAAAwA8AAAEBBAABAAAA0AsAAA8BAgAIAAAAngAAABABAgAJAAAApgAAABIBAwABAAAABgAAABoBBQABAAAAsAAAABsBBQABAAAAuAAAACgBAwABAAAAAgAAADEBAgAOAAAAwAAAADIBAgAUAAAAzgAAABMCAwABAAAAAQAAAGmHBAABAAAA4gAAAMgCAABzYW1zdW5nAFNNLUc5OTZCAABIAAAAAQAAAEgAAAABAAAARzk5NkJYWFVDR1hINQAyMDI0OjEwOjI1IDIyOjIzOjE5AB0AmoIFAAEAAABEAgAAnYIFAnn60o7kqR0yM8c5PHoOKMde+AR/wACx3FF13Cz7P7hD1GMAkckZ3EDt+WaO3U9eCv9aUcc/KGHB"
  };

  // Llamar a la función para guardar el archivo
  saveFileFromJson(fileJson);
}

   */


  }
