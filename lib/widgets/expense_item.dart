import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final Function confirmDelete;

  ExpenseItem(this.expense, this.confirmDelete);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: ListTile(
        title: Text(
          expense.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        subtitle: Text(
          DateFormat('yMMMd').format(expense.date),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.green,
              width: 2.0,
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '\$${expense.amount.toStringAsFixed(2)}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ),
        onLongPress: () => confirmDelete(
          context,
          expense.id,
        ),
      ),
    );
  }
}
