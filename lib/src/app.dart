
import 'package:flutter/material.dart';
import 'package:pstms/src/views/AboutPage.dart';
import 'package:pstms/src/views/home.page.dart';
import 'package:pstms/src/views/login.page.dart';
import 'package:pstms/src/views/notification,page.dart';
import 'package:pstms/src/views/setting.page.dart';
import 'package:pstms/src/views/splashScreen.page.dart';


class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {


  @override
  Future initState()  {
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PSTMS',
      theme: ThemeData(primaryColor: Colors.blue, backgroundColor: Colors.white),
      routes: <String,WidgetBuilder>{
        "/home": (BuildContext context) => HomePage(),
        "/setting": (BuildContext context) => SettingPage(),
        "/notification": (BuildContext context) => NotificationPage(),
        "/about": (BuildContext context) => AboutPage(),
        "/login": (BuildContext context) => LoginPage(),


      },
      home: LoginPage(),
    );
  }

}
