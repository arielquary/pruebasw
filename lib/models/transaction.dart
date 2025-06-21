import 'package:flutter/material.dart';
import 'package:plurione_app/models/chart.dart';
import 'package:plurione_app/utils/utils.dart';
import 'package:string_validator/string_validator.dart';

class Transaction {
  Transaction({
    this.category = '',
    this.title = '', 
    this.dateTime = '',
    this.icon = Icons.add,
    this.amount = '',
  });

  final String category;
  final String title;
  final String dateTime;
  final IconData icon;
  String amount;

  static final List<String> orden = ['saldoAportaciones','saldoIntereses','totalRecibido','total_ingresos','saldoPrestamos','saldoComisiones','saldoRetiro','total_egresos'];
  static final Map<String, String> movAlias = {  "total_ingresos"              : "Total de Ingresos",
                                    "apoEmpresa"                  : "Aportación de la Empresa",
                                    "intApoEmpresa"               : "Interés de Aportación de la Empresa",
                                    "apoEmpleado"                 : "Aportación del Empleado",
                                    "intApoEmpleado"              : "Interés de Aportación del Empleado",
                                    "apoVoluntaria"               : "Aportación Voluntaria",
                                    "intApoVoluntaria"            : "Interés de Aportación Voluntaria",
                                    "aportacionExtraordinaria"    : "Aportación Extraordinaria",
                                    "intAportacionExtraordinaria" : "Interés de Aportación Extraordinaria",
                                    "intRecibidosPorPrestamo"     : "Intereses recibidos por Préstamo",
                                    "intRecPorDifLiquidacion"     : "Intereses recibidos por diferencias en Liquidaciones",
                                    "premioAlAhorro"              : "Premio al Ahorro",
                                    "pagoExcedido"                : "Pago Excedido",
                                    "intPagoExcedido"             : "Interés de Pago Excedido",
                                    "saldoFondo"                  : "Saldo del Fondo",
                                    "saldoAportaciones"           : "Saldo de Aportaciones",
                                    "saldoIntereses"              : "Saldo de Intereses",
                                    "totalRecibido"               : "Total Recibido",
                                    "saldoExcedido"               : "Saldo Excedido",
                                    "total_egresos"               : "Total de Egresos",
                                    "prestamo"                    : "Préstamos",
                                    "intPrestamo"                 : "Interés de Préstamos",
                                    "comision"                    : "Comisión de Préstamos",
                                    "prepagoCapital"              : "Prepago a Capital",
                                    "prepagoIntereses"            : "Prepago a Intereses",
                                    "comisionDepositosExtr"       : "Comisión de Depósitos Extraordinarios",
                                    "comisionAdministracion"      : "Comisión de Adiministración",
                                    "comisionLiquidacion"         : "Comisión de Liquidación",
                                    "comisionRetiro"              : "Comisión de Retiros",
                                    "retiroEmpresa"               : "Retiro de la Empresa",
                                    "comisionSeguro"              : "Comisión del Seguro",
                                    "retiroParticipante"          : "Retiro de Participante",
                                    "retiroParticipanteVol"       : "Retiro de Participante Aportación Voluntaria",
                                    "retiroPagoExcedido"          : "Retiro de Pago Excedido",
                                    "retiroExtraordinarias"       : "Retiro de Aportaciones Extraordinarias",
                                    "saldoPrestamos"              : "Saldo de Préstamos",
                                    "saldoPrepago"                : "Saldo de Prepagos",
                                    "saldoComisiones"             : "Saldo de Comisiones",
                                    "saldoRetiro"                 : "Saldo de Retiros",
                                  };
  static final Map<String, String> tipoEfecto = {  "total_ingresos" : "positivo",
                                    "apoEmpresa": "positivo",
                                    "intApoEmpresa": "positivo",
                                    "apoEmpleado": "positivo",
                                    "intApoEmpleado": "positivo",
                                    "apoVoluntaria": "positivo",
                                    "intApoVoluntaria": "positivo",
                                    "aportacionExtraordinaria": "positivo",
                                    "intAportacionExtraordinaria": "positivo",
                                    "intRecibidosPorPrestamo": "positivo",
                                    "intRecPorDifLiquidacion": "positivo",
                                    "premioAlAhorro": "positivo",
                                    "pagoExcedido": "positivo",
                                    "intPagoExcedido": "positivo",
                                    "saldoFondo": "positivo",
                                    "saldoAportaciones": "positivo",
                                    "saldoIntereses": "positivo",
                                    "totalRecibido": "positivo",
                                    "saldoExcedido": "positivo",
                                    "total_egresos": "positivo",
                                    "prestamo": "negativo",
                                    "intPrestamo": "negativo",
                                    "comision": "negativo",
                                    "prepagoCapital": "positivo",
                                    "prepagoIntereses": "positivo",
                                    "comisionDepositosExtr": "negativo",
                                    "comisionAdministracion": "negativo",
                                    "comisionLiquidacion": "negativo",
                                    "comisionRetiro": "negativo",
                                    "retiroEmpresa": "negativo",
                                    "comisionSeguro": "negativo",
                                    "retiroParticipante": "negativo",
                                    "retiroParticipanteVol": "negativo",
                                    "retiroPagoExcedido": "negativo",
                                    "retiroExtraordinarias": "negativo",
                                    "saldoPrestamos": "negativo",
                                    "saldoPrepago": "positivo",
                                    "saldoComisiones": "negativo",
                                    "saldoRetiro": "negativo",
                                  };
 
