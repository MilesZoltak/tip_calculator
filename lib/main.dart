import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tip Calculator",
      home: TCPage(),
    );
  }
}

class TCPage extends StatefulWidget {
  @override
  _TCPageState createState() => _TCPageState();
}

class _TCPageState extends State<TCPage> {
  double _tipPercent = 15;
  String _entry = "";
  String _tipAmount = "";
  String _totalAmount = "";
  String _label = "";

  void update() {
    if (_entry.isEmpty) {
      _tipAmount = "";
      _totalAmount = _entry;
    } else {
      _tipAmount =
          (double.parse(_entry) * _tipPercent / 100).toStringAsFixed(2);
      _totalAmount =
          (double.parse(_entry) + double.parse(_tipAmount)).toStringAsFixed(2);
    }

    if (_tipPercent > 29) {
      _label = "🍆";
    } else if (_tipPercent > 25) {
      _label = "😍";
    } else if (_tipPercent > 20) {
      _label = "😃";
    } else if (_tipPercent > 15) {
      _label = "🙂";
    } else if (_tipPercent > 10) {
      _label = "😐";
    } else if (_tipPercent > 5) {
      _label = "😢";
    } else {
      _label = "😭";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Tip Calculator")),
        resizeToAvoidBottomPadding: false,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text("Base", style: TextStyle(fontSize: 26)),
                    ]),
                    Column(children: <Widget>[
                      SizedBox(
                          width: 100,
                          child: TextField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^(\d+)?\.?\d{0,2}'))
                              ],
                              onChanged: (String key) {
                                setState(() {
                                  _entry = key;
                                  update();
                                });
                              },
                              style: TextStyle(
                                fontSize: 26,
                              )))
                    ])
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text("${_tipPercent.floor()}%",
                          style: TextStyle(fontSize: 26))
                    ]),
                    Column(children: <Widget>[
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          valueIndicatorTextStyle: TextStyle(fontSize: 20)
                        ),
                      child: Slider(
                        value: _tipPercent,
                        min: 0,
                        max: 30,
                        divisions: 31,
                        label: _label,
                        onChanged: (double value) {
                          setState(() {
                            _tipPercent = value;
                            update();
                          });
                        },
                      ))
                    ])
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text("Tip", style: TextStyle(fontSize: 26))
                    ]),
                    Column(children: <Widget>[
                      Text(_tipAmount, style: TextStyle(fontSize: 26))
                    ])
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text("Total", style: TextStyle(fontSize: 26))
                    ]),
                    Column(children: <Widget>[
                      Text(_totalAmount, style: TextStyle(fontSize: 26))
                    ])
                  ]),
              SizedBox(height: 275),
              Text(
                "Made with <3 by Miles Zoltak",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              )
            ]));
  }
}
