import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:plurione_app/utils/utilidades.dart';

class Imagenes {
  Utilidades utils = Utilidades();
  
  static String imagenEmpresa = 'DEVELOPBlanco.png';
  static String imagenEmpresaColor = 'DEVELOP.png';
  static Color colorFondo = const Color(0xFF1565C0);

  static String ruta = 'lib/assets/';

  static Image? imageBlanco;
  static Image? imageColor;

  static GlobalKey tokenKey = GlobalKey();

  Future<Image> construyeImagenBlanco(double width) async {
    // if(Sesion.miSesion.usuario == null && Sesion.miSesion.clienteEventoCurso == null) {
    //   return Image.asset(ruta + imagenEmpresa, width: width,);
    // } else {
    //   imageColor = await utils.getLocalImage(imagenEmpresaColor, width,);
    //   imageBlanco = await utils.getLocalImage(imagenEmpresa, width,);
    //   return imageBlanco!;
    // }
    return Image.asset(ruta + imagenEmpresa, width: width,);
  }

  Future<Image> construyeImagenColor(double width) async {
    imageBlanco = await utils.getLocalImage(imagenEmpresa, width,);
    imageColor = await utils.getLocalImage(imagenEmpresaColor, width,);
    return imageColor!;
  }

  Image tokenImageAux = Image.asset(
    '$ruta${imagenEmpresa}Aux.png',
    fit: BoxFit.cover,
    // color: Colors.blueGrey[500],
    height: 50,
  );

  Image tokenCase = Image.asset(
    '${ruta}otptr.png',
    height: 140,
    // width: 250,
    key: tokenKey,
  );

  Image imagenBlanca(String empresa) {
    return Image.asset(
      '$ruta${empresa}Blanco.png',
      width: 120,
    );
  }

  Image imagenBlancaTam(String empresa, double width) {
    return Image.asset(
      '$ruta${empresa}Blanco.png',
      width: width,
    );
  }

  Image imagen(String empresa) {
    return Image.asset(
      '$ruta$empresa.png',
      width: 100,
    );
  }

  Future<String> obtenColorImagen(String nombreImagen) async {
    PaletteGenerator pg = await updatePaletteGenerator(nombreImagen);
    Color col = pg.dominantColor!.color;
    colorFondo = col;
    // debugPrint('Color... $colorFondo');
    return col.toString();
  }

  Future<PaletteGenerator> updatePaletteGenerator(String nombreImagen) async {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(
      Image.asset('$ruta$nombreImagen.png').image,
    );
    return paletteGenerator;
  }
}
