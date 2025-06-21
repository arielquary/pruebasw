import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:plurione_app/utils/imagenes.dart';
import 'package:plurione_app/utils/utilidades.dart';

class Colors {

  static const Color colorPrincipal = Color(0xFF222327);
  static const Color colorLetras = Color(0xFF042F51);

  static List<Color> colores = [
    const Color(0xFFFFC312),
    const Color(0xFFF79F1F),
    const Color(0xFFEE5A24),
    const Color(0xFFEA2027),
    const Color(0xFFC4E538),
    const Color(0xFFA3CB38),
    const Color(0xFF009432),
    const Color(0xFF006266),
    const Color(0xFF12CBC4),
    const Color(0xFF1289A7),
    const Color(0xFF0652DD),
    const Color(0xFF1B1464),
    const Color(0xFFFDA7DF),
    const Color(0xFFD980FA),
    const Color(0xFF9980FA),
    const Color(0xFF5758BB),
    const Color(0xFFED4C67),
    const Color(0xFFB53471),
    const Color(0xFF833471),
    const Color(0xFF6F1E51),
    const Color(0xFFFFC312),
    const Color(0xFFF79F1F),
    const Color(0xFFEE5A24),
    const Color(0xFFEA2027),
    const Color(0xFFC4E538),
    const Color(0xFFA3CB38),
    const Color(0xFF009432),
    const Color(0xFF006266),
    const Color(0xFF12CBC4),
    const Color(0xFF1289A7),
    const Color(0xFF0652DD),
    const Color(0xFF1B1464),
    const Color(0xFFFDA7DF),
    const Color(0xFFD980FA),
    const Color(0xFF9980FA),
    const Color(0xFF5758BB),
    const Color(0xFFED4C67),
    const Color(0xFFB53471),
    const Color(0xFF833471),
    const Color(0xFF6F1E51),
  ];

  static List<Color> niveles = [
    const Color(0xFFc0392b),
    const Color(0xFFe74c3c),
    const Color(0xFFd35400),
    const Color(0xFFe67e22),
    const Color(0xFFf39c12),
    const Color(0xFFf1c40f),
    const Color(0xFF2980b9),
    const Color(0xFF3498db),
    const Color(0xFF27ae60),
    const Color(0xFF2ecc71),
  ];

  static List<Color> niveles2 = [
    const Color(0xFFd35400),
    const Color(0xFFf39c12),
    const Color(0xFF2980b9),
    const Color(0xFF27ae60),
    const Color(0xFF2ecc71),
    const Color(0xFF27ae60),
    const Color(0xFF2980b9),
    const Color(0xFFf39c12),
    const Color(0xFFd35400),
    const Color(0xFFc0392b),
  ];

 
MaterialColor createMaterialColor(Color color, double transparencia) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};

  // Extraer los componentes RGB y alfa usando métodos modernos
  final int r = color.r.toInt();
  final int g = color.g.toInt();
  final int b = color.b.toInt();

  // Generar las fuerzas (strengths) desde 0.1 hasta 0.9
  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  // Generar los colores para el swatch
  for (final double strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      transparencia,
    );
  }

  // Crear un valor de color para el MaterialColor usando los componentes RGB
  final int primaryColorValue = (0xFF << 24) | (r << 16) | (g << 8) | b;

  // Devolver el MaterialColor con el swatch generado
  return MaterialColor(primaryColorValue, swatch);
}

  Widget obtenColorPrincipal(String rutaImagen) {
    return FutureBuilder<PaletteGenerator>(
      future: Imagenes().updatePaletteGenerator(Imagenes.imagenEmpresa), // async work
      builder: (BuildContext context, AsyncSnapshot<PaletteGenerator> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return Container();
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              if(Utilidades().readKeyFromDevice('empresa') != null) {
                Imagenes.colorFondo = const Color.fromRGBO(255, 255, 255, 0);
              } else {
                Imagenes.colorFondo = snapshot.data!.dominantColor!.color;
              }
              return Container();
            }
       }
      } 
    );
  }

  Color obtenColor(String colorString) {
    String valueString = colorString.replaceAll('#', ''); // kind of hacky..
    int value = int.parse(valueString, radix: 16) + 0xFF000000;
    Color otherColor = Color(value);
    return otherColor;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}