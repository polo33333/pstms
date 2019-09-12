import 'package:flutter/material.dart';
import 'package:pstms/src/models/Employee.Model.dart';
import 'package:pstms/src/repos/Auth.Repos.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<AccountPage> {
  final AuthRepos _auth = AuthRepos();
  Future<Employee> _employee;

  void initState() {
    super.initState();

    _auth.getEmployeeInfo().then((result) {
      //print(result.EmployeeName);
      if (result.EmployeeName == null) {
        _auth.signOut();
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/login', (Route<dynamic> route) => false);
      }
      else{
        setState(() {
          _employee = _auth.getEmployeeInfo();
        });
      }
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
          'THÔNG TIN NGƯỜI DÙNG',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            fontFamily: "Calibre-Semibold",
            letterSpacing: 1.0,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[],
      ),
      body: Stack(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Color(0xFF2d3447),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FutureBuilder(
                    future: _employee,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(10.0),
                          alignment: Alignment.topCenter,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(64, 75, 96, .9)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.warning,
                                  color: Colors.yellow,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Không tải được dữ liệu',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ]),
                        );
                      }
                      return snapshot.hasData
                          ? _colunm(
                          name: snapshot.data.EmployeeName,
                          phone: snapshot.data.Phone,
                          email: snapshot.data.Email,
                          address: snapshot.data.Address)
                          : Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              ]),
        )
      ]),
    );
  }
}

class AccountList extends StatelessWidget {
  AccountList({this.title, this.subString, this.icon, this.circleColor});
  final String title;
  final String subString;
  final IconData icon;
  final Color circleColor;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: CircleAvatar(
              backgroundColor: circleColor,
              radius: 30.0,
              child: Icon(
                icon,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 2,
                  child:
                  Text(subString, style: TextStyle(color: Colors.white))),
            ],
          ),
        ),
      ),
    );
  }
}

class _colunm extends StatelessWidget {
  _colunm({this.name, this.phone, this.email, this.address});
  final String name, phone, email, address;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
//            SizedBox(
//              height: 80.0,
//            ),
        Center(
          child: CircleAvatar(
            backgroundColor: Colors.blue,
            radius: 45.0,
            child: Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 90.0,
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.all(25.0),
          alignment: Alignment.center,
          child: Text(
            name,
            style: TextStyle(color: Colors.white, fontSize: 30.0),
          ),
        ),

        AccountList(
            title: "Điện thoại liên lạc",
            subString: "Phone: $phone",
            circleColor: Colors.transparent,
            icon: Icons.phone_android),
        AccountList(
            title: "Email:",
            subString: "Mail: $email",
            circleColor: Colors.transparent,
            icon: Icons.email),
        AccountList(
            title: "Địa chỉ:",
            subString: "" + address,
            circleColor: Colors.transparent,
            icon: Icons.add_location),
      ],
    );
  }
}
