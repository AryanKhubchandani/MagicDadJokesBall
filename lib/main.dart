import 'package:flutter/material.dart';

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

  _HomeState() {
    _service.getJoke().then((val) => setState(() {
          _joke = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Text("Get Joke"),
                ElevatedButton(
                  onPressed: () async {
                    _joke = await _service.getJoke();
                    setState(() {});
                  },
                  child: Text("GET Joke"),
                ),
                Text('$_joke'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
