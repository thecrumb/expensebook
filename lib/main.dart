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
  final List<Expense> _userExpenses = [];

  List<Expense> get _recentExpenses {
    return _userExpenses.where((expense) {
      return expense.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addExpense(String titleInput, double amountInput, DateTime dateInput) {
    final currentExpense = Expense(
      id: DateTime.now().toString(),
      title: titleInput,
      amount: amountInput,
      date: dateInput,
    );

    setState(() {
      _userExpenses.add(currentExpense);
    });
  }

  void _openNewExpense(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: ctx,
      builder: (_) {
        return NewExpense(_addExpense);
      },
    );
  }

  void _deleteExpense(String expenseID) {
    setState(() {
      _userExpenses.removeWhere((expense) => expense.id == expenseID);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isPortrait = mediaQuery.orientation == Orientation.portrait;
    final appBar = AppBar(
      title: const Text(
        'expensebook',
        style: const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () => _openNewExpense(context),
        )
      ],
    );
    final availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: isPortrait
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: availableHeight * 0.3,
                    child: Chart(_recentExpenses, isPortrait),
                  ),
                  Container(
                    height: availableHeight * 0.7,
                    child: ExpenseList(_userExpenses, _deleteExpense),
                  ),
                ],
              )
            : Row(
                children: <Widget>[
                  Container(
                    height: availableHeight,
                    width: mediaQuery.size.width * 0.4,
                    child: Chart(_recentExpenses, isPortrait),
                  ),
                  Container(
                    height: availableHeight,
                    width: mediaQuery.size.width * 0.6,
                    child: ExpenseList(_userExpenses, _deleteExpense),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openNewExpense(context),
      ),
      floatingActionButtonLocation: isPortrait
          ? FloatingActionButtonLocation.centerFloat
          : FloatingActionButtonLocation.endFloat,
    );
  }
}
