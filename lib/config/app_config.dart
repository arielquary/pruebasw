import 'package:flutter/material.dart';

class AppConfig {

  // static const String urlBase = 'cloudvitalis.mx';
  // static const String firstPart = '/sistemaIndividualizador';

  static const String urlBase = 'corporativo-ag.plurione.com.mx';
  static const String firstPart = '/sistemaFondos';

    // Valores por defecto
  // static const String defaultUser = 'CARDENAS71286A';
  // static const String defaultPassword = '15228299';
  // static const String defaultUser = 'GARDUNO47546O';
  // static const String defaultPassword = '17600547';

  static const String defaultUser = '';
  static const String defaultPassword = '';


  // Colores
  static const Color inputFillColor = Color.fromRGBO(0xE2, 0xED, 0xF8, 1.0);
  static const MaterialColor primaryColor = Colors.blueGrey;
  static const Color textColor = Colors.white70;
  static const Color errorColor = Colors.redAccent;

  // Imágenes
  static const String logoPath = 'lib/assets/images/logoAG2.png';

  // Configuración de Wave
  static const List<List<Color>> waveGradients = [
    [Colors.white30, inputFillColor],
    [inputFillColor, Colors.white30],
  ];
  static const List<int> waveDurations = [19440, 10800];
  static const List<double> waveHeightPercentages = [0.20, 0.25];
  static const double waveAmplitude = 20.0;
  static const double waveBlur = 10.0;

  // Configuración de UI
  static const double logoHeight = 70.0;
  static const double logoBorderRadius = 8.0;
  static const double cardBorderRadius = 40.0;
  static const double buttonBorderRadius = 8.0;
  static const double inputBorderRadius = 8.0;
  static const double titleFontSize = 22.0;
  static const double subtitleFontSize = 10.0;

  // Márgenes y Padding
  static const EdgeInsets containerMargin = EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0);
  static const EdgeInsets cardMargin = EdgeInsets.only(left: 30, right: 30, top: 30);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: 30, vertical: 20);
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0);
  static const EdgeInsets switchPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 1);

  // Configuración de seguridad
  static const int loginAttemptsLimit = 5;
  static const int lockoutDurationSeconds = 120;

  // Configuración de base de datos
  static const String baseUrl = 'https://api.example.com'; // Reemplazar con la URL real
  static const int connectionTimeout = 30000; // 30 segundos
  static const int receiveTimeout = 30000; // 30 segundos
  static const Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
} 