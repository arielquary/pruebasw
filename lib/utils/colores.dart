import 'package:flutter/material.dart';

class AppColors {
  static const Color colorPrincipal = Color(0xFF1565C0);

  Color obtenColor(String? colorString) {
    if (colorString == null) return colorPrincipal;
    
    switch (colorString.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.yellow;
      case 'purple':
        return Colors.purple;
      case 'orange':
        return Colors.orange;
      default:
        return colorPrincipal;
    }
  }
} 