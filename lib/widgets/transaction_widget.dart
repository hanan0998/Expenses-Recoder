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
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (context, _index) {
                // Transactions tx = _userTransactions[index];
                return TransactionListWidget(
                  userTransaction: _userTransactions[_index],
                  delete: delete,
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
