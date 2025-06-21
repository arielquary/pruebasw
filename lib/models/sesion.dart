import 'package:shared_preferences/shared_preferences.dart';
import 'package:plurione_app/models/usuario.dart';
import 'package:plurione_app/models/cliente_evento_curso.dart';

class Sesion {

  Sesion._privateConstructor();

  static final Sesion miSesion = Sesion._privateConstructor();

  late SharedPreferences prefs;
  late  Map<String, dynamic> sharedPrefs;
  late int horaServidor;
  Usuario? usuario;
  ClienteEventoCurso? clienteEventoCurso;
  String token = '';

}