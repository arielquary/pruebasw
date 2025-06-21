import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plurione_app/models/sesion.dart';
import 'package:plurione_app/pages/my_cards_screen.dart';
import 'package:plurione_app/providers/data_provider.dart';
import 'package:plurione_app/utils/decorations.dart';

class OtpPage extends StatefulWidget {
  
  const OtpPage({super.key});

  @override
  OtpPageState createState() => OtpPageState();
}

class OtpPageState extends State<OtpPage> {

  OtpPageState();

  var dataProvider =  DataProvider();
  var controllerToken = TextEditingController();
  String _mensaje='';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: 
       SafeArea(
        child: SingleChildScrollView(
                  child: Column(
            children: <Widget>[
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: _buildAppNavBar(context),
              ),
                Container(
                  padding: const EdgeInsets.all(30.0),
                  // decoration: getBoxDecoration(context, borderRadius: 8.0),
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Token", textAlign: TextAlign.center, style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                      Card(
                        margin: EdgeInsets.only(left: 30, right:30, top:30),
                        color: Color.fromRGBO(0xE2, 0xED, 0xF8, 1.0),
                        elevation: 0,
                        child: Stack(
                            children: [
                              Image.asset(
                              'lib/assets/images/otptr.png',
                              height: 140.0,
                              ),
                              TextField(
                                controller: controllerToken,
                                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                                maxLength: 6,
                                decoration: InputDecoration(
                                  hintText: "000000",
                                  counterText: '',
                                  border: null,
                                  contentPadding: EdgeInsets.only(top: 56, left: screenSize.width*.29, bottom: 50),
                                ),
                                onTap: limpiaMensaje,
                              ), 
                            ],
                        ),
                      ),
                      Text("Teclee el número que su Token Digital muestra", style: TextStyle(
                        color: Colors.blueGrey[300],
                      )),
                      Text('$_mensaje',  style: TextStyle(
                        color: Colors.redAccent,
                      )), 
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(30.0),
                        child: MaterialButton(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          color: Colors.blueGrey[300],
                          onPressed: (){
                            dataProvider.getToken().then((result) {
                              // debugPrint('Trajo Datos...$result');
                              if(result == controllerToken.text) {
                                Get.to(MyCardsScreen(Sesion.miSesion.sharedPrefs));
                              } else {
                                actualizaMensaje('Acceso Incorrecto. Intente nuevamente');
                                controllerToken.text = '';
                              }
                            });
                          },
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                          child: Text("Entrar", style: TextStyle(
                            color: Colors.white70
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
            ]
          ),
        )
    )
  );
}

Row _buildAppNavBar(BuildContext context) => Row(
    children: <Widget>[
      Spacer(),
      Container(
        decoration: getBoxDecoration(context, borderRadius: 8.0),
        child: Image.asset(
          'lib/assets/images/logoAG.png',
          fit: BoxFit.cover,
          // color: Colors.blueGrey[500],
          height: 70.0,
          
        ),
      ),
    ],
  );

  void actualizaMensaje(String mensaje) {
    setState(() {
      _mensaje = mensaje;
    });
  }

  void limpiaMensaje() {
    actualizaMensaje('');
  }
}