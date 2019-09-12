import 'package:flutter/material.dart';
import 'package:pstms/src/models/Notification_v2.Model.dart';
import 'package:pstms/src/repos/Notification.Repos.dart';
import 'package:pstms/src/views/tATestComapny.page.dart';

class NotificationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationPageState();
  }
}

class NotificationPageState extends State<NotificationPage> {
  Future<List<Notification_v2>> _notifications;
  var refreshKey = new GlobalKey<RefreshIndicatorState>();

  void initState() {
    refreshList();
    super.initState();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      _notifications = getNotification();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xFF2d3447),
        centerTitle: true,
        title: Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            fontFamily: "Calibre-Semibold",
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Color(0xFF2d3447),
            ),
            child: RefreshIndicator(
              key: refreshKey,
              onRefresh: refreshList,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FutureBuilder(
                        future: _notifications,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              child: Center(
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.search,size: 80,color: Colors.white.withOpacity(0.6),),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Text('Đã nắm bắt tất cả thông báo',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white.withOpacity(0.6)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container(
                            child: snapshot.hasData
                                ? Expanded(
                                    child: ListView.builder(
                                        itemBuilder: (context, index) {
                                          final noti = snapshot.data;
                                          return Dismissible(
                                            key: Key(noti.toString()),
                                            onDismissed: (direction) {
                                              // Remove the item from the data source.
                                              setState(() {
                                                removeNotification(
                                                    noti[index].NotificationID);
                                                noti.removeAt(index);
                                              });
                                              // noti.removeAt(index);
                                              // Then show a snackbar.
                                              Scaffold.of(context)
                                                  .showSnackBar(SnackBar(
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                  'Đã xóa 1 thông báo',
                                                  style: TextStyle(
                                                      color: Colors.white.withOpacity(0.6),fontWeight: FontWeight.w700),
                                                ),
                                                duration: Duration(seconds: 1),
                                              ));
                                            },
                                            // Show a red background as the item is swiped away.
                                            background: Container(
                                              color: Colors.red,
                                              child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 10.0, right: 10.0),
                                                  padding: EdgeInsets.all(20.0),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 30.0,
                                                  )),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => TATestCompanyPage(id: noti[index].TATestDateID,title: "PHÂN CÔNG KIỂM TRA",)),
                                          );
                                              },
                                              child: Card(
                                                elevation: 8.0,
                                                margin:
                                                    new EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 6.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Color.fromRGBO(
                                                          64, 75, 96, .9)),
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.0,
                                                            vertical: 10.0),
                                                    leading: Container(
                                                      padding: EdgeInsets.only(
                                                          right: 12.0),
                                                      decoration: new BoxDecoration(
                                                          border: new Border(
                                                              right: new BorderSide(
                                                                  width: 1.0,
                                                                  color: Colors
                                                                      .white24))),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        radius: 25.0,
                                                        child: Icon(
                                                          Icons.notifications,
                                                          color: Colors.white,
                                                          size: 30.0,
                                                        ),
                                                      ),
                                                    ),
                                                    title: Text(
                                                      noti[index].Title,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                            flex: 2,
                                                            child: Text(
                                                                noti[index]
                                                                    .Body,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white70))),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: snapshot.data.length),
                                  )
                                : Container(
                                    //margin: EdgeInsets.only(top: 100.0),
                                    //alignment: Alignment.center,

                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                          );
                        }),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  final List<Notification_v2> noti;
  @override
  NotificationList({Key key, this.noti}) : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index) {
            final item = noti[index];
            return Dismissible(
              key: Key(item.toString()),
              onDismissed: (direction) {
                // Remove the item from the data source.
                //setState(() {
                removeNotification(noti[index].NotificationID);
                //});
                // noti.removeAt(index);
                // Then show a snackbar.
                Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.white70,
                    content: Text(
                      'Đã xóa 1 item',
                      style: TextStyle(color: Colors.black),
                    )));
              },
              // Show a red background as the item is swiped away.
              background: Container(
                color: Colors.red,
                child: Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10.0),
                    padding: EdgeInsets.all(20.0),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30.0,
                    )),
              ),
              child: Card(
                elevation: 8.0,
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 25.0,
                        child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                    title: Text(
                      noti[index].Title,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Expanded(
                            flex: 2,
                            child: Text(noti[index].Body,
                                style: TextStyle(color: Colors.white70))),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: noti.length),
    );
  }
}
