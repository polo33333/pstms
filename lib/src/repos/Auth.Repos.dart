import 'dart:convert';

import 'package:http/http.dart';
import 'package:pstms/src/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepos {
  Client client = Client();


  Future<bool> signIn(String name, String pass) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(FCM_token) ?? 'null';

    final response = await client.post(
      URL_SIGNIN,
      body: {'name': name, 'pass': pass, 'token': token},
    );

    Map<String, dynamic> mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      if (mapResponse["isSuccess"] == true) {
        prefs.setString('LOGIN','YES');
        print('SignIn:  Success to sign in');
        return true;
      }
      print('SignIn:  Faile to sign in');
      prefs.setString('LOGIN','NO');
      return false;
    }

    print('Connect-SignIn:  Failed to get data');
    return false;
  }

  Future<bool> checkIsAuthenticated () async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _auth = prefs.getString('LOGIN')?? 'NO';

    print('Authenticated:  '+_auth);
    if(_auth == 'YES')
      return true;
    return false;

  }

  Future<bool> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('LOGIN');

    return true;

  }

  Future<bool> changePassword(String rePass, String pass) async {


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(FCM_token);

    final response = await client.post(
      URL_CHANGEPASSWORD,
      body: {'rePassWord': rePass, 'pass': pass, 'token': token},
    );

    Map<String, dynamic> mapResponse = json.decode(response.body);

    if (response.statusCode == 200) {
      if (mapResponse["isSuccess"] == true) {
        print('changePassword:  Success');
        return true;
      }
      print('changePassword:  Faile');
      return false;
    }

    print('Connect:  Failed');
    return false;

  }


//  Future<Employee> getEmployeeInfo() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String token = prefs.getString(FCM_token);
//    int id = prefs.getInt(EmployeeId);
//
//    final response =
//    await client.get(URL_GETINFOEMPLOYEE+ token+'&&employeeId='+id.toString());
//
//    if (response.statusCode == 200) {
//      return Employee.fromJson(json.decode(response.body));
//    } else {
//      // If that response was not OK, throw an error.
//      throw Exception('Failed to load TestAssignment');
//      //return null;
//    }
//  }


  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _token = prefs.getString(FCM_token).toString();
    return _token;
  }
}
