import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:plurione_app/pages/splash_screen_page.dart';

obtenRutas() {
  return [
    GetPage(name: '/', page: () => obtenPagina(SplashScrenPage())),
    GetPage(name: '/splash', page: () => obtenPagina(SplashScrenPage())),

  ];
}

Widget obtenPagina(Widget pagina) {
    return pagina;
}