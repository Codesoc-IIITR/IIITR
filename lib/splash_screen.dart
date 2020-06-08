import 'dart:async';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  static  const String id = 'SplashScreen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.black26),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.school,
                          color: Colors.blue,
                          size: 65.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      // Text(
                      //   "IIITR Dashboard",
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 24.0),
                      // )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                      //  Image.asset('images/iiitr_logo.png'),
                        SizedBox(
                         height: 50.0,
                        ),
                        SpinKitThreeBounce(
                          color: Colors.white,
                          size: 30.0,
                        ),
//                        SizedBox(
//                          height: 10.0,
//                        ),
//                        Text('IIIT RAICHUR'),
                      ],
                    ),
                  ),
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    CircularProgressIndicator(),
//                    Padding(
//                      padding: EdgeInsets.only(top: 20.0),
//                    ),
//                    Text(
//                      "IIITR Application",
//                      softWrap: true,
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                          fontWeight: FontWeight.bold,
//                          fontSize: 18.0,
//                          color: Colors.white),
//                    )
//                  ],
//                ),
              )
            ],
          )
        ],
      ),
    );
  }
}