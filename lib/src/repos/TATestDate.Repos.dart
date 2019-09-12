//Fetch data from Restful API

import 'dart:convert';

import 'package:pstms/src/config/config.dart';
import 'package:pstms/src/models/TATestData.Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<TATestDates>> getTestDate_ByTestAssignmentID( int id) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString(FCM_token)??'null';

  final response =
  await http.get(URL_GETTESTDATE_BYTASSIGNMENTID+ id.toString()+"&&token="+token);
  List<TATestDates> list = List();
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.

    list = (json.decode(response.body) as List)
        .map((data) => new TATestDates.fromJson(data))
        .toList();
    //print(list);

    return list ;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load TestAssignment');
  }
}


Future<List<TATestDates>> getTestDate_Lastes() async {

  //final AuthRepos _auth =  AuthRepos();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString(FCM_token)??'null';

  final response =
  await http.get(URL_TATESTDATE_LATEST+ token);
  List<TATestDates> list = List();
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.

    list = (json.decode(response.body) as List)
        .map((data) => new TATestDates.fromJson(data))
        .toList();
    //print(list);

    return list ;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load TestAssignment');
  }
}

