import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shake/shake.dart';
import 'package:vibration/vibration.dart';
import './service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic Dad Jokes Ball',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'OpenSans',
      ),
      home: Home(title: 'MAGIC DAD JOKES BALL'),
      debugShowCheckedModeBanner: false,
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
      //VIBRATION
      Vibration.vibrate(pattern: [0, 200, 100, 200]);
      _service.getJoke().then((val) => setState(() {
            _joke = val;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontFamily: 'Anton',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[100],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(
                "images/8ball.jpg",
              ),
              fit: BoxFit.fitHeight,
            )),
          ),
          Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 160,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Container(
                        child: Image(
                            image: AssetImage('images/tri.png'), height: 260),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(130, 10, 130, 100),
                        child: Text(
                          _joke.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                    clipBehavior: Clip.antiAlias,
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: FloatingActionButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: _joke));
                          final snackBar = SnackBar(
                              content: Text(
                            'Copied to Clipboard!',
                            textAlign: TextAlign.center,
                          ));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Icon(Icons.copy, color: Colors.white),
                        backgroundColor: Colors.black54,
                        tooltip: 'Copy to Clipboard',
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.vibration,
                            color: Colors.white,
                          ),
                          Text(
                            " SHAKE THE DEVICE TO REVEAL A JOKE",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
