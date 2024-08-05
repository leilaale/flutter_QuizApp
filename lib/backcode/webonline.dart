/*
Author: Leila

Class usage: creates the list of questions from the quiz's from the online source provided
 */

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'questions.dart';

/*
This class takes care of getting the the pool of questions from the quizes online. It then
grabs the information, creates objects of type Questions which will have all the information, and return a list.
 */

Future<dynamic> getUrl() async {    // returns list of questions from quizes.

  List<Questions> questionsQuiz = [];       // list that will contain all questions

  int n = 0;                                // this numbers take care of switching on what quiz the information is being grabbed from
  int n2 = 1;
  var noQuiz = true;                        // boolean flag that interrupts the while loop when quiz becomes false.

  while(noQuiz){
    var url = Uri.https('www.cs.utep.edu', '/cheon/cs4381/homework/quiz', {'quiz': 'quiz$n$n2'}); //goes quiz by quiz until false;
    var response = await http.get(url);
    var myresponse = jsonDecode(response.body);

    if(myresponse["response"]) {                    // is response is true, it then grabs the information from the quiz
      dynamic quiz = myresponse["quiz"];            // grabs quiz
      List questions = quiz["question"];            // creates the list for each question information
      //print(questions);
      for(var element in questions){                     // creates questions and adds them to a list

        String figure;
        if(element["figure"] == null){
          figure = "";
        } else {
          figure = element["figure"];
        }
        if(element["type"]==1){                          // if question is type one then it creates an object of Multiple choice
          var temp = MultipleChoiceQ(element["stem"], element["option"], element["answer"], element["type"], figure);
          questionsQuiz.add(temp);
        } else {
          List empty = [];
          List ans = [];
          for(var e in element["answer"]){
            ans.add(e.toString().toLowerCase());
          }
          var temp = FilltheBlankQ(element["stem"], empty, ans, element["type"], figure);
          questionsQuiz.add(temp);
        }
      }
    } else {
      noQuiz = false;
    }

    if(n2 <= 8){
      n2++;
    } else {
      n2 = 0;
      n++;
    }

  }

  //print(questionsQuiz);
  return questionsQuiz;
}

