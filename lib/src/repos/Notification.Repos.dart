import 'dart:convert';

import 'package:pstms/src/config/config.dart';
import 'package:pstms/src/models/Notification_v2.Model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<Notification_v2>> getNotification() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString(FCM_token)??'null';
 try{
   final response =
   await http.get(URL_GETNOTIFICATION + token);
   List<Notification_v2> list = List();
   if (response.statusCode == 200) {

     list = (json.decode(response.body) as List)
         .map((data) => new Notification_v2.fromJson(data))
         .toList();
     if(list.length>0)
       return list ;
     return throw Exception('Failed to load notifycation null value');
   } else {
     // If that response was not OK, throw an error.
     throw Exception('Failed to load notifycation');
     //return null;
   }
 }
 catch(_){
   throw Exception('Failed to load notifycation');
 }

}

Future<bool> removeNotification(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString(FCM_token)??'null';
  print(id);
  final response =
  await http.get(URL_REMOVENOTIFICATION+ id.toString()+"&&token="+ token);
  //Map<String, dynamic> mapResponse = json.decode(response.body);

  if (response.statusCode == 200) {

    return true ;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load TestAssignment');
    //return null;
  }
}