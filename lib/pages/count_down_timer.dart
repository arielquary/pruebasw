import 'dart:async';
import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final int tiempo;

  const CountDownTimer(this.tiempo, {super.key});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  late Timer _timer;
  late int _currentSeconds;

  @override
  void initState() {
    super.initState();
    _currentSeconds = widget.tiempo;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentSeconds > 0) {
        setState(() {
          _currentSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Tiempo restante: $_currentSeconds segundos',
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      ),
    );
  }
}