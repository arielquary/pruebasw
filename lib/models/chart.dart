class Chart {
  Chart({
    required this.title,
    required this.height,
    required this.valor,
  });

  final String title;
  final double height;
  final String valor;

  static Map<String, String> meses = { "01" : "Ene",
                                "02" : "Feb",
                                "03" : "Mar",
                                "04" : "Abr",
                                "05" : "May",
                                "06" : "Jun",
                                "07" : "Jul",
                                "08" : "Ago",
                                "09" : "Sep",
                                "10" : "Oct",
                                "11" : "Nov",
                                "12" : "Dic",
                              };

  static List<Chart> creaChart(Map<String, double> ingresos) {
    double mayor = 0;
    List<Chart> lista = [];
    ingresos.forEach((key, value) {
      if(mayor < value) mayor = value;
    });
    ingresos.forEach((key, value) {
      lista.add(Chart(
        title: '${meses[key]}',
        height: value*180/mayor,
        valor: '$value'
      ));
    });
    return lista;
  }
}