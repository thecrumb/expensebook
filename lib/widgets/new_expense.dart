import 'package:flutter/material.dart';

class NewExpense extends StatelessWidget {
  final Function appendExpense;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewExpense(this.appendExpense);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  textColor: Colors.red,
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text('Add Expense'),
                  textColor: Colors.blue,
                  onPressed: () {
                    appendExpense(
                      titleController.text,
                      double.parse(amountController.text),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
