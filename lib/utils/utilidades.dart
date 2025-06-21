// ignore_for_file: library_prefixes
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;

import 'package:plurione_app/utils/colors.dart' as colores;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:plurione_app/components/progress_dialog.dart';


class Utilidades {
  /// Ejecuta el futuro y cuando regrese datos manda llamar la funcion funcion con los argumentos que vienen
  /// en los argumentos posicionales y nombrados regresando el Widget enviado en widget
  Widget cargaWidgetConFuncionPrevia(Future futuro, Widget widget, Function funcion, List? argsPosicionales, Map<Symbol, dynamic> argsNombrados) {
    return FutureBuilder(
      future: futuro,
      builder: (context, AsyncSnapshot snapshot) {
        // debugPrint(snapshot.connectionState);
        // debugPrint(snapshot.error);
        if (snapshot.hasData) {
          int pos = argsPosicionales != null
              ? argsPosicionales.indexWhere((e) => e == '#')
              : -1;
          if (pos != -1) argsPosicionales![pos] = snapshot.data;
          Function.apply(funcion, argsPosicionales, argsNombrados);
          return widget;
        } else {
          return const SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  /// Ejecuta el futuro y cuando regrese datos regresa el Widget enviado en widget
  Widget cargaWidgetDespuesFuture(Future futuro, Widget widget) {
    return FutureBuilder(
      future: futuro,
      builder: (context, AsyncSnapshot snapshot) {
        // debugPrint(snapshot.connectionState);
        // debugPrint(snapshot.error);
        if (snapshot.hasData) {
          return widget;
        } else {
          return const SizedBox(
            width: 10,
            height: 10,
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }

  /// Ejecuta el futuro y manda llamar a la Funcion funcion que regresa un Widget y que recibe
  /// el parametro del future en los argumentos posicionales y nombrados
  Widget cargaWidget(Future futuro, Function funcion, List? argsPosicionales, Map<Symbol, dynamic> argsNombrados) {
    return FutureBuilder(
      future: futuro,
      builder: (context, AsyncSnapshot snapshot) {
        // debugPrint(snapshot.connectionState);
        // debugPrint(snapshot.error);
        if (snapshot.hasData) {
          int pos = argsPosicionales != null
              ? argsPosicionales.indexWhere((e) => e == '#')
              : -1;
          if (pos != -1) argsPosicionales![pos] = snapshot.data;
          return Function.apply(funcion, argsPosicionales, argsNombrados);
        } else {
          return CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 13.0,
            animation: true,
            percent: 0.7,
            center: const Text("70.0%", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            footer: const Text("Sales this week",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),),
            circularStrokeCap: CircularStrokeCap.butt,
            progressColor: Colors.purple,
          );
        }
      },
    );
  }

  void snackbar(String msj, {String titulo = 'Error', Color color = Colors.red, Color colorText = Colors.white, int duracion = 3, }) {
    Get.snackbar(titulo, msj,
      titleText: Text(titulo, textScaler: const TextScaler.linear(1.0), style: TextStyle(color: colorText, fontFamily: 'Avenir', fontWeight: FontWeight.bold, fontSize: 18.sp),),
      messageText: Text(msj, textScaler: const TextScaler.linear(1.0), style: TextStyle(color: colorText, fontFamily: 'Avenir', fontWeight: FontWeight.normal, fontSize: 16.sp),),
      backgroundColor: color,
      duration: Duration(seconds: duracion),
      snackPosition: SnackPosition.BOTTOM,
      snackStyle: SnackStyle.FLOATING);
  }

  ProgressDialog progressDialog(BuildContext context, String text) {
    ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: false,
    );
    pr.style(
      message: text,
      borderRadius: 10.w,
      backgroundColor: Colors.white,
      padding: EdgeInsets.all(20.w),
      progressWidget: SizedBox(
        height: 20.w,
        width: 20.w,
        child: const CircularProgressIndicator(
          backgroundColor: colores.Colors.colorPrincipal,
          color:  colores.Colors.colorPrincipal,
          strokeWidth: 3,
        )
      ),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 17.sp, fontWeight: FontWeight.w600),
    );
    return pr;
  }

  Future<void> saveKeyInDevice(String key, String value) async {
    await GetStorage().write(key, json.encode(value));
  }

  dynamic readKeyFromDevice(String key) {
    if (containsKeyFromDevice(key)) {
      return json.decode(GetStorage().read(key));
    } else {
      return null;
    }
  }

  bool containsKeyFromDevice(String key) {
    return GetStorage().hasData(key);
  }

  Future<void> removeKeyFromDevice(String key) async {
    return await GetStorage().remove(key);
  }

  Map getAllKeysFromDevice() {
    Map map =
        Map.fromIterables(GetStorage().getKeys(), GetStorage().getValues());
    return map;
  }

  Future<void> saveImageInDevice(String key, AssetImage imagen) async {
    await GetStorage().write(key, imagen);
  }

  AssetImage? readImageFromDevice(String key) {
    if (containsKeyFromDevice(key)) {
      return GetStorage().read(key);
    } else {
      return null;
    }
  }

  /*utils para cadenas*/
  static String formatDuration(Duration value) {
    var days = 0;
    var hours = 0;
    var minutes = 0;
    var seconds = 0;
    var milliseconds = value.inMilliseconds;

    if (milliseconds > 0) {
      days = value.inDays;
      if (days > 0) {
        if (days == 1) {
          return '$days dia';
        }
        return '$days dias';
      }
      hours = value.inHours % 24;
      minutes = value.inMinutes % 60;
      seconds = value.inSeconds % 60;
      if (hours > 0) {
        return '${_zeroFormat(hours)}:${_zeroFormat(minutes)}:${_zeroFormat(seconds)}';
      }
      //milliseconds = value.inMilliseconds % 1000;
      return '${_zeroFormat(minutes)}:${_zeroFormat(seconds)}';
    } else {
      return '00:00';
    }
  }

  static String _zeroFormat(int number) {
    if (number >= 10) {
      return number.toString();
    } else {
      return '0$number';
    }
  }

  static String cadenaFechaPrueba() {
    DateTime dateTime = DateTime.now();
    return '${dateTime.add(const Duration(days: 0, minutes: 1, seconds: 20)).toString().substring(0, 16)}:00';
  }

  Future<void> saveNetworkImagetoLocal(String url, String nombreImagen) async {
    int statusCode = 0;
    try {
      final response = await http.get(Uri.parse(url));
      statusCode = response.statusCode;
      if (200 == response.statusCode) {
        // Get the image name
        // final imageName = path.basename(url);
        // Get the document directory path
        final appDir = await pathProvider.getApplicationDocumentsDirectory();

        // This is the saved image path. You can use it to display the saved image later
        final localPath = path.join(appDir.path, nombreImagen);

        // Downloading
        final imageFile = File(localPath);
        await imageFile.writeAsBytes(response.bodyBytes);
      } else {
        printError(info: '${response.statusCode}');
      }
    } catch (e) {
      e.printError(info: '$statusCode');
    }
  }

  Future<void> guardaDatosEnLocal(String nombreEmpresa, String imagenBlanca, String imagenColor, String colorFondo) async {
    await saveNetworkImagetoLocal(imagenBlanca, '${nombreEmpresa}Blanca.png');
    await saveNetworkImagetoLocal(imagenColor, '${nombreEmpresa}Color.png');
    // await saveKeyInDevice('colorFondo', colorFondo);
  }

  Future<Image> getLocalImage(String nombreImagen, double width) async {
    dynamic appDir = await pathProvider.getApplicationDocumentsDirectory();
    // This is the saved image path. You can use it to display the saved image later
    final localPath = path.join(appDir.path, nombreImagen);
    debugPrint('localPath... $localPath');
    File imageFile = File(localPath);
    if(await imageFile.exists()) {
      return Image.file(imageFile, width: width, fit: BoxFit.cover,);
    } else {
      return Image.asset('lib/assets/images/no_image.png', width: width, fit: BoxFit.cover,);
    }
  }

  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    Directory appDocDir = await pathProvider.getApplicationDocumentsDirectory();
    String imagesAppDirectory = appDocDir.path;
    final file =
        await File('$imagesAppDirectory/$path').create(recursive: true);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  Future<void> enviaCorreo(List<String> enviarA, List<String> conCopiaPara, List<String> conCopiaOcultaPara, List<String> atachments, String asunto, String bodyCorreo, bool esHTML) async {
    final Email email = Email(
      body: bodyCorreo,
      subject: asunto,
      recipients: enviarA,
      cc: conCopiaPara,
      bcc: conCopiaOcultaPara,
      attachmentPaths: atachments,
      isHTML: esHTML,
    );
    await FlutterEmailSender.send(email);
  }

  static Widget indicador() {
    return SizedBox(
        width: 1.sw,
        height: .4.sh,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
              height: .10.sw,
              width: .10.sw,
              child: const CircularProgressIndicator(
                strokeWidth: 6,
                color: Color.fromRGBO(52, 113, 127, 1),
              )),
        ));
  }

}
