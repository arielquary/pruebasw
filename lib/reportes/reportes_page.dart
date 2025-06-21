import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:plurione_app/pages/my_cards_screen.dart';
import 'package:plurione_app/utils/decorations.dart';
import 'package:plurione_app/utils/network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportesPage extends StatefulWidget {
  final Map<String, dynamic> prefs;
  
  const ReportesPage({
    super.key,
    required this.prefs,
  });

  @override
  State<ReportesPage> createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  late SharedPreferences _prefs;
  String token = '';
  String plan = '';
  String cadenaAConcatener = '';

  final SwiperController _swiperController = SwiperController();
  final int _pageCount = 3;
  int _currentIndex = 0;
  final List<String> titles = const [
    "Resumen de Estado de Cuenta",
    "Estado de Cuenta",
    "Detalle de Movimientos"
  ];

  final List<String> imagenes = const [
    'https://www.caracteristicas.co/wp-content/uploads/2017/05/estados-financieros-e1569557465449.jpg',
    'https://www.lifeder.com/wp-content/uploads/2018/04/Estado-de-situaci%C3%B3n-financiera.jpg',
    'http://2.bp.blogspot.com/-p5O7qh9_lWk/Txuk-uYMo1I/AAAAAAAAAS0/RpRX88INmRE/s320/finanzas.jpg',
    'https://www.caracteristicas.co/wp-content/uploads/2017/05/estados-financieros-4-e1569558328193.jpg',
  ];

  final String imagenFondo = 'https://www.caracteristicas.co/wp-content/uploads/2017/05/estados-financieros-2-e1569557880185.jpg';

  final List<String> rutas = const [
    'https://cloudvitalis.mx/sistemaIndividualizador/participantesReportes/resumenEstadoDeCuentaPDFToken.jsp?',
    'https://cloudvitalis.mx/sistemaIndividualizador/participantesReportes/resumenEstadoDeCuentaPDFToken.jsp?',
    'https://cloudvitalis.mx/sistemaIndividualizador/participantesReportes/resumenEstadoDeCuentaPDFToken.jsp?',
    'https://cloudvitalis.mx/sistemaIndividualizador/participantesReportes/resumenEstadoDeCuentaPDFToken.jsp?',
  ];

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    token = _prefs.getString('token_temporal') ?? '';
    plan = obtenPlan(_prefs.getString('permisos_temporal') ?? '');
    cadenaAConcatener = 'plan=$plan&token=$token';
    setState(() {});
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
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Swiper(
                          index: _currentIndex,
                          control: const SwiperControl(),
                          itemCount: _pageCount,
                          onIndexChanged: (index) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                          loop: false,
                          itemBuilder: (context, index) {
                            return _buildPage(
                              title: titles[index],
                              icon: imagenes[index],
                              ruta: '${rutas[index]}$cadenaAConcatener'
                            );
                          },
                          pagination: const SwiperPagination(
                            builder: SwiperPagination.dots
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildButtons(),
                    ],
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
        onTap: () {
          Navigator.pop(context);
        },
        child: _buildAppBarButton(context, Icons.arrow_back_ios),
      ),
      const Spacer(),
      Container(
        height: 70.0,
        decoration: getBoxDecoration(context, borderRadius: 8.0),
        child: Image.asset(
          'lib/assets/images/logoAG2.png',
          fit: BoxFit.cover,
          color: Colors.blueGrey[500],
        ),
      ),
    ],
  );

  Container _buildAppBarButton(BuildContext context, IconData icon) =>
      Container(
        width: 40.0,
        height: 40.0,
        decoration: getBoxDecoration(context, borderRadius: 8.0),
        child: Icon(icon, color: Colors.blueGrey[200]),
      );

  Widget _buildButtons() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MaterialButton(
            textColor: Colors.grey.shade700,
            onPressed: () {
              Get.to(MyCardsScreen(widget.prefs));
            },
            child: const Text("Regresar"),
          ),
          IconButton(
            icon: Icon(
              _currentIndex < _pageCount - 1 ? Icons.arrow_forward : Icons.check_circle_outline,
              size: 40,
            ),
            onPressed: () async {
              if (_currentIndex < _pageCount - 1) {
                _swiperController.next();
              } else {
                Get.to(MyCardsScreen(widget.prefs));
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildPage({required String title, required String icon, required String ruta}) {
    final TextStyle titleStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 20.0
    );
    return InkWell(
      onTap: () {
        _launchURL(ruta);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(50.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          image: DecorationImage(
            image: CachedNetworkImageProvider(icon),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(Colors.black38, BlendMode.multiply)
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10.0,
              spreadRadius: 5.0,
              offset: Offset(5.0, 5.0),
              color: Colors.black26
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: titleStyle.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No se pudo abrir la URL: $url')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al abrir la URL: $e')),
        );
      }
    }
  }

  String obtenPlan(String string) {
    return '3';
  }
}