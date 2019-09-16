import 'package:flutter/material.dart';
import 'package:pstms/src/models/TATestData.Model.dart';
import 'package:pstms/src/repos/TATestDate.Repos.dart';
import 'package:pstms/src/views/tATestComapny.page.dart';



class TATestDatePage extends StatefulWidget {

  final int id;
  final String title;
  TATestDatePage({Key key, @required this.id, @required this.title}) : super(key: key);
  @override
  _TATestDateState createState() => _TATestDateState();
}



class _TATestDateState extends State<TATestDatePage> {

  var refreshKey = new GlobalKey<RefreshIndicatorState>();
  Future<List<TATestDates>> list;


  void initState() {
    refreshList();

    super.initState();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      list= getTestDate_ByTestAssignmentID(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xFF2d3447),
        title: Text(
          widget.title,
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
      body: RefreshIndicator(
        key: refreshKey,
        child: Column(
          children: <Widget>[
            Card(
              elevation: 8.0,
              //margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: Container(
                decoration:
                BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  leading: Container(
                    padding: EdgeInsets.only(right: 5.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 25.0,
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.yellow,
                        size: 35.0,
                      ),
                    ),
                  ),
                  title: Text(
                    'NGÀY KIỂM TRA',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            FutureBuilder(
                future: list,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Container(
                      height: MediaQuery.of(context).size.height/10*6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.search,size: 80,color: Colors.white.withOpacity(0.6),),
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
                        ],
                      )
                    );
                  }
                  return Container(
                    child: snapshot.hasData
                        ?  TATestDatetList(ta: snapshot.data,title: widget.title,)
                        : Container(
                      height: MediaQuery.of(context).size.height/10*6,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),

        onRefresh: refreshList,
      ),
    );
  }
}




class TATestDatetList extends StatelessWidget {
  final List<TATestDates> ta;
  final String title;
  @override
  TATestDatetList({Key key, this.ta, this.title}) : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TATestCompanyPage(id: ta[index].TATestDateID,title: title,)),
                );
              },
              child: Card(
                elevation: 8.0,
                //margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 25.0,
                        child: Icon(
                          Icons.timelapse,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                    title: Text(
                      ta[index].TATestDate,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.white, size: 30.0
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: ta.length),
    );
  }
}