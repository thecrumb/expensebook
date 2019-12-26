import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  final Function appendExpense;

  NewExpense(this.appendExpense);

  @override
  _NewExpenseState createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitInput() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if ((enteredTitle.isNotEmpty) && (enteredAmount > 0)) {
      widget.appendExpense(
        enteredTitle,
        enteredAmount,
      );
    }

    Navigator.of(context).pop();
  }

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
              onSubmitted: (_) => submitInput(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitInput(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  textColor: Colors.red,
                  onPressed: () => Navigator.of(context).pop(),
                ),
                FlatButton(
                  child: Text('Add Expense'),
                  textColor: Colors.blue,
                  onPressed: submitInput,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
