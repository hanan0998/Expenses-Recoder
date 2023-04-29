import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transactions.dart';
import 'package:intl/intl.dart';

class TranactionWidget extends StatelessWidget {
  final List<Transactions> _userTransactions;
  final Function delete;
  TranactionWidget(@required this._userTransactions, @required this.delete);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: _userTransactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                // Transactions tx = _userTransactions[index];
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FittedBox(
                            child: Text(
                                "\$${_userTransactions[index].amount.toStringAsFixed(2)}")),
                      ),
                    ),
                    title: Text(
                      "${_userTransactions[index].title}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(DateFormat.yMMMEd()
                        .format(_userTransactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 30,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => delete(_userTransactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: _userTransactions.length,
            ),
    );
  }
}
