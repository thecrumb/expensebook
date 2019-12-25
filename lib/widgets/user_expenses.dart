import 'package:flutter/material.dart';

import './expense_list.dart';
import './new_expense.dart';
import '../models/expense.dart';

class UserExpenses extends StatefulWidget {
  @override
  _UserExpensesState createState() => _UserExpensesState();
}

class _UserExpensesState extends State<UserExpenses> {
  final List<Expense> _userExpenses = [
    Expense(
      id: '1',
      title: 'Hotpot',
      amount: 16.99,
      date: DateTime.now(),
    ),
    Expense(
      id: '2',
      title: 'Eggs',
      amount: 7.99,
      date: DateTime.now(),
    ),
  ];

  void _addExpense(String titleInput, double amountInput) {
    final currentExpense = Expense(
      id: DateTime.now().toString(),
      title: titleInput,
      amount: amountInput,
      date: DateTime.now(),
    );

    setState(() {
      _userExpenses.add(currentExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewExpense(_addExpense),
        ExpenseList(_userExpenses),
      ],
    );
  }
}
