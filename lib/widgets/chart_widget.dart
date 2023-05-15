import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartWidget extends StatefulWidget {
  List<Transactions> recentTransaction;
  ChartWidget(this.recentTransaction);

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {
  TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);

  // List<ChartRequiredFields> _chartGivingData;

  // @override
  // void initState() {
  //   _chartGivingData = _listChartData;
  // }

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(
      7,
      (index) {
        // for getting the week day
        final weekDay = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;
        // loop to total sum of amount
        for (int i = 0; i < widget.recentTransaction.length; i++) {
          // making condition to check same date same month and same year
          if (widget.recentTransaction[i].date.day == weekDay.day // &&
              // recentTransaction[i].date.month == weekDay.month &&
              // recentTransaction[i].date.year == weekDay.year

              ) {
            totalSum += widget.recentTransaction[i].amount;
          }
        }

        return {
          "day": DateFormat.E().format(weekDay).substring(0, 1),
          "amount": totalSum
        };
      },
    ).reversed.toList();
  }

  List<ChartRequiredFields> get _listChartData {
    final List<ChartRequiredFields> list =
        List.generate(widget.recentTransaction.length, (index) {
      // for (int i = 0; i < widget.recentTransaction.length; i++){

      //   if(widget.recentTransaction[index].date == )

      // }
      return ChartRequiredFields(
          DateFormat.E().format(widget.recentTransaction[index].date),
          widget.recentTransaction[index].amount);
    }).toList();

    return list;
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as num);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_listChartData);
    // print(groupedTransactionValues);
    // print(name.substring(0, 1));
    return Card(
      color: Colors.transparent,
      elevation: 7,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: widget.recentTransaction.isNotEmpty
          ? SfCircularChart(
              tooltipBehavior: _tooltipBehavior,
              legend: Legend(isVisible: true),
              title: ChartTitle(
                  text: "Weekly Expense Chart - USD\$",
                  textStyle: TextStyle(fontWeight: FontWeight.bold)),
              series: <CircularSeries>[
                PieSeries<ChartRequiredFields, String>(
                    dataSource: _listChartData,
                    xValueMapper: (ChartRequiredFields data, _) => data.day,
                    yValueMapper: (ChartRequiredFields data, _) => data.amount,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                    ),
                    enableTooltip: true),
              ],
            )
          : Center(
              child: Text(
                "Welcome to Expenses Recorder App!\n\nHere you can record all your transactions and    payments safely. It can change your data into Charts with better understanding experience",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
    );
  }
}

class ChartRequiredFields {
  final String day;
  final double amount;
  ChartRequiredFields(this.day, this.amount);
}
