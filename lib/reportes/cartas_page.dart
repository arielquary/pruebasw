import 'package:flutter/material.dart';
import 'package:plurione_app/utils/decorations.dart';
import 'package:plurione_app/utils/network_image.dart';

class CartasPage extends StatefulWidget {
  final Map<String, dynamic> prefs;
  
  const CartasPage({
    super.key,
    required this.prefs,
  });

  @override
  _CartasPageState createState() => _CartasPageState();
}

class _CartasPageState extends State<CartasPage> {
  String token = '';
  String plan = '';
  String cadenaAConcatener = '';

  final List<String> titles = const [
    "Carta de Bienvenida",
    "Carta de Usuario y Password",
  ];

  final List<String> imagenes = const [
    'https://s26551.pcdn.co/wp-content/uploads/2015/04/Brandi-Moore.jpg',
    'https://mycollegeplan.com/content/uploads/2017/05/rsz_istock-183289535.jpg',
  ];

  final String imagenFondo = 'https://media.npr.org/assets/img/2019/04/04/small_092618osu_nadworny0237_slide-8cf2ada61baef0dd2670bf2705c25701d633b44b-s500-c85.jpg';

  final List<String> rutas = const [
    'https://cloudvitalis.mx/sistemaIndividualizador/participantesReportes/cartaBienvenidaPDFToken.jsp?',
    'https://cloudvitalis.mx/sistemaIndividualizador/participantesReportes/cartaBienvenidaPDFToken.jsp?',
  ];

  @override
  void initState() {
    super.initState();
  }

      
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: _buildAppNavBar(context),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: PNetworkImage(imagenFondo, fit: BoxFit.contain),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildAppNavBar(BuildContext context) => Row(
    children: <Widget>[
      InkWell(
        child: _buildAppBarButton(context, Icons.arrow_back_ios),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      const Spacer(),
      Container(
        decoration: getBoxDecoration(context, borderRadius: 8.0),
        child: Image.asset(
          'lib/assets/images/logoAG2.png',
          fit: BoxFit.cover,
          color: Colors.blueGrey[500],
          height: 70.0,
        ),
      ),
    ],
  );

  Container _buildAppBarButton(BuildContext context, IconData icon) => Container(
    width: 40.0,
    height: 40.0,
    decoration: getBoxDecoration(context, borderRadius: 8.0),
    child: Icon(icon, color: Colors.blueGrey[200]),
  );

  String obtenPlan(String string) {
    return '3';
  }

}