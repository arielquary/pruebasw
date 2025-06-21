import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plurione_app/models/sesion.dart';
import 'package:plurione_app/pages/dialogs.dart';
import 'package:plurione_app/pages/my_cards_screen.dart';
import 'package:plurione_app/providers/data_provider.dart';
import 'package:plurione_app/utils/decorations.dart';
import 'package:plurione_app/utils/utils.dart';
import 'package:plurione_app/config/app_config.dart';

import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:string_validator/string_validator.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  // Constantes para números mágicos
  static const int _loginAttemptsLimit = 5;
  static const int _lockoutDurationSeconds = 120;
  // static const Color _inputFillColor = Color.fromRGBO(0xE2, 0xED, 0xF8, 1.0);
  // static const String _defaultUser = 'CARDENAS71286A';
  // static const String _defaultPassword = '15228299';


  final dataProvider = DataProvider();

  final controllerUsuario = TextEditingController();
  final controllerPassword = TextEditingController();

  String _mensaje='';
  int contadorIntentos = 0;

  bool _guardarUsrPw = false;
  bool _preguntarPw = false;
  bool _borrarSharedPreferences = false;

  String usuario = '';
  String password = '';
  String token = '';
  String tokenTemporal = '';

  bool bloqueo = false;

  int horaActual = 0;

  bool _mostrarPassword = false;
  final bool _mostrarOpcionesAvanzadas = false;

  @override
  void initState() {
    super.initState();
    controllerUsuario.text = AppConfig.defaultUser;
    controllerPassword.text = AppConfig.defaultPassword;
    leeSharedPreferences();
  }

  void leeSharedPreferences() async {
    _guardarUsrPw = Sesion.miSesion.sharedPrefs['guardarUsuarioPassword'] == null 
      ? false 
      : toBoolean(Sesion.miSesion.sharedPrefs['guardarUsuarioPassword']);
    _preguntarPw = Sesion.miSesion.sharedPrefs['preguntarPassword']== null 
      ? false 
      :toBoolean(Sesion.miSesion.sharedPrefs['preguntarPassword']);
    token = Sesion.miSesion.sharedPrefs['token'] ?? '';          
    bloqueo = Sesion.miSesion.sharedPrefs['bloqueoAccesos'] ?? false;
    usuario = Sesion.miSesion.sharedPrefs['usuario'] ?? ''  ;
    password = Sesion.miSesion.sharedPrefs['password'] ?? '';
    tokenTemporal = Sesion.miSesion.sharedPrefs['token_temporal'] ?? '';
    
    if(_guardarUsrPw) {
      controllerUsuario.text = usuario;
      controllerPassword.text = password;
    }
    if(_preguntarPw) {
      controllerUsuario.text = usuario;
      controllerPassword.text = '';
    }
  }

  void verificaBloqueo() {
    int horaInicial = Sesion.miSesion.sharedPrefs['tiempo'] ?? 0;
    bool bloqueo = Sesion.miSesion.sharedPrefs['bloqueoAccesos'] ?? false;
      
    if(bloqueo) {
      int loqueva = ((horaActual-horaInicial)/1000).round();
      if(loqueva < _lockoutDurationSeconds) {
        int restante = (_lockoutDurationSeconds-loqueva).abs();
        DialogsPage.customAlertDialogClock(
          context, 
          AlertDialogType.ERROR, 
          "Acceso Bloqueado", 
          "Debe esperar para volver a entrar. Cuando transcurra el tiempo recargue la aplicación", 
          restante
        );
      } else {
        contadorIntentos = 0;
        limpiaDatosDeBloqueo();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _construyeInterfaz();
  }

  Scaffold _construyeInterfaz() {
    return Scaffold(
      body: 
      SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Container(
                margin: AppConfig.containerMargin,
                child: _buildAppNavBar(context),
              ),
              const SizedBox(height: 1.0,),
              Expanded (
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 650,
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: WaveWidget(
                          config: CustomConfig(
                              gradients: AppConfig.waveGradients,
                              durations: AppConfig.waveDurations,
                              heightPercentages: AppConfig.waveHeightPercentages,
                              blur: MaskFilter.blur(BlurStyle.solid, AppConfig.waveBlur),
                              gradientBegin: Alignment.bottomLeft,
                              gradientEnd: Alignment.topRight,
                          ),
                          waveAmplitude: AppConfig.waveAmplitude,
                          size: const Size(
                              double.infinity,
                              double.infinity,
                          ),
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(30.0),
                          height: Get.height * .8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Acceso", 
                                textAlign: TextAlign.center, 
                                style: TextStyle(
                                  fontSize: AppConfig.titleFontSize, 
                                  fontWeight: FontWeight.bold
                                )
                              ),
                              Card(
                                margin: AppConfig.cardMargin,
                                elevation: 11,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(AppConfig.cardBorderRadius)
                                  )
                                ),
                                child: TextField(
                                  controller: controllerUsuario,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person, color: AppConfig.primaryColor[300],),
                                    suffixIcon: Icon(Icons.check_circle, color: AppConfig.primaryColor[300],),
                                    hintText: "Usuario",
                                    hintStyle: TextStyle(color: AppConfig.primaryColor[300]),
                                    filled: true,
                                    fillColor: AppConfig.inputFillColor,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(AppConfig.inputBorderRadius)
                                      ),
                                    ),
                                    contentPadding: AppConfig.inputPadding
                                  ),
                                  onTap: limpiaMensaje,
                                ),
                              ),
                              Card(
                                margin: AppConfig.cardMargin,
                                elevation: 11,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(AppConfig.cardBorderRadius)
                                  )
                                ),
                                child: TextField(
                                  obscureText: !_mostrarPassword,
                                  obscuringCharacter: '*',
                                  controller: controllerPassword,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.lock, color: AppConfig.primaryColor[300],),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _mostrarPassword ? Icons.visibility : Icons.visibility_off,
                                        color: AppConfig.primaryColor[300],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _mostrarPassword = !_mostrarPassword;
                                        });
                                      },
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(
                                      color: AppConfig.primaryColor[300],
                                    ),
                                    filled: true,
                                    fillColor: AppConfig.inputFillColor,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(AppConfig.inputBorderRadius)
                                      ),
                                    ),
                                    contentPadding: AppConfig.inputPadding
                                  ),
                                  onTap: limpiaMensaje,
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding: AppConfig.buttonPadding,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppConfig.primaryColor[300],
                                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(AppConfig.buttonBorderRadius)
                                      )
                                    ),
                                    elevation: 0,
                                  ),
                                  onPressed: (){
                                    solicitaAcceso(controllerUsuario.text, controllerPassword.text);
                                  },
                                  child: Text("Entrar", 
                                    style: TextStyle(
                                      color: AppConfig.textColor
                                    )
                                  ),
                                ),
                              ),
                              Container(
                                padding: AppConfig.switchPadding,
                                child: _mostrarOpcionesAvanzadas ? SwitchListTile(
                                  dense: true,
                                  title: const Text('Desea guardar estos datos?'),
                                  value: _guardarUsrPw,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _guardarUsrPw = value;
                                    });
                                  },
                                  secondary: const Icon(Icons.add_to_home_screen),
                                ) : const SizedBox.shrink(),
                              ),
                              preguntarPorPasswordCadaVez(_guardarUsrPw),
                              Container(
                                padding: AppConfig.switchPadding,
                                child: _mostrarOpcionesAvanzadas ? SwitchListTile(
                                  dense: true,
                                  title: const Text('Desea borrar Shared Preferences?'),
                                  value: _borrarSharedPreferences,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _borrarSharedPreferences = value;
                                    });
                                  },
                                  secondary: const Icon(Icons.arrow_right),
                                ) : const SizedBox.shrink(),
                              ),
                              Text('$_mensaje',  style: TextStyle(
                                color: AppConfig.errorColor,
                              )), 
                              _mostrarOpcionesAvanzadas ? Text("Olvidó su password?",  style: TextStyle(
                                color: AppConfig.primaryColor[300],
                              )) : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 100,),
                      ],
                    ),
                    const SizedBox(height: 300,),
                  ],
                )
              ),
              const SizedBox(height: 30.0,),
          
            ]
          ),
        )
    )
  );

  }

  Widget preguntarPorPasswordCadaVez(bool mostrar){
    if(mostrar) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
        child: SwitchListTile(
          dense: true,
          title: Text('Preguntar por el Password cada vez? (El token tiene una vigencia de 30 dias)',
            style: TextStyle(color: AppConfig.primaryColor[300], fontSize: AppConfig.subtitleFontSize)),
          value: _preguntarPw,
          onChanged: (bool value1) {
            setState(() {
              _preguntarPw = value1;
            });
          },
          secondary: const Icon(Icons.arrow_right),
        ),
      );
    }
    else {
      return const Divider();
    }
  }

  Row _buildAppNavBar(BuildContext context) => Row(
    children: <Widget>[
      const Spacer(),
      Container(
        decoration: getBoxDecoration(context, borderRadius: AppConfig.logoBorderRadius),
        child: Image.asset(
          AppConfig.logoPath,
          fit: BoxFit.cover,
          // color: AppConfig.primaryColor[500],
          height: AppConfig.logoHeight,
        ),
      ),
    ],
  );

  void solicitaAcceso(String usr, String pw) async {
    usuario = usr;
    password = pw;
    if(_borrarSharedPreferences) {
      await limpiaSharedPreferences();
      return;
    }
    Map result = await dataProvider.getDatos(usr, pw);
    await accesa(result);
    horaActual = await obtenHoraServidor();

  }

  void actualizaMensaje(String mensaje) {
    setState(() {
      _mensaje = mensaje;
    });
  }

  void limpiaMensaje() {
    setState(() {
      verificaBloqueo();
      actualizaMensaje('');
    });
  }

  limpiaDatosDeBloqueo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('tiempo', 0);
    prefs.setBool('bloqueoAccesos', false);
  }

  activaDatosDeBloqueo(int tiempo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('tiempo', tiempo);
    prefs.setBool('bloqueoAccesos', true);
  }

  limpiaSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString('guardarUsuarioPassword', 'false');
    prefs.setString('preguntarPassword', 'false');
    prefs.setInt('tiempo', 0);
    prefs.setBool('bloqueoAccesos', false);
  }

  accesa(Map result) async {
    if(result['respuesta']!=null){
      if(result['respuesta']=='sin aceso') {
        actualizaMensaje('Acceso Incorrecto. Intente nuevamente');
        contadorIntentos++;
        if(contadorIntentos<=(_loginAttemptsLimit-3)) {
          actualizaMensaje('Acceso Incorrecto. Intente nuevamente');
        } else if(contadorIntentos<=(_loginAttemptsLimit-2)) {
          actualizaMensaje('Acceso Incorrecto. Intente nuevamente');
          if (!mounted) return;
          DialogsPage.customAlertDialog(context, AlertDialogType.WARNING, "Acceso Incorrecto", "Si sigue accesando incorrectamente se le bloqueara el acceso por una hora");
        }
        else if(contadorIntentos<=(_loginAttemptsLimit-1)) {
          actualizaMensaje('Acceso Incorrecto. Intente nuevamente');
          if (!mounted) return;
          DialogsPage.customAlertDialog(context, AlertDialogType.WARNING, "Acceso Incorrecto", "Solo tiene una vez mas para intentar antes del bloqueo de una hora");
        }
        else {
          actualizaMensaje('Acceso Bloqueado. Espera una hora para reintentar');
          await activaDatosDeBloqueo(horaActual);
          if (!mounted) return;
          DialogsPage.customAlertDialogClock(context, AlertDialogType.ERROR, "Acceso Bloqueado", "Debe esperar para volver a entrar. Cuando transcurra el tiempo recargue la aplicación", _lockoutDurationSeconds);
        }
      } else {
        actualizaMensaje('Hay un error. Contacte a Soporte');
      }
    } else {
      SharedPreferences sharedPrefs = await actualizaDatos(result, _guardarUsrPw, usuario, password, _preguntarPw, _borrarSharedPreferences);
      Sesion.miSesion.sharedPrefs = Utils().obtenMapaSharedPreferences(sharedPrefs);

      // Get.to(() => OtpPage());
      Get.to(MyCardsScreen(Sesion.miSesion.sharedPrefs));
    }
  }

  Future<SharedPreferences> actualizaDatos(Map datos, bool guardarUsrPw, String usuario, String password, bool preguntarPw, bool borrarSharedPreferences) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('guardarUsuarioPassword', '$guardarUsrPw');
    sp.setString('preguntarPassword', '$preguntarPw');
    if(guardarUsrPw) {
      sp.setString('usuario', usuario);
      if(!preguntarPw) sp.setString('password', password);
      sp.setString('token', datos['token']);
      sp.setString('nombre', datos['nombre']);
      sp.setString('numero_empleado', datos['numero_empleado']);
      sp.setString('permisos', datos['permisos']);
      sp.remove('token_temporal');
      sp.remove('nombre_temporal');
      sp.remove('numero_empleado_temporal');
      sp.remove('permisos_temporal');
    } else {
      sp.remove('usuario');
      sp.remove('password');
      sp.remove('token');
      sp.remove('nombre');
      sp.remove('numero_empleado');
      sp.remove('permisos');
      sp.setString('token_temporal', datos['token']);
      sp.setString('nombre_temporal', datos['nombre']);
      sp.setString('numero_empleado_temporal', datos['numero_empleado']);
      sp.setString('permisos_temporal', datos['permisos']);
    }
    Sesion.miSesion.token = datos['token'];
    return sp;
  }

  Future<int> obtenHoraServidor() async {
    int hs=0;
    await dataProvider.getFechaServidor().then((result) { 
      if(result['hora_actual']!=null){
        hs = int. parse(result['hora_actual']);
      }
    });
    return hs;
  }

}