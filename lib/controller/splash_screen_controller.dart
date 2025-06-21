import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plurione_app/providers/data_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plurione_app/models/sesion.dart';
import 'package:plurione_app/utils/utilidades.dart';
import 'package:plurione_app/models/usuario.dart';
import 'package:plurione_app/models/cliente_evento_curso.dart';
import 'package:plurione_app/utils/imagenes.dart';
import 'package:plurione_app/utils/colores.dart' as app_colors;

class SplashScreenController extends GetxController {
  static SplashScreenController get to => Get.find();

  final dataProvider =  DataProvider();
  int horaServidor = 0;

  Future<SharedPreferences>  leeSharedPreferences() async {
    Sesion.miSesion.prefs = await SharedPreferences.getInstance();
    horaServidor = await obtenHoraServidor(Sesion.miSesion.prefs);
    return Sesion.miSesion.prefs;
  }

  Future<int> obtenHoraServidor(SharedPreferences p) async {
    int hs=0;
    await dataProvider.getFechaServidor().then((result) { 
      if(result['hora_actual']!=null){
        hs = int.parse(result['hora_actual']);
      }
    });
    return hs;
  }

  RxInt currentIndex = 0.obs;
  Usuario? usuario;
  ClienteEventoCurso? clienteEventoCurso;

  @override
  void onInit() async {
    super.onInit();
    Utilidades utils = Utilidades();
    if (utils.containsKeyFromDevice('usuario')) {
      usuario = Usuario.fromJson(utils.readKeyFromDevice('usuario'));
      Sesion.miSesion.usuario = usuario;
      clienteEventoCurso = null;
      Sesion.miSesion.clienteEventoCurso = clienteEventoCurso;
      Imagenes.imagenEmpresa = '${usuario!.name}Blanca.png';
      Imagenes.imagenEmpresaColor = '${usuario!.name}Color.png';
      Imagenes.colorFondo = app_colors.AppColors().obtenColor(utils.readKeyFromDevice('colorFondo'));
    } else if (utils.containsKeyFromDevice('clienteEventoCurso')) {
      clienteEventoCurso = ClienteEventoCurso.fromJson(utils.readKeyFromDevice('clienteEventoCurso'));
      Sesion.miSesion.clienteEventoCurso = clienteEventoCurso;
      Sesion.miSesion.usuario = null;
      Imagenes.imagenEmpresa = '${clienteEventoCurso!.name}Blanca.png';
      Imagenes.imagenEmpresaColor = '${clienteEventoCurso!.name}Color.png';
      Imagenes.colorFondo = app_colors.AppColors().obtenColor(utils.readKeyFromDevice('colorFondo'));
    } else {
      Sesion.miSesion.usuario = null;
      Sesion.miSesion.clienteEventoCurso = null;
      Imagenes.imagenEmpresa = 'DEVELOPBlanco.png';
      Imagenes.imagenEmpresaColor = 'DEVELOP.png';
      Imagenes.colorFondo = const Color(0xFF1565C0);
    }
  }

  obtenSiguientePagina() {
    if (Sesion.miSesion.usuario != null || Sesion.miSesion.clienteEventoCurso != null) {
      return 'entrarrostrocontrasenia';
    } else {
      return 'entracontrasenia';
    }
  }
}