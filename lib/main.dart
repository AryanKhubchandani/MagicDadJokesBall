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

class DrawTriangleShape extends CustomPainter {
  Paint painter;

  DrawTriangleShape() {
    painter = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
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
                  Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            height: 200,
                            width: 200,
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                "Hi",
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      CustomPaint(
                        size: Size(180, 180),
                        painter: DrawTriangleShape(),
                      ),
                    ],
                  ),
                  // CustomPaint(
                  //     size: Size(180, 180), painter: DrawTriangleShape()),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Text(
                      _joke,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 15,
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
        ],
      ),
    );
  }
}
