import 'dart:core';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  final int seconds;
  final Text title;
  final Color backgroundColor;
  final TextStyle styleTextUnderTheLoader;
  final dynamic navigateAfterSeconds;
  final double photoSize;
  final dynamic onClick;
  final Image image;
  final Text loadingText;

  const SplashScreen({
    super.key,
    required this.seconds,
    this.photoSize = 100,
    this.onClick,
    this.navigateAfterSeconds,
    this.title = const Text(''),
    this.backgroundColor = Colors.white,
    this.styleTextUnderTheLoader = const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.black
    ),
    required this.image,
    this.loadingText = const Text(""),
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Ocultar el teclado al inicio
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    
    Timer(
      Duration(seconds: widget.seconds),
      () {
        if (widget.navigateAfterSeconds is String) {
          Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds as String);
        } else if (widget.navigateAfterSeconds is Widget) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => widget.navigateAfterSeconds as Widget
            )
          );
        } else {
          throw ArgumentError(
            'widget.navigateAfterSeconds must either be a String or Widget'
          );
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: widget.onClick,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: widget.backgroundColor,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: widget.photoSize,
                        child: widget.image,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      widget.title
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
