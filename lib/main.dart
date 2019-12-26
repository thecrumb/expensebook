import 'package:flutter/material.dart';

import './models/expense.dart';
import './widgets/expense_list.dart';
import './widgets/new_expense.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'expensebook',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  void _openNewExpense(BuildContext ctx) {
    showModalBottomSheet(context: ctx, builder: (_) {
      return NewExpense(_addExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openNewExpense(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              child: Text('Chart'),
            ),
            ExpenseList(_userExpenses),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _openNewExpense(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
