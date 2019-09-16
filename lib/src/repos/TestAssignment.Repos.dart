//Fetch data from Restful API

import 'dart:convert';

import 'package:pstms/src/config/config.dart';
import 'package:pstms/src/models/TestAssignment.Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<TestAssignment> getTestAssignment_Lasets() async {


SharedPreferences prefs = await SharedPreferences.getInstance();
String token = prefs.getString(FCM_token)??'null';
final response =
await http.get(URL_TESTASSIGNMENT_LATEST + token);

if (response.statusCode == 200) {
// If server returns an OK response, parse the JSON.
print(TestAssignment.fromJson(json.decode(response.body)));
return TestAssignment.fromJson(json.decode(response.body));
} else {
// If that response was not OK, throw an error.
throw Exception('Failed to load TestAssignment');
}
}



//Fetch data from Restful API
Future<List<TestAssignment>> getTestAssignment_ByToken() async {

//  final AuthRepos _auth =  AuthRepos();
SharedPreferences prefs = await SharedPreferences.getInstance();
String token = prefs.getString(FCM_token)??'null';
//final response =
//await http.get(URL_TESTASSIGNMENT_BYTOKEN + token);
//List<TestAssignment> list = List();
//
//if (response.statusCode == 200) {
//// If server returns an OK response, parse the JSON.
//  list = (json.decode(response.body) as List)
//      .map((data) => new TestAssignment.fromJson(data))
//      .toList();
////print(list);
//
//  return list ;
//} else {
//// If that response was not OK, throw an error.
//  throw Exception('Failed to load TestAssignment');
//}

try{
  final response =
  await http.get(URL_TESTASSIGNMENT_BYTOKEN + token);
  List<TestAssignment> list = List();
  if (response.statusCode == 200) {
    list = (json.decode(response.body) as List)
        .map((data) => new TestAssignment.fromJson(data))
        .toList();
    if(list.length>0)
      return list ;
    return throw Exception('Failed to load TestAssignment null value');
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load TestAssignment');
    //return null;
  }
}
catch(_){
  throw Exception('Failed to load TestAssignment');
}
}


