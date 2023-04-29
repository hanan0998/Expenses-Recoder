import 'package:flutter/material.dart';
import '../models/transactions.dart';

class ChartWidget extends StatelessWidget {
  List<Transactions> recentTransaction;
  ChartWidget(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) => {"day": 'M', "amount": 99.99});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      // child: ,
    );
  }
}
