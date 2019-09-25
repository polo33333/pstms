
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pstms/src/repos/SharedPreferences.Repos.dart';
import 'package:pstms/src/views/AboutPage.dart';
import 'package:pstms/src/views/account.page.dart';
import 'package:pstms/src/views/changePassword.page.dart';
import 'package:pstms/src/views/home.page.dart';
import 'package:pstms/src/views/login.page.dart';
import 'package:pstms/src/views/notification,page.dart';
import 'package:pstms/src/views/setting.page.dart';
import 'package:pstms/src/views/splashScreen.page.dart';
import 'package:pstms/src/views/tALatest.page.dart';
import 'package:pstms/src/views/tATestComapny.page.dart';
import 'package:pstms/src/views/tAtHistory.page.dart';

import 'config/config.dart';
import 'dart:io' show Platform;

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final SharedPreferencesRepos _preferencesRepos = SharedPreferencesRepos();
  final List<Message> messages = [];
  @override
  Future initState()  {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {

        final notification = message['notification'];

        setState(() {
          messages.add(Message(
              title: notification['title'], body: notification['body']));
        });


      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    _firebaseMessaging.getToken().then((token) async {
      print("tokenFCM: $token");

      _preferencesRepos.setString(FCM_token, token);
//      if (Platform.isAndroid) {
//        print('Runining Android plasform');
//        _preferencesRepos.setString(FCM_token, 'AND'+ token);
//      } else if (Platform.isIOS) {
//        print('Runining Ios plasform');
//        _preferencesRepos.setString(FCM_token, 'IOS'+ token);
//      }


    });
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PSTMS',
      theme: ThemeData(primaryColor: Colors.blue, backgroundColor: Colors.white),
      routes: <String,WidgetBuilder>{
        "/testAssignment_latest": (BuildContext context) => TestAssignmentLatestPage(),
        "/testAssignment_history": (BuildContext context) => TestAssignmentHistoryPage(),
        "/taTestCompany_detail": (BuildContext context) => TATestCompanyPage(),
        "/home": (BuildContext context) => HomePage(),
        "/setting": (BuildContext context) => SettingPage(),
        "/notification": (BuildContext context) => NotificationPage(),
        "/about": (BuildContext context) => AboutPage(),
        "/account": (BuildContext context) => AccountPage(),
        "/changePassword": (BuildContext context) => ChangePasswordPage(),
        "/login": (BuildContext context) => LoginPage(),


      },
      home: SplashScreen( router: null,),
      //home: HomePage(),
    );
  }

}

class Message {
  final String title;
  final String body;

  const Message({
    @required this.title,
    @required this.body,
  });
}

