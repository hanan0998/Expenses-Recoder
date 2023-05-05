import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io';

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

  final _titleController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitedData() {
    if (_amountController == null) {
      return;
    }
    final amount = double.parse(_amountController.text);
    final title = _titleController.text;
    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      // return statement ends the function execution
      return;
    }
    widget.addTransaction(_titleController.text, amount, _selectedDate);
    // to remove the uper screen
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              // giving 10 pixel more padding to to  jump form one field to other easily
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  // to save value
                  // onChanged: (val) {
                  //   titleInput = val;
                  // },
                  controller: _titleController,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  // both controller and onchange are to do same work
                  controller: _amountController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  // taking string in _ which is naming convention which means take the argument but dont't care
                  onSubmitted: (_) => submitedData(),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate == null
                        ? "No Date Chosen!"
                        : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}"),
                    SizedBox(
                      width: 10,
                    ),
                    // Adding Cuptertino Button for Ios devices
                    Platform.isIOS
                        ? CupertinoButton(
                            onPressed: _presentDatePicker,
                            child: Text(
                              "Choose Date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                        : TextButton(
                            onPressed: _presentDatePicker,
                            child: Text(
                              "Choose Date",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                  ],
                ),
                ElevatedButton(
                  onPressed: () => submitedData(),
                  child: Text("Add Transaction"),
                  style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                )
              ]),
        ),
      ),
    );
  }
}
