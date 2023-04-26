import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function addTransaction;
  NewTransaction(this.addTransaction);

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
              ),
              TextButton(
                onPressed: () {
                  addTransaction(titleController.text,
                      double.parse(amountController.text));
                },
                child: Text("Add Transaction"),
                style: TextButton.styleFrom(foregroundColor: Colors.purple),
              )
            ]),
      ),
    );
  }
}
