// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transactions.dart';
import './TransactionListWidget.dart';

class TranactionWidget extends StatelessWidget {
  final List<Transactions> _userTransactions;
  final Function delete;
  TranactionWidget(@required this._userTransactions, @required this.delete);

  @override
  Widget build(BuildContext context) {
    return Container(
        // to calculate the available height dynamically with the help of Media query
        // height * 0.6 is to get the 60 percent of the device height
        // you can multiply the height and the width from the value between 1 to 0
        // 1 is to get full height and 0 is to get no height

        child: _userTransactions.isEmpty
            ? LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: <Widget>[
                      Text(
                        'No transactions added yet!',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'OpenSans',
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          // height: constraints.maxHeight * 0.6,
                          child: Icon(
                        Icons.nearby_error,
                        size: 150,
                        color: Colors.grey,
                      ))
                    ],
                  );
                },
              )
            : ListView(children: [
                ..._userTransactions.map((e) => TransactionListWidget(
                      key: ValueKey(e.id),
                      userTransaction: e,
                      delete: delete,
                    ))
              ]));
  }
}
