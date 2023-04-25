// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import './transactions.dart';

class TransWidget extends StatelessWidget {
  Transactions tx;
  TransWidget({
    Key? key,
    required this.tx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Row(
        children: [
          Container(
              width: 90,
              height: 50,
              child: Center(
                child: Text(
                  '\$${tx.amount}',
                  // textAlign: TextAlign.center,
                ),
              )),
          Column(
            children: <Text>[Text(tx.title), Text(tx.date.toString())],
          )
        ],
      ),
    );
  }
}
