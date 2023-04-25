import 'package:expenses/transaction_widget.dart';
import 'package:flutter/material.dart';
import './transactions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final List<Transactions> transactions = [
    Transactions(
      id: 't1',
      title: 'New Car',
      amount: 4024.23,
      date: DateTime.now(),
    ),
    Transactions(
      id: 't2',
      title: 'New Laptop',
      amount: 599.23,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => TransWidget(tx: transactions[index]),
          itemCount: transactions.length,
        ));
  }
}
