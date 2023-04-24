
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class authService {

  Future<Response> loginResponse(String userId, String password) async {

    var body = {
     'Username': userId.toString(),
     'password': password
     };
     const baseurl= "pmstplive.educategirls.ngo";
     const endpoint = '/api/PMSTPWebApi/GetLogin';
      var url=Uri.https(baseurl,endpoint,body);
      var b="https://pmstplive.educategirls.ngo/api/PMSTPWebApi/GetLogin";
      print(url);
      var response= await http.post(Uri.parse(b),headers: {'Content-Type': 'application/json'} ,body: jsonEncode(body));
        print(response.statusCode);
     return response;
  }


  Future<Response> SignupResponse(String userId, String password) async {

    var body = {
     'Username': userId.toString(),
     'password': password
     };
     const baseurl= "pmstplive.educategirls.ngo";
     const endpoint = '/api/PMSTPWebApi/GetLogin';
     var response=Uri.https(baseurl,endpoint,body);
     return http.get(response);
  }
}

