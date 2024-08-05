
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/app_code/q_display_keepalive.dart';
import 'package:quiz_app/app_code/q_display_qblank.dart';
import 'package:url_launcher/url_launcher.dart';
import '../backcode/main_quiz.dart';
import '../backcode/questions.dart';


/*
This dart file contains to methods. The first one created the list of pages for each questions for the user
for when they take the quiz. The second method is the list of pages created for the incorrect questions on the review session/
 */

List<Widget> questionPages(Quiz createdQuiz){  // creates the pages for each question for the quiz

  List<Widget> temp = [];                      // list of pages

  for(Questions q in createdQuiz.userQuiz) {       // the for loop traverses through each question on the quiz

    if(q.type == 1){                               // if question is of type 1 (Multiple choice) a different widget is used.
      Widget qTempPage = Column(
        children: [
          q.figure.length > 1 ? ImageOnline(q) : SizedBox(height: 10,),
          Container(                               // Container displays the question
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            child: Text(q.question, style: const TextStyle(fontSize: 18,),),
          ),
          QuestionKeepAlive(q),                    // this widget if the Radio Button which is kept alive.
          Text("${q.correctAns}"),                 // shows the correct answer but its for admin purposes. To see if the app is working
        ],
      );
      temp.add(qTempPage);                         // widget is added to the list
    } else {                                       // if question is of type 2 (Fill in the Blank) another type of widget is used.
      Widget qTempPage = Center(
        child: Column(
          children: [
            q.figure.length > 1 ? ImageOnline(q) : SizedBox(height: 10,),
            Container(                             // prints out the question
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(2),
              child: Text(q.question, style: const TextStyle(fontSize: 18,),),
            ),
            const Divider(color: Colors.white,),   // creates a blank space between other widgets
            QBlank(q),                             // calls widget so that user inputs their answer and submits
            Text("${q.correctAns}"),               // shows the correct answer but its for admin purposes. To see if the app is working
          ],
        )
      );
      temp.add(qTempPage);                         // widget is added to the list
    }
  }
  return temp;                                     // return list
}

List<Widget> reviewPages(Quiz createdQuiz){           // creates the pages for each question for the review

  List<Widget> temp = [];                             // list of pages

  for(Questions q in createdQuiz.wrongQuestions) {    // traverses through the list of wrong questions

    if(q.type == 1){                                  // if question is of type 1 (Multiple choice)
      Widget qTempPage =                              // it contains a container which shows the question
      Center(
        child: Column(
          children: [
            q.figure.length > 1 ? ImageOnline(q) : SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              child: Text(q.question, style: const TextStyle(fontSize: 18,),),   //shows question
            ),
            const Text("Correct Answer", style: TextStyle(fontSize: 20),),
            Text("${createdQuiz.correctMultiChoice(q)}", style: TextStyle(fontSize: 18, color: Colors.orangeAccent),),   // calls method of quiz to return the correct answer instead of an int
          ],
        ),
      );
      temp.add(qTempPage);                           // adds to list of widgets
    } else {
      Widget qTempPage = Center(
          child: Column(
            children: [
              q.figure.length > 1 ? ImageOnline(q) : SizedBox(height: 10,),
              Container(                             // shows question
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(2),
                child: Column(
                  children: [
                    Text(q.question, style: const TextStyle(fontSize: 18,)),
                  ],
                )
              ),
              const Divider(color: Colors.white,),                          // creates a space between the question and the following text
              const Text("Correct Answer", style: TextStyle(fontSize: 20),),
              Text("${q.correctAns}", style: TextStyle(fontSize: 18, color: Colors.orangeAccent),),    // shows correct answer
            ],
          )
      );
      temp.add(qTempPage);                               // adds to list
    }
  }
  return temp;                             // returns list
}


class ImageOnline extends StatefulWidget {                    // This class takes care of getting and showing the online image of the question

  late Questions q;
  ImageOnline(Questions q){                                   // gets what question
    this.q = q;
  }

  @override
  State<StatefulWidget> createState() => _ImageOnline();
}

class _ImageOnline extends State<ImageOnline> {              // subclass of ImageOnline
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Image.network("http://www.cs.utep.edu/cheon/cs4381/homework/quiz/figure.php?name=${widget.q.figure}",      // shows image
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {                                // if error it shows messge
              return Text('IMAGE WAS NOT AVAILABLE');
            },),
        ),
        ElevatedButton(                                                                                                     // provides a way for the user to see the image on their own web
            onPressed: () async {                                                                                           // by pressing on the button.
              final Uri url = Uri.parse("http://www.cs.utep.edu/cheon/cs4381/homework/quiz/figure.php?name=${widget.q.figure}");
              if (!await launchUrl(url)) {
              throw Exception('Could not launch $url');
              }
            }
            , child: Text("Launch Url on Web"))
      ],
    );
  }

}