import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pstms/src/repos/Auth.Repos.dart';
import 'package:pstms/src/widgets/colorLoader.widget.dart';

class SplashScreen extends StatefulWidget {
  final String router;
  SplashScreen({Key key, @required this.router}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthRepos _auth = new AuthRepos();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _auth.checkIsAuthenticated().then((result) {
        //print("sp" + result.toString());
        if (result == true) {
          if (widget.router != null) {
            Timer(Duration(seconds: 3), () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  widget.router, (Route<dynamic> route) => false);
            });
          } else {
            Timer(Duration(seconds: 3), () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            });

          }
        } else
          Timer(Duration(seconds: 3), () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF2d3447),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            ColorLoader(
              radius: 30.0,
              dotRadius: 8.0,
            ),
          ]),
        ),
      ),
    );
  }
}
