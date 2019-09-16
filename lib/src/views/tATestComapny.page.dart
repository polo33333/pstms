import 'package:flutter/material.dart';
import 'package:pstms/src/models/TATestComapny.Model.dart';
import 'package:pstms/src/repos/TATestCompany.Repos.dart';

class TATestCompanyPage extends StatefulWidget {

  final int id;
  final String title;
  TATestCompanyPage({Key key, @required this.id,@required this.title}) : super(key: key);
  @override
  _TATestCompanyState createState() => _TATestCompanyState();
}



class _TATestCompanyState extends State<TATestCompanyPage> {

  var refreshKey = new GlobalKey<RefreshIndicatorState>();
  Future<List<TATestCompany>> list;


  void initState() {
    refreshList();

    super.initState();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      list= getTestCompany_ByTestDateID(widget.id);
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
                        Icons.location_on,
                        color: Colors.yellow,
                        size: 35.0,
                      ),
                    ),
                  ),
                  title: Text(
                    'VỊ TRÍ SẢN XUẤT',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            new FutureBuilder(
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
                        ?  TATestCompanyList(testCompany: snapshot.data)
                        : Container(
                      height: MediaQuery.of(context).size.height/10*6,
                      child: Center(child: CircularProgressIndicator()),
                    ),
                  );
                }),
          ],
        ),
        onRefresh: refreshList,
      ),
    );
  }
}




class TATestCompanyList extends StatelessWidget {
  final List<TATestCompany> testCompany;
  @override
  TATestCompanyList({Key key, this.testCompany}) : super(key: key);

  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {},
              child: Card(
                elevation: 8.0,
                //margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
                          Icons.home,
                          color: Colors.white,
                          size: 30.0,
                        ),
                      ),
                    ),
                    title: Text(
                      testCompany[index].CompanyName,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Trực thuộc: ${testCompany[index].DepartmentName}", style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            );
          },
          itemCount: testCompany.length),
    );
  }
}