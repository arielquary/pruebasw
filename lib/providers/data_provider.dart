import 'dart:async';
import 'dart:convert';
import 'dart:io'; // Para los HttpHeaders
// import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'package:graphql/client.dart';
import 'package:plurione_app/config/app_config.dart';
import 'package:plurione_app/utils/utils.dart';
import 'package:flutter/foundation.dart';

/// Clase que maneja las operaciones de datos y comunicación con el servidor
class DataProvider {
  static const String _apikey = 'eyJhbGciOiJIUzI1NiJ9.eyJ0aWQiOjEwMTU5NjI0MiwidWlkIjo0Mjc0MDMsImlhZCI6IjIwMjEtMDMtMDJUMjI6MzY6MTkuMDAwWiIsInBlciI6Im1lOndyaXRlIiwiYWN0aWQiOjE2OTc0MCwicmduIjoidXNlMSJ9.rBEG4U1n_kQQq4riaRHPRrb8aVffzIMNGrNqLjzlOdo';
  static final HttpLink _httpLink = HttpLink('https://api.monday.com/v2/');
  static final AuthLink _authLink = AuthLink(getToken: () async => 'Bearer $_apikey');
  static final Link _link = _authLink.concat(_httpLink);
  final GraphQLClient _client = GraphQLClient(cache: GraphQLCache(), link: _link);

