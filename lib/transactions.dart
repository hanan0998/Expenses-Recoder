// making the record of the transactions ( blue Print of Transaction data)

class Transactions {
  // use late keyword when you want to declare non nullable variable without initializing it
  late String id;
  late String title;
  late double amount;
  late DateTime date;
  Transactions(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
