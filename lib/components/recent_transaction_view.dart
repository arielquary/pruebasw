import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plurione_app/components/plurione_progress_indicator.dart';
import 'package:plurione_app/models/sesion.dart';
import 'package:plurione_app/models/transaction.dart';
import 'package:plurione_app/pages/analytics_screen.dart';
import 'package:plurione_app/providers/data_provider.dart';

class RecentTransaction extends StatefulWidget {
  const RecentTransaction({super.key});

  @override
  RecentTransactionState createState() => RecentTransactionState();
}

class RecentTransactionState extends State<RecentTransaction> {
  final dataProvider = DataProvider();
  late Future<List<Transaction>> recentTransactions;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'Movimientos Recientes',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: listaMovimientos(),
          ),
        ],
      ),
    );
  }
  
  Widget listaMovimientos() {
    return FutureBuilder(
      future: obtenTransacciones(),
      builder: (context, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const PluriOneProgressIndicator();
          default:
            if(snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return crearListView(context, snapshot);
        }
      },
    );
  }

  Widget crearListView(BuildContext context, AsyncSnapshot<List<Transaction>> snapshot) {
    List<Transaction> values = snapshot.data ?? [];
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (context, index) {
        return _buildTransactionView(context, values[index]);
      }
    );
  } 
 
  Widget _buildTransactionView(BuildContext context, Transaction recentTransaction) {
   
    return InkWell(
      onTap: () {
        Get.to(const AnalyticsScreen());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18.0),
        height: 100.0,
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
            Icon(
              recentTransaction.icon,
              color: Colors.blueGrey[200],
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recentTransaction.title,
                    style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Text(
                        recentTransaction.dateTime,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueGrey[300]
                        ),
                      ),
                      const Spacer(),
                      Text(
                        recentTransaction.amount,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: (recentTransaction.amount.contains('-')
                              ? Colors.black
                              : Colors.green)
                        ),
                      ),
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

  Future<Map<String, dynamic>> consultaMovimientos() async {
    Map<String, dynamic> movs = await dataProvider.getDetalleMovimientos(
      '01/01/2019',
      '3',
      Sesion.miSesion.token
    );
    return movs;
  }

  Future<List<Transaction>> obtenTransacciones() async {
    Map movs = await consultaMovimientos();
    return Transaction().generaTransacciones(movs);
  }
}
