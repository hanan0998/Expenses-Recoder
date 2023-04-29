import 'package:flutter/material.dart';

class ChartBarWidget extends StatelessWidget {
  final String label;
  final double spendedAmount;
  final double spendingPctOfTotal;
  ChartBarWidget(this.label, this.spendedAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            height: 20,
            width: 23,
            child:
                FittedBox(child: Text("\$${spendedAmount.toStringAsFixed(0)}")),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(233, 225, 225, 1),
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(label)
        ],
      ),
    );
  }
}