  static Map<String, double> ingresos = {};
  static Map<String, double> egresos = {};
  static Map<String, Transaction> movsMes = {};
  static List<Chart> chartIngresos = [];
  static List<Chart> chartEgresos = [];

  List<Transaction> construyeDatosparaInterfaz(Map resumen) {
    List<Transaction> transacciones = [];
    String val;
    for (var element in orden) {
      resumen.forEach((key, value) {
        // debugPrint('$key ... $value');
        if(key!='permisos') {
          if(value is Map) {
            if(key == element) {
              value.forEach((llave, valor) {
                IconData icono = tipoEfecto['$llave']=='positivo' ? Icons.trending_up : Icons.trending_down; 
                if(llave == 'total' &&  (key=='saldoAportaciones'||key=='saldoIntereses'||key=='totalRecibido'||key=='total_ingresos')) icono=Icons.trending_up;
                // debugPrint('${'$key'} --- ${'$llave'}... $icono... $valor ...${isNumeric(valor)}');
                if(double.tryParse(valor)!=null) {
                  val = '${Utils.solonumeros.format(toDouble(valor))}';
                } else {
                  val = valor;
                }
                Transaction tr = Transaction(category:movAlias['$key'] ?? '$key', title:movAlias['$llave'] ?? '$llave', dateTime:'23 Feb, 10:36 PM', icon:icono, amount:'$val');
                transacciones.add(tr);
                // debugPrint('$key --- $llave ... $valor');
              });
            }
          }
        }
      });
    }
    return transacciones;
  }

  List<Transaction> generaTransacciones(Map movs) {
    ingresos = <String, double>{};
    egresos = <String, double>{};
    movsMes = <String, Transaction>{};

    List<Transaction> lista = [];
    debugPrint('Al Inicio generaTransacciones ...${movs.length}');
    movs.forEach((key, value) {
      if(key!='hora_actual') {
        // debugPrint('generaTransacciones ... $key ... $value');
        //----------- Para calular ingresos y egresos ----------------------
        String mes = movs['$key']['fecha'].substring(3,5);
        if( ingresos[mes] == null)  ingresos[mes] = 0.0;
        if( egresos[mes] == null)  egresos[mes] = 0.0;
        String valor = movs['$key']['valor'].replaceAll('\$','').replaceAll(',','').replaceAll(' ','');
        if(movs['$key']['signo'] == '+') {
          ingresos[mes] = (ingresos[mes] ?? 0.0) + toDouble(valor);
        } else if(movs['$key']['signo'] == '-') {
          egresos[mes] = (egresos[mes] ?? 0.0) + toDouble(valor);
        }
        //------------------------------------------------------------------
        IconData icono = Icons.trending_up;
        String cantidad = movs['$key']['valor'];
        if(movs['$key']['signo'] == '-') {
          icono = Icons.trending_down;
          cantidad = '-$cantidad';
        }
        lista.add(Transaction(category:'${movs['$key']['nombre_variable']}', title: '${movs['$key']['nombre_etiqueta']}', dateTime: '${movs['$key']['fecha']}', icon: icono, amount: cantidad));
        // lista.add(Transaction(category:'${movs['$key']['nombre_etiqueta']}', title: '${movs['$key']['nombre_etiqueta']}', dateTime: '${movs['$key']['fecha']}', icon: icono, amount: cantidad));
      }
    });

    lista = List.from(lista.reversed);
    if (lista.isNotEmpty) {
      lista = lista.sublist(0, lista.length > 20 ? 20 : lista.length);
    }
        //----------- Para calular Totales de Tipos de Movimientos del Mes ----------------------
        if (lista.isNotEmpty) {
          Transaction ultima = lista[0];
          String mesUltimo = ultima.dateTime.substring(3,5);
    //  debugPrint('mesUltimo ...$mesUltimo');
          for(int i=0; i<lista.length;i++) {
            Transaction tr = lista[i];
            if(lista[i].dateTime.substring(3,5)==mesUltimo) {
              if(movsMes[tr.title] == null) {
                movsMes[tr.title] = Transaction(
                  category: tr.category,
                  title: tr.title,
                  dateTime: tr.dateTime,
                  icon: tr.icon,
                  amount: '0'
                );
              }
              String valor = tr.amount.replaceAll('\$','').replaceAll(',','').replaceAll(' ','');
              String valorAnt = movsMes[tr.title]?.amount ?? '0';
              valorAnt = valorAnt.replaceAll('\$','').replaceAll(',','').replaceAll(' ','');
              double acumulado = toDouble(valorAnt) + toDouble(valor);
              if (movsMes[tr.title] != null) {
                movsMes[tr.title]!.amount = '$acumulado';
              }
            }
          }
        }
        //------------------------------------------------------------------
        // Utils().imprimeMap(ingresos);
        chartIngresos = Chart.creaChart(ingresos);
        chartEgresos = Chart.creaChart(egresos);
        reordenaMovimientosdleMes();
        // Utils().imprimeMap(egresos);
        // Utils().imprimeMapTransacciones(movsMes);


    // debugPrint('Al final de generaTransacciones ...$lista');
    return lista;
  }

  void reordenaMovimientosdleMes() {
    Utils().imprimeMap(movsMes);
    Map<String, Transaction> movsAJugar = {};
    movAlias.forEach((key, value) {
      movsMes.forEach((llave, valor) {
        if(movsMes[llave]?.category == key && movsMes[llave] != null) {
          movsAJugar[movsMes[llave]!.category] = movsMes[llave]!;
        }
      });
    });
    movsMes = movsAJugar;
  }
}