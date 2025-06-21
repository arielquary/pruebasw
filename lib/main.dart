import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plurione_app/pages/splash_screen_page.dart';
import 'package:plurione_app/rutas/routes.dart';
import 'package:plurione_app/utils/theme/style.dart';

void main() async {
  await GetStorage.init();  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PluriOne (R)',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: '/',
      getPages: obtenRutas(),
      home: SplashScrenPage(),
    );
  }
}
