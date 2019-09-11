import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pstms/src/repos/Auth.Repos.dart';
import 'package:pstms/src/widgets/colorLoader.widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthRepos _auth = AuthRepos();
  final _formKey = GlobalKey<FormState>();
  String _name;
  String _password;
  bool _load = false;

  @override
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Color(0xFF2d3447), //or set color with: Color(0xFF0000FF)
    ));
    Widget loadingIndicator =_load? new Container(
      color: Colors.transparent,
      width: 70.0,
      height: 70.0,
      child: ColorLoader(radius: 15.0, dotRadius: 6.0,),
    ):new Container();

    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: Container(
        color: Color(0xFF2d3447),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 30.0),
                child: Image(image: AssetImage('assets/logo_1'), width: 150.0, height: 150.0),
              ),
              SizedBox(height: 15.0,),

              Text(
                'QUẢN LÝ CÔNG TÁC KIỂM TRA KỸ THUẬT,',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  'AN TOÀN VÀ PCCC',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: Text(
                  'Đăng nhập để tiếp tục sử dụng',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(.8),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.pink.withOpacity(.3),
                      width: .2,
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Tên đăng nhập',
                              labelStyle: TextStyle(
                                  color: Colors.black
                              ),
                              prefixStyle: TextStyle( color: Colors.black),
                              prefixIcon: Container(
                                width: 50,
                                child: Icon(Icons.account_circle,color: Colors.black,),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 11,
                                  ),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6)))),
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            if (val.length == 0)
                              return "Nhập tên đăng nhập";
                            else
                              return null;
                          },
                          onSaved: (val) => _name = val,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Mật khẩu',
                            labelStyle: TextStyle(
                                color: Colors.black
                            ),
                            hintStyle: TextStyle(color: Colors.black),
                            prefixIcon: Container(
                              width: 50,
                              child: Icon(Icons.security,color: Colors.black,),
                            ),
                            border: OutlineInputBorder(

                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 11,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(6))),
                          ),
                          obscureText: true,
                          validator: (val) {
                            if (val.length == 0)
                              return "Nhập mật khẩu";
                            else if (val.length < 6)
                              return "Mật khẩu không hợp lệ";
                            else
                              return null;
                          },
                          onSaved: (val) => _password = val,
                        ),


                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 40, 0, 20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: RaisedButton(
                              onPressed:() {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            _onLoginClick();
                              },
                              child: Text(
                                'Đăng nhập',
                                style: TextStyle(fontSize: 18, color: Colors.white),
                              ),
                              color: Color(0xff3277D8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(child: loadingIndicator,alignment: FractionalOffset.center,),
            ],
          ),
        ),
      ),
    );
  }

  void _showModalSheet() {
    showModalBottomSheet(context: context, builder: (builder) {
      return Container(
        height: MediaQuery.of(context).size.height/10 *2,
        child: Column(
          children: <Widget>[
            Icon(Icons.sentiment_very_dissatisfied, color: Colors.red, size: 60,),
            Container(
              padding: EdgeInsets.only(top: 8,bottom: 5),
              child: Text('Đăng nhập không thành công!',
                style: TextStyle( fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            Text('Xin vui lòng kiểm tra lại thông tin tài khoản',
              style: TextStyle( fontSize: 16),
            ),
          ],
        ),
      );
    });
  }

  void _onLoginClick() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _load = true;
      });

      _auth.signIn(_name, _password).then((result) {

        Timer(Duration(seconds: 2), () {
          if (result) {
            setState(() {
              _load = false;
            });
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            setState(() {
              _load = false;
            });
//            MsgDialog.showMsgDialog(
//                context, "Thông báo", 'Đăng nhập không thành công!');
            _showModalSheet();
          }
        });


      }
      );
    }
  }
}
