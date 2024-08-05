


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/app_code/q_review.dart';
import 'package:quiz_app/app_code/quiz_page.dart';

import '../backcode/main_quiz.dart';

/*
The submission page is presented at the end of the quiz. This page shows the user
how many questions they got wrong, the percentage, a button to review incorrect questions,
and a button to end completely the quiz session.
 */
class Submission extends StatefulWidget {    // Class creates the widget class and receives the quiz that was
                                            //  created for the user
  late Quiz createdQuiz;

  Submission(Quiz q){
    createdQuiz = q;
  }

  @override
  State<StatefulWidget> createState() => _Submission();
}

class _Submission extends State<Submission> {        // class contains the widget that contains all the widgets of the page. Text and buttons.

  @override
  Widget build(BuildContext context) {
    int correctAnswered = widget.createdQuiz.calculate();    //calls method in Quiz class that goes through the quiz and checks how many correct and wrong answers.
    return Scaffold(
      appBar: AppBar(                                // Appbar contains the title of the  "Submission"
        backgroundColor: Colors.black,
        title: const Text("QStudy - Submission"),
        centerTitle: true,
      ),
      body: Center(                                       // contains all widgets that appear in the center
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Divider(height: 20, color: Colors.white,),                 // The following is text shown to the user so that they can how many questions they got wrong
              Text("Hi user! This are the results from your Quiz!",
                style: TextStyle(fontSize: 20, ), textAlign: TextAlign.center,),
              const Divider(height: 40, color: Colors.white,),
              Text("$correctAnswered / ${widget.createdQuiz.numQ}",
                style: TextStyle(fontSize: 45, color: Colors.deepOrangeAccent),),
              const Divider(height: 30, color: Colors.white,),
              ElevatedButton(                                         //Button takes user to review the incorrect questions if they missed any
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                  onPressed: () {
                    if(widget.createdQuiz.wrongQuestions.length > 0){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Review(widget.createdQuiz)));
                    } else {
                      showAlertDialog(context);
                    }
                  },
                  child: const Text("Review Incorrect Questions")
              ),
              ElevatedButton(                         // Button ends the quiz session and return to starting page
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => QuizPage()));
                  },
                  child: const Text("End")
              ),
              Text("WRONG: ${widget.createdQuiz.wrongQuestions.length}"),
              Text("RIGHT: ${widget.createdQuiz.rightQuestions.length}"),
            ],
          ),
        ),
      )
    );
  }

  showAlertDialog(BuildContext context) {   //Widget shows the alert dialog that there were no questions to review

    // set up the button
    Widget okButton = TextButton(           // pop up ok button to remove the alert dialog
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(       // This is the alert dialog which has the ok button
      title: Text("Review Session"),
      content: Text("There is no questions to review."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}