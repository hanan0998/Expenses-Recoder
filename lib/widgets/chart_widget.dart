import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class ChartWidget extends StatelessWidget {
  List<Transactions> recentTransaction;
  ChartWidget(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        // for getting the week day
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;
        // loop to total sum of amount
        for (int i = 0; i < recentTransaction.length; i++) {
          // making condition to check same date same month and same year
          if (recentTransaction[i].date.day == weekDay.day // &&
              // recentTransaction[i].date.month == weekDay.month &&
              // recentTransaction[i].date.year == weekDay.year

              ) {
            totalSum += recentTransaction[i].amount;
          }
        }
        print(DateFormat.E().format(weekDay));
        print(totalSum);
        return {"day": DateFormat.E().format(weekDay), "amount": totalSum};
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      // child: ,
    );
  }
}
