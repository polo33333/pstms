import 'package:flutter/material.dart';
import 'package:pstms/src/models/TATestData.Model.dart';
import 'package:pstms/src/models/TestAssignment.Model.dart';
import 'package:pstms/src/repos/TATestDate.Repos.dart';
import 'package:pstms/src/repos/TestAssignment.Repos.dart';
import 'package:pstms/src/views/tATestComapny.page.dart';

class TestAssignmentLatestPage extends StatefulWidget {
  @override
  _TestAssignmentLastState createState() => _TestAssignmentLastState();
}

class _TestAssignmentLastState extends State<TestAssignmentLatestPage> {
  var refreshKey = new GlobalKey<RefreshIndicatorState>();
  Future<List<TATestDates>> taTestDates;
  Future<TestAssignment> testAssignment;
  @override
  void initState() {
    refreshList();
    super.initState();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(milliseconds: 800));

    setState(() {
      testAssignment = getTestAssignment_Lasets();
      taTestDates = getTestDate_Lastes();
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
          'PHÂN CÔNG MỚI NHẤT',
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
              FutureBuilder<TestAssignment>(
                future: testAssignment,
                builder: (context, snapshot) {
                  return Container(
                    child: snapshot.hasData
                        ? Column(
                      children: <Widget>[
                        Card(
                          elevation: 8.0,
                          margin: new EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 6.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(64, 75, 96, .9)),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              leading: Container(
                                padding: EdgeInsets.only(right: 12.0),
                                decoration: new BoxDecoration(
                                    border: new Border(
                                        right: new BorderSide(
                                            width: 1.0,
                                            color: Colors.white24))),
                                child: Icon(
                                  Icons.work,
                                  color: Colors.yellow,
                                  size: 30.0,
                                ),
                              ),
                              title: Text(
                                "Phân công kiểm tra",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                        'Ngày ban hành: ${snapshot.data.TestAssignmentDate}',
                                        style: TextStyle(
                                            color: Colors.white)),
                                  ),
                                  Text(" Loại: ${snapshot.data.isPeriod}",
                                      style:
                                      TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "NGÀY KIỂM TRA",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ],
                    )
                        : Center(child: Text('')),
                  );
                },
              ),
              Container(
                child: new FutureBuilder(
                    future: taTestDates,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.work,size: 80,color: Colors.white.withOpacity(0.6),),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  child: Text('Dữ liệu trống',
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
                            ? TATestDatetList(TAtest: snapshot.data)
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

class TATestDatetList extends StatelessWidget {
  final List<TATestDates> TAtest;
  @override
  TATestDatetList({Key key, this.TAtest}) : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TATestCompanyPage(
                        id: TAtest[index].TATestDateID,
                        title: "PHÂN CÔNG MỚI NHẤT",
                      )),
                );
              },
              child: Card(
                //elevation: 8.0,
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration:
                  BoxDecoration(
                      color: Color.fromRGBO(64, 75, 96, .9)
                    //color: Colors.white
                  ),
                  child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 25.0,
                          child: Icon(
                            Icons.timer,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                      ),
                      title: Text(
                        TAtest[index].TATestDate,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 30.0)),
                ),
              ),
            );
          },
          itemCount: TAtest.length),
    );
  }
}
