import 'package:http/http.dart' as http;
import 'package:pstms/src/config/config.dart';
import 'dart:convert';
import 'package:pstms/src/models/TATestComapny.Model.dart';




//Fetch data from Restful API

Future<List<TATestCompany>> getTestCompany_ByTestDateID( int id) async {


//  final response =
//  await http.get(URL_TESTCOMPANY_BYTESTDATEID+ id.toString());
//  List<TATestCompany> list = List();
//  if (response.statusCode == 200) {
//    // If server returns an OK response, parse the JSON.
//
//    list = (json.decode(response.body) as List)
//        .map((data) => new TATestCompany.fromJson(data))
//        .toList();
//    //print(list);
//
//    return list ;
//  } else {
//    // If that response was not OK, throw an error.
//    throw Exception('Failed to load TATestCompany');
//  }

  try{
    final response =
    await http.get(URL_TESTCOMPANY_BYTESTDATEID+ id.toString());
    List<TATestCompany> list = List();
    if (response.statusCode == 200) {

      list = (json.decode(response.body) as List)
          .map((data) => new TATestCompany.fromJson(data))
          .toList();
      if(list.length>0)
        return list ;
      return throw Exception('Failed to load TestCompany null value');
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load TestCompany');
      //return null;
    }
  }
  catch(_){
    throw Exception('Failed to load TestCompany');
  }
}


