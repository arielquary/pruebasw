import 'package:flutter/material.dart';
import 'package:plurione_app/utils/utils.dart';
import 'package:string_validator/string_validator.dart';

class ResumenEstadoCuentaHeader extends StatefulWidget {
  final Map prefs;
  final Map resumen;

  const ResumenEstadoCuentaHeader(this.prefs, this.resumen, {super.key});

  @override
  _ResumenEstadoCuentaHeaderState createState() => _ResumenEstadoCuentaHeaderState();
}

class _ResumenEstadoCuentaHeaderState extends State<ResumenEstadoCuentaHeader> {
  double saldo = 0;
  
  @override
  void initState() {
    super.initState();
    saldo = toDouble(widget.resumen['total_ingresos']['total']) - toDouble(widget.resumen['total_egresos']['total']);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Resumen de Estado de Cuenta',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                color: Theme.of(context).primaryColor,
                boxShadow: [
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
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.resumen['nombre']}', 
                          style: TextStyle(
                            fontSize: 15.0, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.blueGrey[200]
                          ),
                          overflow: TextOverflow.ellipsis,
                        )
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Id ${widget.resumen['numero_empleado']}', 
                        style: TextStyle(
                          fontSize: 12.0, 
                          color: Colors.blueGrey[300]
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Saldo Neto', 
                        style: TextStyle(
                          fontSize: 10.0, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.blueGrey[200]
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        '${Utils.solonumeros.format(saldo)}', 
                        style: const TextStyle(
                          fontSize: 18.0, 
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
