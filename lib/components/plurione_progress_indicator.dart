import 'package:flutter/material.dart';

class PluriOneProgressIndicator extends StatelessWidget {
  const PluriOneProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(255, 255, 255, .1),
      height: double.infinity,
      width: double.infinity,
      child: Image.asset('lib/assets/images/plurionegirando.gif', scale: 3),
    );
  }
}