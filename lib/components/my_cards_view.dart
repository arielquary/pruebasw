import 'package:flutter/material.dart';
import 'package:plurione_app/components/plurione_progress_indicator.dart';
import 'package:plurione_app/providers/data_provider.dart';
import 'package:plurione_app/utils/utils.dart';
import 'package:string_validator/string_validator.dart';
import 'package:plurione_app/models/chart.dart';
import 'package:plurione_app/models/transaction.dart';

// import 'package:mobile_banking_neomorphism_app/utilities/decorations.dart';


class MyCardsView extends StatefulWidget {
  final Map<String, dynamic> prefs;

  const MyCardsView(this.prefs, {super.key});

  @override
  MyCardsViewState createState() => MyCardsViewState();
}

class MyCardsViewState extends State<MyCardsView> {
  late Map<String, dynamic> prefs;
  final dataProvider = DataProvider();

  late String token;
  late String permisos;
  String nombre = '';
  String saldo = '0';
  String numeroEmpleado = '';
  bool presionado = true;
  List<Chart> chartAUsar = Transaction.chartIngresos;

  @override
  void initState() {
    super.initState();
    prefs = widget.prefs;
    leeSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Mis Cuentas',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 30.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: dataProvider.getResumenEstadoDeCuenta('3', token),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  return muestraSaldoText(snapshot);
                }
                else {
                  return const PluriOneProgressIndicator();
                }
              },
            ),    
          ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildIndicator(isCurrentPage: true),
              const SizedBox(width: 10.0),
              _buildIndicator(),
              const SizedBox(width: 10.0),
              _buildIndicator()
            ],
          ),
        ],
      ),
    );
  }

  Container _buildIndicator({bool isCurrentPage = false}) => Container(
    height: 4.0,
    width: isCurrentPage ? 22.0 : 10.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: isCurrentPage ? Colors.grey : Colors.grey[400],
    ),
  );

  void leeSharedPreferences() {
    debugPrint('MyCardsView - Entro a Shared Preferences');
    String comp = '';
    prefs['nombre'] != null ? comp = '' : comp = '_temporal';

    nombre = prefs['nombre$comp'];
    token = prefs['token$comp'];
    numeroEmpleado = prefs['numero_empleado$comp'];
    permisos = prefs['permisos$comp'];
    debugPrint('MyCardsView - Salio de Shared Preferences');
  }

  Widget muestraSaldoText(AsyncSnapshot snapshot) {
    double saldo = toDouble(snapshot.data['total_ingresos']['total']) - toDouble(snapshot.data['total_egresos']['total']);
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Theme.of(context).primaryColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(8, 16),
            color: Colors.black12,
            blurRadius: 6,
          ),
          BoxShadow(
            offset: Offset(-2, -3),
            color: Colors.white,
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '${snapshot.data['empresa']}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[200],
                    height: 0.9,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: Text(
                      nombre,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[200]
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    )
                  ),
                ],
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  Text(
                    'Saldo Neto',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey[200]
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    Utils.moneda.format(saldo),
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  const Spacer(),
                  Text(
                    'Id $numeroEmpleado',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.blueGrey[300]
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget obtenLabelIngresoeEgresos() {
    if(presionado) {
      return const Text(
        'Ingresos este mes', 
        style: TextStyle(
          fontSize: 15.0, 
          fontWeight: FontWeight.w600
        ),
      );
    } else {
      return const Text(
        'Egresos este mes', 
        style: TextStyle(
          fontSize: 15.0, 
          fontWeight: FontWeight.w600
        ),
      );
    }
  }

  String calculaDiferenciaEntreMeses() {
    if(chartAUsar.length==1) {
      return '';
    } else {
      double ultimoMes = toDouble(chartAUsar[chartAUsar.length-1].valor.replaceAll('\$','').replaceAll(',','').replaceAll(' ',''));
      double penultimoMes = toDouble(chartAUsar[chartAUsar.length-2].valor.replaceAll('\$','').replaceAll(',','').replaceAll(' ',''));
      if(ultimoMes>penultimoMes) {
        return '${Utils.solonumeros.format(ultimoMes-penultimoMes)} mas que el mes pasado';
      } else if(ultimoMes<penultimoMes) {
        return '${Utils.solonumeros.format(penultimoMes-ultimoMes)} menos que el mes pasado';
      } else {
        return 'Igual que el mes pasado'; 
      }
    }
  }

  String calculaUltimoMes() {
    return chartAUsar[chartAUsar.length-1].valor;
  }

  String obtenMeses() {
    if(chartAUsar.length==1) {
      return 'Mes ${chartAUsar[0].title}';
    } else {
      return 'De ${chartAUsar[0].title} a ${chartAUsar[chartAUsar.length-1].title}';
    }
  }
}