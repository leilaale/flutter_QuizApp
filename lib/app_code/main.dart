import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quiz_app/backcode/logInWeb.dart';
import 'package:quiz_app/app_code/quiz_page.dart';

/*
This dart file contains the main method that starts up the class,
the log in class, HttpOverride method, and the MyApp class.
In this file, the app is started and presents the log in page, it also checks that
authentication of the user according to the online page.
 */

void main() {                                                   // Method that starts the app
  HttpOverrides.global = MyHttpOverrides(); // calls override
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {                           // MyApp class creates the subclass
  const MyApp({super.key});
  //Myapp({required Key key}) : super(key: key);
  @override
  _MyApp createState() => _MyApp();
}

class LoginData {                                             // Log in Class that contains username and password
  String username = "";
  String password = "";

  String get getUsername => username;
  String get getPassword => password;
}

class _MyApp extends State {                                 // My app presents the log in page

  final LoginData _loginData = LoginData();                  // creates an object of the Log in Class
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();       // a formkey that is used to save the submitted data of the user.


  @override
  Widget build(BuildContext inContext) {
    return MaterialApp(
      home : Scaffold(
        appBar: AppBar(                                              // Presents Title of the Page
          backgroundColor: Colors.black,
          title: const Text("QStudy - Log In"),
        ),
        body: Container(
          padding: EdgeInsets.all(50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(                                        // creates the blank space where the user can write into
                  keyboardType: TextInputType.emailAddress,           // It also calls a validator to make user that the username is greater than 0
                  validator: (String? inValue){
                    if(inValue?.length == 0){
                      return "Please enter username";
                    }
                    return null;
                  },
                  onSaved: (String? inValue){                        // saves the submitted value from the user
                    this._loginData.username = inValue!;
                  },
                  decoration: const InputDecoration(                 // hints the user of what the field is asking for
                    hintText: "none@none.com",
                    labelText: "Username (eMail address)",
                  ),
                ),
                TextFormField(                                       // creates the blank space where the user can write into
                  obscureText: true,
                  validator: (String? inValue) {                     // It also calls a validator to make user that the password is greater than 4
                    if(inValue!.length < 4) {
                      return "Password must be >= 4 in length";
                    }
                    return null;
                  },
                  onSaved: (String? inValue) {                      // saves the submitted value from the user
                    this._loginData.password = inValue!;
                  },
                  decoration: const InputDecoration(                // hints the user of what the field is asking for
                    hintText: "Password",
                    labelText: "Password",
                  ),
                ),
                const SizedBox(height: 30,),                        // empty box to divide the textfields and the button
                ConstrainedBox(constraints: const BoxConstraints(minHeight: 30),
                  child: ElevatedButton(                                                  // submit button
                    onPressed: () async {
                      if(_formKey.currentState!.validate()) {                             // makes sure that text type is validated to the standards asked.
                        _formKey.currentState?.save();                                    // saves inputted values of user into the Log In class
                        //debugPrint('logIn Username: ${_loginData.username}, Password: ${_loginData.password}');

                        bool check = await getLogIn(_loginData.username, _loginData.password);     // calls method that makes sure that user account is actually authorized

                        if(check){                                                                 // if authorized then it pops the Log In page and pushes the user to the next page
                          //debugPrint('MAIN LENGTH: ${_quiz.questionsPool.length}');
                          Navigator.of(context).pop();
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => QuizPage()));

                        }else {                                                                    // if not authorized prompts the user to check username and password
                          showAlertDialog(context);
                        }
                        //print("Username: ${_loginData.username}");
                        //print("Password: ${_loginData.password}");
                      }
                    },
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                    child: const Text("Log In!", style: TextStyle(fontSize: 18),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {                      // widget shows the alert dialog when the user inputs incorrect username or password

    // set up the button
    Widget okButton = TextButton(                             // text widget for the ok button inside the alert dialog
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(                          // alert dialog message and includes the ok button
      title: Text("Invalid Credentials"),
      content: Text("Please try again. Check username/password."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(                                              // displays the alert dialog
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}



// this class overrides the certification required by the website. This code was gotten online
// source: https://stackoverflow.com/questions/54285172/how-to-solve-flutter-certificate-verify-failed-error-while-performing-a-post-req
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

