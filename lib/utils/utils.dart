


import 'package:flutter/material.dart';
import 'package:plurione_app/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Utils {

    String reemplazaComillas(String cadena) {
    String aRegresar;
    //debugPrint('cadena ...' + cadena);
    aRegresar = cadena.substring(1,cadena.length-1);
    //debugPrint('aRegresar ...' + aRegresar);
      
    return aRegresar;
  }

  imprimeMap(Map mapa){
    mapa.forEach((key, value) {
      debugPrint('Llave $key ... $value');
    });
  }

  imprimeMapTransacciones(Map<String, Transaction> mapa){
    mapa.forEach((key, value) {
      debugPrint('Llave $key ... Transaction(category:${value.category}, title: ${value.title}, dateTime: ${value.dateTime}, icon: ${value.icon}, amount: ${value.amount}');
    });
  }


  Map<String, dynamic> obtenMapaSharedPreferences(SharedPreferences sp) {
    debugPrint('----- Obteniendo el Mapa de Shared Preferences ------');
    Map<String, dynamic> mapa = {};
    Set keys = sp.getKeys();
    for (var element in keys) {
      mapa[element] = sp.get(element);
    }
    // imprimeMap(mapa);
    return mapa;
  }

  static final moneda = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
  static final solonumeros = NumberFormat.currency(locale: 'es_MX', symbol: '');
  // static final solonumeros = NumberFormat("#####.00", "es_MX");

}