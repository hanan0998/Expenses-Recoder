import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionListWidget extends StatefulWidget {
  const TransactionListWidget({
    required Key key,
    required this.userTransaction,
    required this.delete,
  });

  final Transactions userTransaction;
  final Function delete;

  @override
  State<TransactionListWidget> createState() => _TransactionListWidgetState();
}

class _TransactionListWidgetState extends State<TransactionListWidget> {
  late Color bgColor = Colors.grey;
  @override
  void initState() {
    // const avaliablecolors = [
    //   Colors.green,
    //   Colors.red,
    //   Colors.amber,
    //   Colors.purple
    // ];
    // giving 4 max value  because 4 is excluded
    // bgColor = avaliablecolors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black54,
          radius: 35,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
                child: Text(
                    "\$${widget.userTransaction.amount.toStringAsFixed(2)}")),
          ),
        ),
        title: Text(
          "${widget.userTransaction.title}",
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'Quicksand',
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMEd().format(widget.userTransaction.date),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                onPressed: () => widget.delete(widget.userTransaction.id),
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                  // color: Theme.of(context).errorColor,
                ),
                label: const Text("Delete"))
            : IconButton(
                icon: Icon(
                  Icons.delete,
                  size: 30,
                  color: Theme.of(context).colorScheme.error,
                ),
                onPressed: () => widget.delete(widget.userTransaction.id),
              ),
      ),
    );
  }
}
