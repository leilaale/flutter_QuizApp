
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'questions.dart';
import 'webonline.dart';

class Quiz  {
  var numQ = 0;                          // number of questions the user ask for in a quiz
  List<Questions> questionsPool = [];    // list of total questions on the online pool
  List<Questions> userQuiz = [];         // quiz created that the user asked for
  List<Questions> wrongQuestions = [];   // list of wrong questions that the user got.
  List<Questions> rightQuestions = [];


  Quiz(){                                 // constructor -- the moment its created it should gather the pool of questions from online
    startQ();
  }

  void startQ() async {
    questionsPool = await getUrl();                 // creates list of Questions from the online quizes
    debugPrint('START AFTER: ${questionsPool.length}');
  }

  void createQuiz() {                               // creates quiz with random questions from pool

    List<Questions> tempQ = [];
    tempQ.add(questionsPool[15]);                      // get this line of code to see if the image widget works!!!!

    Set index = {};
    int i = 0;
    while(i < numQ){                                         // Random numbers are selected from 0 to length of pool questions(136)
      var random = Random().nextInt(questionsPool.length);   // Those numbers are added to a set. So that the index(number) is not repeated.
      if(index.contains(random)==false){                     // that way we always have different questions on the created quiz for the user.
        index.add(random);
        tempQ.add(questionsPool[random]);
        i++;
      }
    }

    userQuiz = tempQ;                                         // states userQuiz to the created quiz
    //debugPrint('${userQuiz.length}');
  }

  int calculate(){                                           // this method calculated how many right question the user got

    for(Questions q in userQuiz) {                           // In the question class it will state true if the user was right on their answer
      if(q.userWasCorW){                                     // if true it adds the to right questions list if not to wrong questions
        rightQuestions.add(q);
      } else {
        wrongQuestions.add(q);
      }
    }

    return rightQuestions.length;                             // return the length of the right questions list

  }

  String correctMultiChoice(Questions q){                      // Multiple choice questions are saved with an int correct answer
                                                               // this is to grab the index of the correct answer and return the string
    return q.ansOptions[q.correctAns - 1];

  }

}


