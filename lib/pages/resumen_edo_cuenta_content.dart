import 'package:flutter/material.dart';
import 'package:plurione_app/models/transaction.dart';
import 'package:plurione_app/pages/expansion_tile2.dart';

class ResumenEdoCuentaContent extends StatefulWidget {

  final Map datos;
  final Map resumen;

  const ResumenEdoCuentaContent(this.datos, this.resumen, {super.key});

  @override
  _ResumenEdoCuentaContentState createState() => _ResumenEdoCuentaContentState();
}

class _ResumenEdoCuentaContentState extends State<ResumenEdoCuentaContent> {

  late final List<Transaction> data;

  @override
  void initState() {
    super.initState();
    data = Transaction().construyeDatosparaInterfaz(widget.resumen);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView(
              children: construyeListView(context, data),
            ),
          ),
      ],
      ),
    );
  }

  List<Widget> construyeListView(BuildContext context, List<Transaction> data) {
    List<Widget> listaWidgets = <Widget>[];
    List<Transaction> lista = <Transaction>[];
    Transaction encabezado = data[0];

    for (int i = 1; i < data.length; i++) {
      if(encabezado.category == data[i].category) {
        if( data[i].title != 'formula') lista.add(data[i]);
      } else {
        if(encabezado.category!='Total de Ingresos'&&encabezado.category!='Total de Egresos') {
           listaWidgets.add(_buildTransactionExpansionTiles(context, lista, encabezado));
        } else {
          listaWidgets.add(_muestraTotales(context, encabezado));
        }
        lista = <Transaction>[];
        encabezado = data[i];
      }
    }
    if(encabezado.category!='Total de Ingresos'&&encabezado.category!='Total de Egresos') {
      listaWidgets.add(_buildTransactionExpansionTiles(context, lista, encabezado));
    }
    else {
      listaWidgets.add(_muestraTotales(context, encabezado));
    }
    return listaWidgets;
    }
    
  Widget _muestraTotales(BuildContext context, Transaction transcaccion) =>
    Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).primaryColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(3, 5),
            color: Colors.black12,
            blurRadius: 10,
          ),
          BoxShadow(
            offset: Offset(-1, -1),
            color: Colors.white,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 30.0),
          Icon(
            transcaccion.icon,
            color: Colors.greenAccent,
          ),
          const SizedBox(width: 10.0),
          Text(
            transcaccion.category,
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          Text(
            transcaccion.amount,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: (transcaccion.amount.contains('-')
                  ? Colors.black
                  : Colors.green)
            ),
          ),
          const SizedBox(width: 5.0),
        ],
      ),
    );
    
  Widget _buildTransactionView(BuildContext context, Transaction transcaccion) =>
    Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).primaryColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(3, 5),
            color: Colors.black12,
            blurRadius: 10,
          ),
          BoxShadow(
            offset: Offset(-1, -1),
            color: Colors.white,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.05,
            child: Icon(
              transcaccion.icon,
              color: Colors.blueGrey[200],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.50,
            child: Text(
              transcaccion.title,
              style: const TextStyle(fontSize: 11.0),
              overflow: TextOverflow.visible,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.20,
            child: Text(
              transcaccion.amount,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12.0,
                color: (transcaccion.amount.contains('-')
                    ? Colors.black
                    : Colors.green)
              ),
            ),
          ),
          const SizedBox(width: 5.0),
        ],
      ),
    );
    
  Widget _buildTransactionExpansionTiles(BuildContext context, List<Transaction> elementos, Transaction encabezado) =>
    Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 1.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Theme.of(context).primaryColor,
        boxShadow: const [
          BoxShadow(
            offset: Offset(3, 5),
            color: Colors.black12,
            blurRadius: 10,
          ),
          BoxShadow(
            offset: Offset(-1, -1),
            color: Colors.white,
            blurRadius: 6,
          ),
        ],
      ),
      child: ExpansionTile2(
        backgroundColor: Colors.blueGrey[50],
        title: construyeTitulo(context, encabezado),
        tilePadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
        children: contruyeElementos(context, elementos),
      ),
    );
    
  Widget construyeTitulo(BuildContext context, Transaction encabezado) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          encabezado.icon,
          color: Colors.blueGrey[200],
        ),
        const SizedBox(width: 5.0),
        Text(
          encabezado.category,
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
          overflow: TextOverflow.ellipsis,
        ),
        const Spacer(),
        Text(
          encabezado.amount,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: (encabezado.amount.contains('-')
                ? Colors.black
                : Colors.green)
          ),
        ),
        const SizedBox(width: 1.0),
      ],
    );
    
  List<Widget> contruyeElementos(BuildContext context, List<Transaction> transacciones) {
    List<Widget> lista = <Widget>[];
    for (var element in transacciones) {
      lista.add(_buildTransactionView(context, element));
    }
    return lista;
  }
    
}