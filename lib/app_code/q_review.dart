import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/app_code/q_display_qlist.dart';
import 'package:quiz_app/app_code/quiz_page.dart';
import '../backcode/main_quiz.dart';

/*
This class contains the Review session, which contains a page view builder that shows
is incorrect question and the correct answer to that question
 */

class Review extends StatefulWidget {     // created subclass that contain the widget and is passed with the created quiz for the user.

  late Quiz createdQuiz;

  Review(Quiz q){                         // constructor. Quiz should be passed in
    this.createdQuiz = q;
  }

  @override
  State<StatefulWidget> createState() => _Review();    // creates subclass

}

class _Review extends State<Review> {            // class contains the widget for the review page.

  late final List<Widget> _qPages = reviewPages(widget.createdQuiz);      //this called the method that creates the pages for each incorrect question
  final _controller = PageController();                                   // page controller
  static const _kDuration = Duration(milliseconds: 300);                  // duration
  static const _kCurve = Curves.ease;                                     // curve

  @override
  Widget build(BuildContext context) {            // widget contains the appBar and the PageView Builder, next and previous buttons, and end session button.
    return Scaffold(
      appBar: AppBar(                             // presents title of the page
        backgroundColor: Colors.black,
        title: const Text("Review Session"),
        centerTitle: true,
      ),
      body: Column(                               // contains the pageview.builder that shows the questions.
        children: <Widget>[
          Flexible(
            child: PageView.builder(
              controller: _controller,
              itemCount: _qPages.length,
              itemBuilder: (BuildContext context, int index) {
                return _qPages[index % _qPages.length];
              },
            ),
          ),
          Container(                              // container shows the navigation bar at the button which contain the previous, next and end session
            color: Colors.orange,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(                   // this button is to show the previous question
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                  child: const Text('Previous'),
                  onPressed: () {                            // controller return previous page
                    _controller.previousPage(
                        duration: _kDuration, curve: _kCurve);
                  },
                ),
                ElevatedButton(                   // this button is to end the session
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => QuizPage()));     // navigates user to the starting page where they select how many questions for the quiz
                    },
                    child: const Text('End Review Session')),
                ElevatedButton(                                                  // this button is to go to the next page
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                  child: const Text('Next'),
                  onPressed: () {
                    _controller.nextPage(duration: _kDuration, curve: _kCurve);         //controller moves to the next page
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