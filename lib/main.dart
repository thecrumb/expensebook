import 'package:flutter/material.dart';

import './models/expense.dart';
import './widgets/chart.dart';
import './widgets/expense_list.dart';
import './widgets/new_expense.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'expensebook',
      theme: ThemeData(
        fontFamily: 'Quicksand',
      ),
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
      title: 'Test',
      amount: 19.99,
      date: DateTime.now(),
    )
  ];

  List<Expense> get _recentExpenses {
    return _userExpenses.where((expense) {
      return expense.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

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
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewExpense(_addExpense);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openNewExpense(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(_recentExpenses),
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
