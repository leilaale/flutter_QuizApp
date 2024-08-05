

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/app_code/datatable.dart';
import 'package:quiz_app/app_code/q_display_qlist.dart';
import 'package:quiz_app/app_code/q_submission.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../backcode/main_quiz.dart';


/*
QuizDisplay class displays the list of pages that contain each question to display
to the user.
 */

class QuizDisplay extends StatefulWidget {

  late Quiz createdQuiz;                     // it is passed the Quiz object from the QuizPage through the navigator

  QuizDisplay(Quiz q){
    this.createdQuiz = q;
  }

  @override
  State<StatefulWidget> createState() => _QuizDisplay();                    // creates the subclass of QuizDisplay that contain the widgets
}



class _QuizDisplay extends State<QuizDisplay> {                            // class displays


  late final List<Widget> _qPages = questionPages(widget.createdQuiz);     // this is a class of widget that contain the page where the question and the widgets needed present.
  final _controller = PageController();                                    // controller that controls the previous, end quiz, and next buttons
  static const _kDuration = Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  late double progressInd = 1/_qPages.length;                              // to keep up with the progress of the quiz
  int index2 = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(                                                     // App bar contain the name of the page
        backgroundColor: Colors.black,
        title: const Text("Quiz in Session"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(                                                        // shows the progress of the quiz done by the user
            padding: EdgeInsets.all(5.0),
            child: LinearPercentIndicator(
              animation: true,
              lineHeight: 13.0,
              animationDuration: 2000,
              percent: progressInd,
              center: Text("$progressInd"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.amber,
            ),
          ),
          Flexible(
            child: PageView.builder(                                      // pageview that shows each question and the needed widgets
              controller: _controller,
              itemCount: _qPages.length,
              itemBuilder: (BuildContext context, int index) {
                return _qPages[index % _qPages.length];
              },
            ),
          ),
          Container(                                                     // bottom navigation the has the previous, next, and end quiz buttons
            color: Colors.orange,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  style: const ButtonStyle(                                                               // Previous button controlled by the controller
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                  child: const Text('Previous'),
                  onPressed: () {
                    setState(() {
                      if(index2/_qPages.length > 1 || index2/_qPages.length < 0){                         // set state is to update the progress indicator
                        progressInd = 1;
                      } else {
                        this.progressInd = (index2/_qPages.length).toDouble();
                        this.index2-=1;
                      }
                    });
                    _controller.previousPage(                                                             // shows previous question
                        duration: _kDuration, curve: _kCurve);
                  },
                ),
                ElevatedButton(                                                                           // Shows End Quiz which will present another page to the user
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Submission(widget.createdQuiz)));
                    },
                    child: const Text('End Quiz')),
                ElevatedButton(
                    style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DataTablePage(widget.createdQuiz)));
                    },
                    child: const Text('DATA TABLE'),
                ),
                ElevatedButton(                                                                             // Next button controlled by the controller
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                  child: const Text('Next'),
                  onPressed: () {
                    setState(() {                                                                           // set state is to update the progress indicator
                      if(index2/_qPages.length > 1){
                        progressInd = 1;
                      } else {
                        this.progressInd = (index2/_qPages.length).toDouble();
                        this.index2+=1;
                      }
                    });
                    _controller.nextPage(duration: _kDuration, curve: _kCurve);                             // shows next question
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}