import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plurione_app/components/splashscreen.dart';
import 'package:plurione_app/models/sesion.dart';
import 'package:plurione_app/pages/login_page.dart';
import 'package:plurione_app/pages/otp_page.dart';
import 'package:plurione_app/providers/data_provider.dart';
import 'package:plurione_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class SplashScrenPage extends StatelessWidget {
  final DataProvider dataProvider = DataProvider();
  final int horaServidor = 0;

  SplashScrenPage({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Entro...');
    return FutureBuilder(
      future: leeSharedPreferences(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          SharedPreferences sp = snapshot.data;
          debugPrint('El Splash ya tiene todos los datos del SharedPreferences');
          Sesion.miSesion.sharedPrefs = Utils().obtenMapaSharedPreferences(sp);
          return construyeSplash(context);
        }
        return Container();
      },
    );
  }

  Widget construyeSplash(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 5,
          child: SplashScreen(
            seconds: 3,
            navigateAfterSeconds: obtenSiguientePagina(),
            image: Image.asset(
              'lib/assets/images/logoAG.png',
              height: 300,
            ),
            photoSize: MediaQuery.of(context).size.width * 0.4,
            onClick: () => Get.to(obtenSiguientePagina()),
          )
        ),
      ],
    ); 
  }
 
  Widget obtenSiguientePagina() {
    // debugPrint('----- En obtenSiguientePagina() de SplashScrenPage ------');
    // Utils().imprimeMap(sharedPrefs);
    bool guardarUsrPw = Sesion.miSesion.sharedPrefs['guardarUsuarioPassword'] == null ? false : toBoolean(Sesion.miSesion.sharedPrefs['guardarUsuarioPassword']);
    bool preguntarPw = Sesion.miSesion.sharedPrefs['preguntarPassword'] == null ? false : toBoolean(Sesion.miSesion.sharedPrefs['preguntarPassword']);
    String token = Sesion.miSesion.sharedPrefs['token'] ?? '';          
    bool bloqueo = Sesion.miSesion.sharedPrefs['bloqueoAccesos'] ?? false;

    bool tokenVigente=true;

    // if(_guardarUsrPw&&!_preguntarPw&&token.length>0&&tokenVigente&&!bloqueo) return MyCardsScreen(sharedPrefs);
    // if(_guardarUsrPw&&!_preguntarPw&&token.length>0&&tokenVigente&&!bloqueo) return OtpPage(sharedPrefs);
    if(guardarUsrPw&&!preguntarPw&&token.isNotEmpty&&tokenVigente&&!bloqueo) {
      return OtpPage();
    } else {
      return LoginPage();
    }
  }

  Future<SharedPreferences>  leeSharedPreferences() async {
    Sesion.miSesion.prefs = await SharedPreferences.getInstance();
    await obtenHoraServidor(Sesion.miSesion.prefs);
    return Sesion.miSesion.prefs;
  }

  Future<int> obtenHoraServidor(SharedPreferences p) async {
    int hs=0;
    await dataProvider.getFechaServidor().then((result) { 
      // debugPrint('obtenHoraServidor... Fecha de Servidor...$result');
      if(result['hora_actual']!=null){
        hs = int. parse(result['hora_actual']);
        // debugPrint('obtenHoraServidor... horaServidor...$horaServidor');
        // DateTime dt = DateTime.fromMillisecondsSinceEpoch(horaServidor);
        // debugPrint('obtenHoraServidor... dt...$dt');
      }
    });
    return hs;
  }
}