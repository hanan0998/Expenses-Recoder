// making the record of the transactions ( blue Print of Transaction data)
import "package:flutter/foundation.dart";

class Transactions {
  // use late keyword when you want to declare non nullable variable without initializing it
  String id;
  String title;
  double amount;
  DateTime date;
  Transactions(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
