import 'package:flutter/material.dart';
import './widgets/transaction_widget.dart';
import './widgets/new_transaction.dart';
import './models/transactions.dart';
import './widgets/chart_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expenses',
      theme: ThemeData(
          // it gives shading to different widgets
          primarySwatch: Colors.green,
          fontFamily: 'Quicksand',
          textTheme: TextTheme(
              titleMedium: TextStyle(
                  fontSize: 16.5,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String titleInput;

  String amountInput;

  final titlecontroller = TextEditingController();
  final List<Transactions> _userTranactions = [
    // Transactions(
    //   id: '01',
    //   title: "New Shoes",
    //   amount: 23.43,
    //   date: DateTime.now(),
    // ),
    // Transactions(
    //   id: '02',
    //   title: "Weekly Groceries",
    //   amount: 239.43,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transactions> get chartGivingTransactions {
    return _userTranactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList(growable: true);
  }

  void _newTransaction(String txTitle, double txAmount) {
    final newtx = Transactions(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );
    setState(() {
      _userTranactions.add(newtx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_newTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(chartGivingTransactions);
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        //adding button to app bar
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
            iconSize: 32,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChartWidget(chartGivingTransactions),
            TranactionWidget(_userTranactions),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
