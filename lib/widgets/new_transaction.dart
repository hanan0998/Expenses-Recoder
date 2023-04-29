import 'package:flutter/material.dart';

// it is very important to convert it into statefull widget
class NewTransaction extends StatefulWidget {
  // we use contructor in the stateful widget not in state class
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  String titleInput;

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitedData() {
    final amount = double.parse(amountController.text);
    final title = titleController.text;
    if (title.isEmpty || amount <= 0) {
      // return statement ends the function execution
      return;
    }
    widget.addTransaction(
      titleController.text,
      amount,
    );
    // to remove the uper screen
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // to save value
                // onChanged: (val) {
                //   titleInput = val;
                // },
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // both controller and onchange are to do same work
                controller: amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                // taking string in _ which is naming convention which means take the argument but dont't care
                onSubmitted: (_) => submitedData(),
              ),
              TextButton(
                onPressed: () => submitedData(),
                child: Text("Add Transaction"),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor),
              )
            ]),
      ),
    );
  }
}
