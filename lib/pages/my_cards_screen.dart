import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plurione_app/components/drawer_component.dart';
import 'package:plurione_app/components/my_cards_view.dart';
import 'package:plurione_app/components/plurione_progress_indicator.dart';
import 'package:plurione_app/components/recent_transaction_view.dart';
import 'package:plurione_app/pages/analytics_screen.dart';
import 'package:plurione_app/providers/data_provider.dart';
import 'package:plurione_app/utils/decorations.dart';

class MyCardsScreen extends StatefulWidget {
  final Map<String, dynamic> sharedPreferences;

  const MyCardsScreen(this.sharedPreferences, {super.key});

  @override
  _MyCardsScreenState createState() => _MyCardsScreenState();
}

class _MyCardsScreenState extends State<MyCardsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  String saldo = '0';
  String nombre ='';
  String token = '';
  String numeroEmpleado ='';
  String permisos = '';
  final String imagen = 'https://cloudvitalis.mx/logos/LogoNew_PlurioneCH.png';
  final String imagenEmpresa = 'https://cloudvitalis.mx/logos/LogoNew_PlurioneCH.png';
  final String imagen1 = 'https://cloudvitalis.mx/logos/LogoNew_PlurioneCH.png';

  final dataProvider = DataProvider();

  @override
  void initState() {
    debugPrint('MyCardsScreen - Entro a initState');
    super.initState();
    procesaOperaciones();
    debugPrint('MyCardsScreen - Salio de initState');
  }
  
  @override
  Widget build(BuildContext context) {
    debugPrint('MyCardsScreen - Entro a build');
    return FutureBuilder(
      future: dataProvider.getResumenEstadoDeCuenta('3', token),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if(snapshot.hasData) {
          return muestraPantalla(snapshot);
        }
        else {
          return Container(
            color: Colors.white,
            height: double.infinity,
            width: double.infinity,
            child: const PluriOneProgressIndicator(),
          );
        }
      }
    );
  }

  Widget muestraPantalla(AsyncSnapshot snapshot) {
    return Scaffold(
      key: _key,
      drawer: DrawerComponent().buildDrawer(
        context, 
        snapshot.data['nombre'] as String, 
        snapshot.data['numero_empleado'] as String, 
        widget.sharedPreferences, 
        snapshot.data['logo_app'] as String, 
        Map<String, dynamic>.from(snapshot.data)
      ),
      body: SafeArea(
        child: construye(snapshot.data['logo_empresa'] as String),
      ),
    );
  }
  
  Widget construye(String imagenProveedor)  {
    debugPrint('MyCardsScreen - Entro a construye');
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: _buildAppNavBar(context, imagenProveedor),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            child: MyCardsView(widget.sharedPreferences),
            onTap: () {
              Get.to(const AnalyticsScreen());
            },
          ),
        ),
        const Expanded(
          flex: 1,
          child: RecentTransaction(),
        ),
      ],
    );
  }

  Row _buildAppNavBar(BuildContext context, String imagenProveedor) => Row(
        children: <Widget>[
          InkWell(
            child: _buildAppBarButton(context, Icons.menu),
            onTap: () {
              _key.currentState?.openDrawer();
            },
          ),
          const Spacer(),
          Container(
            decoration: getBoxDecoration(context, borderRadius: 8.0),
            child: FadeInImage(
              placeholder: NetworkImage(imagen1),
              image: NetworkImage(imagenProveedor),
              fit: BoxFit.cover,
              height: 70, 
            ),
          ),
        ],
      );

  Container _buildAppBarButton(BuildContext context, IconData icon) => Container(
        width: 40.0,
        height: 40.0,
        decoration: getBoxDecoration(context, borderRadius: 8.0),
        child: Icon(icon, color: Colors.blueGrey[200],),
      );

  Future<bool> procesaOperaciones() async {
    debugPrint('MyCardsScreen - Entro a procesar operaciones');
    leeSharedPreferences();
    debugPrint('MyCardsScreen - Salio de procesar operaciones');
    return true;
  }  
  
  void leeSharedPreferences() {
    debugPrint('MyCardsScreen - Entro a leeSharedPreferences');
    String comp='';
    widget.sharedPreferences['nombre'] !=null ? comp='' : comp='_temporal';
    nombre = widget.sharedPreferences['nombre$comp'];
    token = widget.sharedPreferences['token$comp'];
    numeroEmpleado = widget.sharedPreferences['numero_empleado$comp'];
    permisos = widget.sharedPreferences['permisos$comp'];
    debugPrint('MyCardsScreen - Salio de leeSharedPreferences');
  }
}      