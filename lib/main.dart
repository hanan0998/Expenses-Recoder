import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './widgets/transaction_widget.dart';
import './widgets/new_transaction.dart';
import './models/transactions.dart';
import './widgets/chart_widget.dart';
// contain  systemChrome class
import 'package:flutter/services.dart';

void main() {
  // necessary to intialilze flutter binding
  WidgetsFlutterBinding.ensureInitialized();
  // giving list PrefferedOrientations Layout
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
  runApp(MyApp());
}

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
          // errorColor: ,
          textTheme: TextTheme(
              titleMedium: TextStyle(
                  fontSize: 18,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold),
              titleSmall: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'OpenSans')),
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

  bool _showchart = false;

  List<Transactions> get chartGivingTransactions {
    return _userTranactions.where((element) {
      return element.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _newTransaction(String txTitle, double txAmount, DateTime selectedDate) {
    final newtx = Transactions(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: selectedDate,
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTranactions.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // checking is it landscape mode
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appbar = AppBar(
      title: Text('Personal Expenses'),
      //adding button to app bar
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
          iconSize: 32,
        ),
      ],
    );
    final Transactionscontainer = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.6,
        child: TranactionWidget(_userTranactions, _deleteTransaction));

    final chartcontainer = Container(
        height: (MediaQuery.of(context).size.height -
                appbar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.4,
        child: ChartWidget(chartGivingTransactions));
    // print(chartGivingTransactions);
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Show Chart'),
                  Switch(
                      value: _showchart,
                      onChanged: (val) {
                        setState(() {
                          _showchart = val;
                        });
                      })
                ],
              ),
            if (isLandscape)
              _showchart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          1,
                      child: ChartWidget(chartGivingTransactions))
                  : Container(
                      height: (MediaQuery.of(context).size.height -
                              appbar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.6,
                      child: TranactionWidget(
                          _userTranactions, _deleteTransaction)),
            if (!isLandscape) chartcontainer,
            if (!isLandscape) Transactionscontainer
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
