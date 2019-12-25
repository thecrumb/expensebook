import 'package:flutter/material.dart';

import './expense.dart';

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

class MyHomePage extends StatelessWidget {
  final List<Expense> expenses = [
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
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            child: Text('Chart'),
          ),
          Column(
            children: expenses.map((expense) {
              return Card(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2.0,
                        ),
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Text(expense.amount.toString()),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          child: Text(expense.title),
                        ),
                        Container(
                          child: Text(expense.date.toString()),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
