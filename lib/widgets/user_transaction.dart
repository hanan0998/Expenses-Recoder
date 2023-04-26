import 'package:flutter/material.dart';
import './new_transaction.dart';
import './transaction_widget.dart';
import '../models/transactions.dart';

class UserTransaction extends StatefulWidget {
  const UserTransaction({Key key}) : super(key: key);

  @override
  State<UserTransaction> createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transactions> _userTranactions = [
    Transactions(
      id: '01',
      title: "New Shoes",
      amount: 23.43,
      date: DateTime.now(),
    ),
    Transactions(
      id: '02',
      title: "Weekly Groceries",
      amount: 239.43,
      date: DateTime.now(),
    ),
  ];

  void _newTransaction(String txTitle, double txAmount) {
    final newtx = Transactions(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );
    setState(() {
      _userTranactions.add(newtx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(_newTransaction),
        TranactionWidget(_userTranactions),
      ],
    );
  }
}