  /// Obtiene los datos de inicio de sesión del usuario
  Future<Map<String, dynamic>> getDatos(String usuario, String password) async {
    try {
      final parametros = ['token', 'nombre', 'numero_empleado', 'permisos', 'respuesta', 'hora_actual'];
      final queryParameters = {
        'u': usuario,
        'p': password,
      };
      final uri = Uri.https(AppConfig.urlBase, '${AppConfig.firstPart}/participantes/login.jsp', queryParameters);
      final resp = await http.get(uri, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      
      debugPrint('Respuesta del servidor: ${resp.body}');
      
      if (resp.statusCode != 200) {
        throw Exception('Error en la respuesta del servidor: ${resp.statusCode}');
      }
      
      // Limpiamos la respuesta eliminando comentarios y líneas vacías
      final cleanResponse = resp.body
          .split('\n')
          .where((line) => !line.trim().startsWith('//') && line.trim().isNotEmpty)
          .join('\n');
      
      final decodedData = json.decode(cleanResponse);
      debugPrint('Datos decodificados: $decodedData');
      
      final Map<String, dynamic> details = {};
      for (var element in parametros) {
        if (decodedData.containsKey(element)) {
          if (element == 'permisos') {
            // Limpiamos el campo permisos eliminando la coma al final
            details[element] = decodedData[element].toString().replaceAll(',', '');
          } else {
            details[element] = decodedData[element];
          }
        }
      }
      
      debugPrint('Mapa final: $details');
      return details;
    } catch (e) {
      debugPrint('Error en getDatos: $e');
      rethrow;
    }
  }

  /// Obtiene el resumen del estado de cuenta
  Future<Map<String, dynamic>> getResumenEstadoDeCuenta(String plan, String token) async {
    try {
      final queryParameters = {
        'token': token,
        'plan': plan,
      };
      final uri = Uri.https(AppConfig.urlBase, '${AppConfig.firstPart}/participantesReportes/reporte_edo_cuenta_ws.jsp', queryParameters);
      final resp = await http.get(uri, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      
      if (resp.statusCode != 200) {
        throw Exception('Error en la respuesta del servidor: ${resp.statusCode}');
      }
      debugPrint('resp.body: ${resp.body}	');
      return Map<String, dynamic>.from(obtenMapaResultadosComplejo(resp.body));
    } catch (e) {
      debugPrint('Error en getResumenEstadoDeCuenta: $e');
      rethrow;
    }
  }
  
  /// Obtiene el detalle de movimientos
  Future<Map<String, dynamic>> getDetalleMovimientos(String fechaInferior, String plan, String token) async {
    try {
      final queryParameters = {
        'fecha': fechaInferior,
        'token': token,
        'plan': plan,
      };
      final uri = Uri.https(AppConfig.urlBase, '${AppConfig.firstPart}/participantesReportes/reporte_detalle_movimientos.jsp', queryParameters);
      final resp = await http.get(uri, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      
      if (resp.statusCode != 200) {
        throw Exception('Error en la respuesta del servidor: ${resp.statusCode}');
      }
      debugPrint('getDetalleMovimientos: ${resp.body}');
      return Map<String, dynamic>.from(obtenMapaResultadosComplejo(resp.body));
    } catch (e) {
      debugPrint('Error en getDetalleMovimientos: $e');
      rethrow;
    }
  }

  /// Procesa y decodifica el resultado JSON complejo
  Map<String, dynamic> obtenMapaResultadosComplejo(String resultado) {
    try {
      return Map<String, dynamic>.from(json.decode(resultado));
    } catch (e) {
      debugPrint('Error al decodificar resultado complejo: $e');
      return {};
    }
  }
  
  /// Procesa y decodifica el resultado JSON con parámetros específicos
  Map<String, dynamic> obtenMapaResultados(String resultado, List<String> parametros) {
    try {
      final decodedData = json.decode(resultado);
      final Map<String, dynamic> details = {};
      for (var element in parametros) {
        details[element] = decodedData[element];
      }
      return details;
    } catch (e) {
      debugPrint('Error al decodificar resultado: $e');
      return {};
    }
  }

  /// Obtiene la fecha del servidor
  Future<Map<String, dynamic>> getFechaServidor() async {
    try {
      final parametros = ['hora_actual'];
      final uri = Uri.https(AppConfig.urlBase, '${AppConfig.firstPart}/participantes/timestamp.jsp');
      final resp = await http.get(uri, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
      
      if (resp.statusCode != 200) {
        throw Exception('Error en la respuesta del servidor: ${resp.statusCode}');
      }
      
      return Map<String, dynamic>.from(obtenMapaResultados(resp.body, parametros));
    } catch (e) {
      debugPrint('Error en getFechaServidor: $e');
      rethrow;
    }
  }

  static const String valorToken = r'''
query {
  items_by_column_values(board_id: 587664471, column_id: "estado", column_value: "Activo") {
    column_values {
      id
      title
      value
    }
  }
}''';

  bool _cargando = false;

  /// Obtiene el token de autenticación
  Future<String> getToken() async {
    if (_cargando) return '';
    
    try {
      _cargando = true;
      final qry = generarConsulta(valorToken, 0, 0);
      final resp = await consulta(qry, true);
      return resp;
    } catch (e) {
      debugPrint('Error al obtener token: $e');
      return '';
    } finally {
      _cargando = false;
    }
  }

  /// Genera la consulta con los parámetros especificados
  String generarConsulta(String query, int pagina, int tamPagina) {
    return query
        .replaceAll(">>>", pagina.toString())
        .replaceAll("+++", tamPagina.toString());
  }

  /// Ejecuta una consulta GraphQL
  Future<String> consulta(String query, bool esItemByColumnValue) async {
    try {
      final QueryOptions options = QueryOptions(document: gql(query));
      final QueryResult result = await _client.query(options);
      
      if (result.hasException) {
        debugPrint('Error en consulta GraphQL: ${result.exception}');
        return '';
      }

      final data = result.data;
      if (data == null) return '';
      
      final resultado = esItemByColumnValue 
          ? data['items_by_column_values'] 
          : data['boards']?[0]?['items'];
          
      if (resultado == null) return '';
      
      for (var item in resultado) {
        final valor = item['column_values'];
        for (var item1 in valor) {
          if (item1['title'] == 'Token') {
            return Utils().reemplazaComillas(item1['value']);
          }
        }
      }
      
      return '';
    } catch (e) {
      debugPrint('Error en consulta: $e');
      return '';
    }
  }
}