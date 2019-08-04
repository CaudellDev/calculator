import 'package:flutter/material.dart';
import 'dart:developer';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _temp = TextEditingController();
  TextEditingController _entryField  = TextEditingController();
  TextEditingController _resultField = TextEditingController();

  int doCalculation(String entry) {
    return 0;
  }

  void _onNumberPress(String number) {
    setState(() {
      String entry = _entryField.text + number;
      int result = doCalculation(entry);

      _entryField.text = entry;
      _resultField.text = result.toString();
    });
  }

  void _onOperationPress(String operation) {
    setState(() {
      _entryField.text = _entryField.text + operation;
      // Suggestive feature, perhaps?
    });
  }

  FlatButton createBtn(String btn) {
    RegExp number = RegExp(r"[0-9]");
    Function callback = btn.contains(number) ?
      ()=> _onNumberPress(btn) :
      ()=> _onOperationPress(btn);
    
    return FlatButton(
      child: Text(btn, style: TextStyle(fontSize: 32)),
      onPressed: callback,
    );
  }

  Row createPadRow(String p1, String p2, String p3) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        createBtn(p1),
        createBtn(p2),
        createBtn(p3),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: MediaQuery.of(context).padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.lightBlueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.teal,
                          child: TextField(
                            textAlign: TextAlign.end,
                            readOnly: true,
                            controller: _entryField,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            color: Colors.tealAccent,
                            child: TextField(
                              textAlign: TextAlign.end,
                              readOnly: true,
                              controller: _resultField,
                              style: TextStyle(fontSize: 42),
                            ),
                          ),
                        )
                      ],
                    )
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  color: Colors.tealAccent,
                  height: 1,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          createPadRow("7", "8", "9"),
                          createPadRow("4", "5", "6"),
                          createPadRow("1", "2", "3"),
                          createPadRow("0", ".", "="),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          createBtn("<"),
                          createBtn("/"),
                          createBtn("*"),
                          createBtn("-"),
                          createBtn("+"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _resultField.dispose();
    _entryField.dispose();
    _temp.dispose();
    super.dispose();
  }
}
