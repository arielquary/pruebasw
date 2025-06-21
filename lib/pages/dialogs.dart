import 'package:flutter/material.dart';
import 'package:plurione_app/pages/assets.dart';
import 'package:plurione_app/pages/count_down_timer.dart';
import 'package:plurione_app/utils/network_image.dart';

class DialogsPage extends StatelessWidget {
  static final String path = "lib/pages/dialogs.dart";

  const DialogsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialogs'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            MaterialButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Payment Success"),
              onPressed: () => _paymentSuccessDialog(context),
            ),
            MaterialButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Alert Dialog"),
              onPressed: () => _alertDialog(context),
            ),
            MaterialButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Success Dialog"),
              onPressed: () => DialogsPage.customAlertDialog(context, AlertDialogType.SUCCESS, "Beautiful title", "Information to your user describing the situation." ),
            ),
            MaterialButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Info Dialog"),
              onPressed: () => DialogsPage.customAlertDialog(context, AlertDialogType.INFO, "Beautiful title", "Information to your user describing the situation." ),
            ),
            MaterialButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Warning Dialog"),
              onPressed: () => DialogsPage.customAlertDialog(context, AlertDialogType.WARNING, "Beautiful title", "Information to your user describing the situation." ),
            ),
            MaterialButton(
              color: Colors.lightGreen,
              colorBrightness: Brightness.light,
              child: Text("Error Dialog"),
              onPressed: () => DialogsPage.customAlertDialog(context, AlertDialogType.ERROR, "Beautiful title", "Information to your user describing the situation." ),
            ),
          ],
        ),
      ),
    );
  }

  _paymentSuccessDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PaymentSuccessDialog();
        });
  }

  _alertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BeautifulAlertDialog();
      },
    );
  }

  static void customAlertDialog(BuildContext context, AlertDialogType type, String titulo, String contenido) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          type: type,
          title: titulo,
          content: contenido,
        );
      },
    );
  }

  static void customAlertDialogClock(BuildContext context, AlertDialogType type, String titulo, String contenido, int segundos) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialogClock(
          type: type,
          title: titulo,
          content: contenido,
          tiempo: segundos,
        );
      },
    );
  }
}

class BeautifulAlertDialog extends StatelessWidget {
  const BeautifulAlertDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.only(right: 16.0),
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(75),
                  bottomLeft: Radius.circular(75),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 20.0),
              CircleAvatar(
                radius: 55,
                backgroundColor: Colors.grey.shade200,
                child: PNetworkImage(
                  infoIcon,
                  width: 60,
                ),
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Alert!",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10.0),
                    Flexible(
                      child: Text(
                          "Do you want to continue to turn off the services?"),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            color: Colors.red,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: const Text("No"),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: MaterialButton(
                            color: Colors.green,
                            colorBrightness: Brightness.dark,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            child: const Text("Yes"),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentSuccessDialog extends StatelessWidget {
  final String image = images[2];
  final TextStyle subtitle = const TextStyle(fontSize: 12.0, color: Colors.grey);
  final TextStyle label = const TextStyle(fontSize: 14.0, color: Colors.grey);
  
  PaymentSuccessDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 370,
        child: Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                const Text(
                  "Thank You!",
                  style: TextStyle(color: Colors.green),
                ),
                Text(
                  "Your transaction was successful",
                  style: label,
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "DATE",
                      style: label,
                    ),
                    Text("TIME", style: label)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[const Text("2, April 2019"), const Text("9:10 AM")],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "TO",
                          style: label,
                        ),
                        const Text("Manny Moto"),
                        Text(
                          "manny.moto@gmail.com",
                          style: subtitle,
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.green,
                      backgroundImage: AssetImage(image),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "AMOUNT",
                          style: label,
                        ),
                        const Text("\$ 15000"),
                      ],
                    ),
                    Text(
                      "COMPLETED",
                      style: label,
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    children: <Widget>[
                      const CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Icon(Icons.account_balance_wallet),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text("Credit/Debit Card"),
                          Text(
                            "Master Card ending ***5",
                            style: subtitle,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AlertDialogType {
  SUCCESS,
  ERROR,
  WARNING,
  INFO,
}

class CustomAlertDialog extends StatelessWidget {
  final AlertDialogType type;
  final String title;
  final String content;
  final Widget icon;
  final String buttonLabel;
  final TextStyle titleStyle = const TextStyle(
      fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);

  static IconData _getIconForTypeStatic(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.WARNING:
        return Icons.warning;
      case AlertDialogType.SUCCESS:
        return Icons.check_circle;
      case AlertDialogType.ERROR:
        return Icons.error;
      case AlertDialogType.INFO:
        return Icons.info_outline;
    }
  }

  static Color _getColorForTypeStatic(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.WARNING:
        return Colors.orange;
      case AlertDialogType.SUCCESS:
        return Colors.green;
      case AlertDialogType.ERROR:
        return Colors.red;
      case AlertDialogType.INFO:
      return Colors.blue;
    }
  }

  CustomAlertDialog({
    super.key,
    this.title = "Successful",
    required this.content,
    this.type = AlertDialogType.INFO,
    this.buttonLabel = "Ok"
  }) : icon = Icon(
        _getIconForTypeStatic(type),
        color: _getColorForTypeStatic(type),
        size: 50,
      );

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 10.0),
                icon,
                const SizedBox(height: 10.0),
                Text(
                  title,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                Divider(),
                
                Text(
                  content,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.0),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(buttonLabel),
                    onPressed: () => Navigator.pop(context, true),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CustomAlertDialogClock extends StatelessWidget {
  final AlertDialogType type;
  final String title;
  final String content;
  final int tiempo;
  final Widget? icon;
  final String buttonLabel;
  final TextStyle titleStyle = const TextStyle(
      fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);

  const CustomAlertDialogClock({
      super.key,
      this.title = "Successful",
      required this.content,
      this.icon,
      required this.tiempo,
      this.type = AlertDialogType.INFO,
      this.buttonLabel = "Ok"});

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Container(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: 10.0),
                icon ??
                    Icon(
                      _getIconForType(type),
                      color: _getColorForType(type),
                      size: 50,
                    ),
                const SizedBox(height: 10.0),
                Text(
                  title,
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const Divider(),
                
                Text(
                  content,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5.0),
                CountDownTimer(tiempo),
              ],
            ),
          ),
        ));
  }


  IconData _getIconForType(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.WARNING:
        return Icons.warning;
      case AlertDialogType.SUCCESS:
        return Icons.check_circle;
      case AlertDialogType.ERROR:
        return Icons.error;
      case AlertDialogType.INFO:
      return Icons.info_outline;
    }
  }

  Color _getColorForType(AlertDialogType type) {
    switch (type) {
      case AlertDialogType.WARNING:
        return Colors.orange;
      case AlertDialogType.SUCCESS:
        return Colors.green;
      case AlertDialogType.ERROR:
        return Colors.red;
      case AlertDialogType.INFO:
      return Colors.blue;
    }
  }
}
