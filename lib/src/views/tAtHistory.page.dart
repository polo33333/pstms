import 'package:flutter/material.dart';
import 'package:pstms/src/models/TestAssignment.Model.dart';
import 'package:pstms/src/repos/TestAssignment.Repos.dart';
import 'package:pstms/src/views/tATestDate.page.dart';

class TestAssignmentHistoryPage extends StatefulWidget {
  @override
  _TestAssignmentHistoryState createState() => _TestAssignmentHistoryState();
}

class _TestAssignmentHistoryState extends State<TestAssignmentHistoryPage> {
  var refreshKey = new GlobalKey<RefreshIndicatorState>();
  Future<List<TestAssignment>> telist;
  @override
  void initState() {
    refreshList();
    super.initState();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(milliseconds: 800));

    setState(() {
      telist = getTestAssignment_ByToken();
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
        title: Text(
          'LỊCH SỬ PHÂN CÔNG',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            fontFamily: "Calibre-Semibold",
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
//          IconButton(
//            icon: Icon(Icons.list),
//            onPressed: () {},
//          )
        ],
      ),
      body: Container(
        child: RefreshIndicator(
          key: refreshKey,
          onRefresh: refreshList,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: new FutureBuilder(
                    future: telist,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        if (snapshot.hasError) {
                          return Container(
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.dashboard,
                                    size: 80,
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child: Text(
                                      'Dữ liệu trống',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white.withOpacity(0.6)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                      return Container(
                        child: snapshot.hasData
                            ? TestAssignmentList(te: snapshot.data)
                            : Center(child: CircularProgressIndicator()),
                      );
                    }),
              ),
              SizedBox(
                height: 10.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TestAssignmentList extends StatelessWidget {
  final List<TestAssignment> te;
  @override
  TestAssignmentList({Key key, this.te}) : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TATestDatePage(
                          id: te[index].TestAssignmentID,
                          title: "LỊCH SỬ PHÂN CÔNG")),
                );
              },
              child: Card(
                elevation: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 5.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 25.0,
                          child: Icon(
                            Icons.work,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                      title: Text(
                        'Ban hành:  ${te[index].TestAssignmentDate}',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Loại: ${te[index].isPeriod}",
                          style: TextStyle(color: Colors.white)),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 30.0)),
                ),
              ),
            );
          },
          itemCount: te.length),
    );
  }
}
