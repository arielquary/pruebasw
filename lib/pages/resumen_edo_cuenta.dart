import 'package:flutter/material.dart';
import 'package:plurione_app/pages/resumen_edo_cuenta_content.dart';
import 'package:plurione_app/pages/resumen_edo_cuenta_header.dart';
import 'package:plurione_app/utils/decorations.dart';

class ResumenEstadoCuenta extends StatelessWidget {
  
  final Map prefs;
  final Map resumen;
  final Color primary = const Color.fromRGBO(0xE2, 0xED, 0xF8, 1.0);
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;
  final String imagen1 = 'https://cloudvitalis.mx/logos/LogoNew_PlurioneCH.png';

  ResumenEstadoCuenta(this.prefs, this.resumen, {super.key});

  @override
  Widget build(BuildContext context) {
        // imagen = datos['logo_empresa'];
debugPrint('En resumen estado de cuenta...$prefs');
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
              child: _buildAppNavBar(context),
            ),
            SizedBox(
              height: 135,
              child: ResumenEstadoCuentaHeader(prefs, resumen),
            ),
            Expanded(
              flex: 1,
              child: ResumenEdoCuentaContent(prefs, resumen),
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
        Spacer(),
        Container(
          decoration: getBoxDecoration(context, borderRadius: 8.0),
          child: FadeInImage(
            placeholder: NetworkImage(imagen1),
            image: NetworkImage(resumen['logo_empresa']),
            fit: BoxFit.cover,
            height: 70, 
          ),
        ),
//          _buildAppBarButton(context, Icons.arrow_back_ios),
        ],
      );

  Container _buildAppBarButton(BuildContext context, IconData icon) =>
      Container(
        width: 40.0,
        height: 40.0,
        decoration: getBoxDecoration(context, borderRadius: 8.0),
        child: Icon(icon, color: Colors.blueGrey[200],),
      );

}