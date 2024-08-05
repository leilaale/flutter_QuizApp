import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

/*
method gets the username and password the user inputs and checks if its on the online
database. If False, it will show alert dialog and if true it open up the next page of the app
 */
Future<bool> getLogIn(String username, String pin) async {

  debugPrint('Username is $username, Password is $pin');
  Response r = await get(Uri.parse('https://www.cs.utep.edu/cheon/cs4381/homework/quiz/login.php?user=$username&pin=$pin'),);

  var myReponse = jsonDecode(r.body);

  return myReponse['response'];
  //print(myReponse);
}
