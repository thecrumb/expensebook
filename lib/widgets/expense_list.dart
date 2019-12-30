import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function removeExpense;

  ExpenseList(this.expenses, this.removeExpense);

  void _confirmDelete(BuildContext ctx, String id) {
    showDialog(
      context: ctx,
      builder: (bCtx) {
        return AlertDialog(
          title: Text('Delete?'),
//          content: Text(
//            '${expenses.where((expense) => expense.id == id).toList()[0].title}\n\$${expenses.where((expense) => expense.id == id).toList()[0].amount}',
//          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              textColor: Colors.red,
              onPressed: () => Navigator.of(bCtx).pop(),
            ),
            FlatButton(
              child: Text(
                'Confirm',
                style: TextStyle(fontWeight: FontWeight.bold),
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
                Text(
                  'You have no expenses!',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20.0),
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
              return Card(
                elevation: 3.0,
                child: ListTile(
                  title: Text(
                    expenses[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('yMMMd').format(expenses[index].date),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                        width: 2.0,
                      ),
                    ),
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '\$${expenses[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  onLongPress: () => _confirmDelete(
                    context,
                    expenses[index].id,
                  ),
                ),
              );
            },
            itemCount: expenses.length,
            physics: BouncingScrollPhysics(),
          );
  }
}
