import 'package:flutter/material.dart';
import 'package:plurione_app/models/expenses.dart';
import 'package:plurione_app/utils/decorations.dart';

class ExpensesView extends StatefulWidget {
  const ExpensesView({super.key});

  @override
  ExpensesViewState createState() => ExpensesViewState();
}

class ExpensesViewState extends State<ExpensesView> {
  final List<Expenses> expenses = Expenses.obtenMovimientosMes();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
      height: 180.0,
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: expenses.length,
              itemBuilder: (context, index) => _buildCard(context, expenses[index]),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, Expenses expense) => Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        alignment: Alignment.centerLeft,
        decoration: getBoxDecoration(context),
        width: 120.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(expense.icon, color: Colors.blueGrey[200]),
            const SizedBox(height: 15.0),
            Text(
              expense.title,
              style: TextStyle(fontSize: 13.0, color: Colors.blueGrey[200]),
            ),
            const SizedBox(height: 3.0),
            Text(
              expense.amount,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
}
