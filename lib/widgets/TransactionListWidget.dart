import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionListWidget extends StatelessWidget {
  const TransactionListWidget({
    Key key,
    @required this.userTransaction,
    @required this.delete,
  });

  final Transactions userTransaction;
  final Function delete;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      child: ListTile(
        leading: CircleAvatar(
          radius: 35,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
                child: Text("\$${userTransaction.amount.toStringAsFixed(2)}")),
          ),
        ),
        title: Text(
          "${userTransaction.title}",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(DateFormat.yMMMEd().format(userTransaction.date)),
        trailing: MediaQuery.of(context).size.width > 500
            ? TextButton.icon(
                onPressed: () => delete(userTransaction.id),
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
                  color: Theme.of(context).errorColor,
                ),
                onPressed: () => delete(userTransaction.id),
              ),
      ),
    );
  }
}
