import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:trekax/helpers/style.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "images/lg.png",
              width: 200,
            ),
            Container(
                color: Colors.white,
                child: SpinKitFadingCircle(
                  color: black,
                  size: 30,
                )),
          ],
        ));
  }
}
