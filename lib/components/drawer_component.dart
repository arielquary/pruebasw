import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plurione_app/components/drawer/oval_right_clipper.dart';
import 'package:plurione_app/pages/my_cards_screen.dart';
import 'package:plurione_app/pages/resumen_edo_cuenta.dart';
// import 'package:plurione_app/pages/financial_tips_screen.dart';
import 'package:plurione_app/utils/decorations.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerComponent {

  Map<String, dynamic>? prefs;

  final Color primary = const Color.fromRGBO(0xE2, 0xED, 0xF8, 1.0);
  final Color active = Colors.grey.shade800;
  final Color divider = Colors.grey.shade600;

  final String imagen = 'https://cloudvitalis.mx/logos/LogoNew_PlurioneCH.png';
  final String imagen1 = 'https://cloudvitalis.mx/logos/LogoNew_PlurioneCH.png';
  
  Widget buildDrawer(BuildContext context, String nombre, String numeroEmpleado, Map<String, dynamic> prefs, String imagenEmpresa, Map<String, dynamic> resumen) {
    debugPrint('DrawerComponent - Entro a buildDrawer');
    // Utils().imprimeMap(prefs);
    return ClipPath(
      clipper: OvalRightBorderClipper(),
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.only(left: 16.0, right: 40),
          decoration: BoxDecoration(
              color: primary, boxShadow: [BoxShadow(color: Colors.black45)]),
          width: 300,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(
                        Icons.power_settings_new,
                        color: active,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    decoration: getBoxDecoration(context, borderRadius: 8.0),
                    child: FadeInImage(
                      placeholder: NetworkImage(imagen1),
                      image: AssetImage(
                        'lib/assets/images/logoAG2.png',
                      ),
                      fit: BoxFit.cover,
                      height: 60, 
                    ),
                  ),
                  
                  SizedBox(height: 30.0),
                  Text(
                    "$nombre",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "$numeroEmpleado",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 12.0),
                  ),
                  SizedBox(height: 50.0),
                  _buildRow(context, MyCardsScreen(prefs), Icons.home, "Home"),
                  _buildDivider(),
                  /* Estados de Cuenta temporalmente deshabilitado
                  _buildRow(context, const FinancialTipsScreen(), Icons.description, "Estados de Cuenta", iconColor: Colors.red),
                  _buildDivider(),
                  */
                  _buildRow(context, ResumenEstadoCuenta(prefs, resumen), Icons.notifications, "Resumen de Cuenta"),
                  _buildDivider(),
                  /* _buildRow(context, AnalyticsScreen(), Icons.person_pin, "Mi Perfil"),
                  _buildDivider(),
                  _buildRow(context, AnalyticsScreen(), Icons.message, "Solicitar Préstamo", showBadge: true),
                  _buildDivider(), */
                  InkWell(
                    onTap: () async {
                      String phoneNumber = "525545830288";
                      final Uri whatsappUrl = Uri.parse("whatsapp://send?phone=$phoneNumber");
                      try {
                        if (await canLaunchUrl(whatsappUrl)) {
                          await launchUrl(whatsappUrl);
                        } else {
                          // Si no se puede abrir con el esquema whatsapp://, intentamos con https://
                          final Uri webWhatsappUrl = Uri.parse('https://wa.me/$phoneNumber');
                          if (await canLaunchUrl(webWhatsappUrl)) {
                            await launchUrl(webWhatsappUrl, mode: LaunchMode.externalApplication);
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Por favor, asegúrate de tener WhatsApp instalado en tu dispositivo'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }
                          }
                        }
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error al abrir WhatsApp: $e'),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: getBoxDecoration(context, borderRadius: 8.0),
                          child: Icon(Icons.message, color: active),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Contáctenos",
                          style: TextStyle(color: active, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  _buildDivider(),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
    Divider _buildDivider() {
    return Divider(
      color: divider,
    );
  }

  Widget _buildRow(BuildContext context, Widget pantalla, IconData icon, String title, {bool showBadge = false, Color? iconColor}) {
    final TextStyle tStyle = TextStyle(color: active, fontSize: 16.0);

    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Get.to(pantalla);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: getBoxDecoration(context, borderRadius: 8.0),
            child: Icon(
              icon,
              color: iconColor ?? active,
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            title,
            style: tStyle,
          ),
          Spacer(),
          if (showBadge)
            Material(
              color: Colors.deepOrange,
              elevation: 5.0,
              shadowColor: Colors.red,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                width: 25,
                height: 25,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  "3+",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
        ]),
      ),
    );
  }
}