import 'package:flutter/material.dart';
import 'package:pstms/src/widgets/colorLoader.widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
              children:<Widget>[
                ColorLoader(radius: 30.0, dotRadius: 8.0,),
//              Text('Loading', style: TextStyle(
//                color: Colors.white,fontSize: 20.0,
//              ),),
              ]
          ),

        ),
      ),
    );
  }
}
