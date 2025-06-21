import 'package:flutter/material.dart';
import 'package:plurione_app/models/chart.dart';
import 'package:plurione_app/models/transaction.dart';
import 'package:plurione_app/utils/decorations.dart';
import 'package:plurione_app/utils/hex_color.dart';
import 'package:plurione_app/utils/utils.dart';
import 'package:string_validator/string_validator.dart';
import 'dart:math';

class AnalyticsView extends StatefulWidget {
  const AnalyticsView({super.key});

  @override
  AnalyticsViewState createState() => AnalyticsViewState();
}

class AnalyticsViewState extends State<AnalyticsView> {
  List<Chart> chartAUsar = Transaction.chartIngresos;  

  bool presionado=true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Análisis del Año',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: getBoxDecoration(context, borderRadius: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        obtenMeses(),
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              children: <Widget>[
                creaBoton(context, presionado, 'Ingresos'),
                SizedBox(
                  width: 30.0,
                ),
                creaBoton(context, !presionado, 'Egresos'),
              ],
            ),
          ),
          Expanded(child: _buildChart(context, presionado)),
          _ponComparativoIngresos(),
        ],
      ),
    );
  }

  Widget creaBoton(BuildContext context, bool pres, String texto) {
    return InkWell(
        onTap:(){ 
          if(!pres) {
            setState(() {
              presionado = !presionado;
              if(presionado) {
                chartAUsar = Transaction.chartIngresos;
              } else {
                chartAUsar = Transaction.chartEgresos;
              } 
            });
          }
        } ,
        child: Container(
        decoration: getBoxDecoration(
          context,
          isPressed: pres,
          blurRadius: 1.0,
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 9.0, horizontal: 15.0),
        child: Center(
          child: Text(texto,
            style: TextStyle(
                fontSize: 14.0, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Container _buildChart(BuildContext context, bool sonIngresos) => Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(
        left: 10.0, top: 35.0, right: 10.0, bottom: 20.0),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: chartAUsar.length,
      itemBuilder: (context, index) => _buildBar(context, chartAUsar[index]),
    ));

  Widget _buildBar(BuildContext context, Chart chart) => Column(
    children: <Widget>[
      Text(
        '${Utils.solonumeros.format(toDouble(chart.valor))}',
        style: TextStyle(
          fontSize: 10.0,
          color: chart.height >= 0 ? Colors.blueGrey[200] : Colors.red
        ),
      ),
      const SizedBox(height: 5.0),
      Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 22.0),
          decoration: getBoxDecoration(context, isPressed: true, blurRadius: 2.0),
          width: 22.0,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1.0),
              height: chart.height >= 0 ? max(0, chart.height) : 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: chart.height >= 0 ? HexColor('#FF6A00') : HexColor('#FF0000'),
                boxShadow: const [
                  BoxShadow(color: Colors.orange, offset: Offset(-2, 0)),
                  BoxShadow(color: Colors.orange, offset: Offset(2, 0))
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 10.0),
      Text(
        chart.title,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.w500,
          color: Colors.blueGrey[200]
        ),
      ),
    ],
  );

  Widget _ponComparativoIngresos() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              obtenLabelIngresoeEgresos(),
              const SizedBox(height: 5.0),
              Text(
                calculaDiferenciaEntreMeses(), 
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[200]
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            calculaUltimoMes(), 
            style: const TextStyle(
              fontSize: 18.0, 
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      )
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