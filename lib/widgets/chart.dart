import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/expense.dart';

class Chart extends StatelessWidget {
  final List<Expense> recentExpenses;
  final bool isPortrait;

  const Chart(this.recentExpenses, this.isPortrait);

  List<Map<String, Object>> get expensesPerDay {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;

      for (var i = 0; i < recentExpenses.length; i++) {
        if (recentExpenses[i].date.day == weekDay.day &&
            recentExpenses[i].date.month == weekDay.month &&
            recentExpenses[i].date.year == weekDay.year) {
          totalSum += recentExpenses[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get weekExpense {
    return expensesPerDay.fold(0.0, (prev, element) {
      return prev + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final chartContent = expensesPerDay.map((data) {
      return Flexible(
        fit: FlexFit.tight,
        child: ChartBar(
          data['day'],
          data['amount'],
          weekExpense == 0.0 ? 0.0 : (data['amount'] as double) / weekExpense,
          isPortrait,
        ),
      );
    }).toList();

    return Card(
      elevation: 6.0,
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: isPortrait
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: chartContent,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: chartContent,
              ),
      ),
    );
  }
}
