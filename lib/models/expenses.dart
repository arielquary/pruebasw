
import 'package:flutter/material.dart';
import 'package:plurione_app/models/transaction.dart';

class Expenses {
  Expenses({
    required this.title,
    required this.icon,
    required this.amount, 
  });

  final String title;
  final IconData icon;
  final String amount;

  static List<Expenses> getAllExpenses() {
    List<Expenses> expenses = [
      Expenses(title: 'Aportaciones de la Empresa', icon: Icons.local_grocery_store, amount: '\$340'),
      Expenses(title: 'Aportaciones del Empleado', icon: Icons.shopping_basket, amount: '\$440'),
      Expenses(title: 'Intereses de Aportación de la Empresa', icon: Icons.local_taxi, amount: '\$289'),
      Expenses(title: 'Intereses de Aportación del Empleado', icon: Icons.local_cafe, amount: '\$567'),
      Expenses(title: 'Intereses de aPortaciones Voluntarias', icon: Icons.watch, amount: '\$240'),
      Expenses(title: 'Premio al Ahorro', icon: Icons.shopping_basket, amount: '\$440'),
    ];
    return expenses;
  }

  static List<Expenses> obtenMovimientosMes() {
    Map<String, Transaction> movsMes = Transaction.movsMes;
    List<Expenses> lista = [];
    movsMes.forEach((key, value) {
      lista.add(Expenses(title: '${value.title}', icon: value.icon, amount: value.amount));
    });
    return lista;
  }
}