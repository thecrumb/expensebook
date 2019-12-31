import 'package:flutter/material.dart';

import '../models/expense.dart';
import './expense_item.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function removeExpense;

  const ExpenseList(this.expenses, this.removeExpense);

  void _confirmDelete(BuildContext ctx, String id) {
    showDialog(
      context: ctx,
      builder: (bCtx) {
        return AlertDialog(
          title: const Text('Delete?'),
          actions: <Widget>[
            FlatButton(
              child: const Text(
                'Cancel',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.red,
              onPressed: () => Navigator.of(bCtx).pop(),
            ),
            FlatButton(
              child: const Text(
                'Confirm',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.blue,
              onPressed: () {
                removeExpense(id);
                Navigator.of(bCtx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return expenses.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                const Text(
                  'You have no expenses!',
                  style: const TextStyle(fontSize: 20.0),
                ),
                const SizedBox(height: 20.0),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              return ExpenseItem(expenses[index], _confirmDelete);
            },
            itemCount: expenses.length,
            physics: const BouncingScrollPhysics(),
          );
  }
}
