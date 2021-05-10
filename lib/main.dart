import 'package:flutter/material.dart';

import 'package:shake/shake.dart';
import './service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Dad Ball',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Home(title: 'Magic Dad Ball'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _service = Service();

  String _joke = "";
  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      print("SHAKE SHAKE");
      _service.getJoke().then((val) => setState(() {
            _joke = val;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text(
                  _joke,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              FloatingActionButton(
                onPressed: () async {
                  _joke = await _service.getJoke();
                  setState(() {});
                },
                child: Text("GET\nJoke"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
