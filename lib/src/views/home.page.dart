import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pstms/src/views/notification,page.dart';
import 'package:pstms/src/views/setting.page.dart';
import 'package:pstms/src/views/splashScreen.page.dart';
import 'package:pstms/src/views/tALatest.page.dart';
import 'package:pstms/src/views/tAtHistory.page.dart';

import 'account.page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xFF2d3447), //or set color with: Color(0xFF0000FF)
    ));
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomHeight = 50;
    final double bodyHeight =
        screenHeight - statusBarHeight - 60;

    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
            backgroundColor: Color(0xFF2d3447),
            automaticallyImplyLeading: false,
            title: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 5),
              child: Column(
                children: <Widget>[
                  Text(
                    'PSTMS',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Hệ thống quản lý phân công',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white.withOpacity(0.8),
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )),
      ),
      body: Column(children: <Widget>[
        Container(
          color: Colors.white,
          height: bodyHeight,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(3),
              children: <Widget>[
                makeDashboardItem(
                    "Phân công mới nhất", Icons.work, Colors.pink, TestAssignmentLatestPage()),
                makeDashboardItem(
                    "Lịch sử phân công", Icons.history, Colors.green, TestAssignmentHistoryPage()),
                makeDashboardItem(
                    "Thông báo", Icons.notifications_none, Colors.red, NotificationPage()),
                makeDashboardItem(
                    "Tài khoản", Icons.account_circle, Colors.deepPurple, AccountPage()),
                makeDashboardItem(
                    "Cài đặt", Icons.settings, Colors.blueGrey, SettingPage()),
                makeDashboardItem(
                    "Comming soon", Icons.add, Colors.indigo,null),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Card makeDashboardItem(
      String title, IconData icon, Color colorBox, Widget router) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: colorBox,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: new InkWell(
            onTap: () {
              if(router !=null)
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: router));

            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.white,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style: new TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w700)),
                )
              ],
            ),
          ),
        )
    );
  }
}
