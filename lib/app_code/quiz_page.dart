
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/app_code/loading_indicator.dart';
import 'package:quiz_app/app_code/q_displaymain.dart';
import 'package:quiz_app/backcode/main_quiz.dart';


/*
Class takes care of showing the loading indicator while the app gets the pool of questions
from online ready. Moreover it also provides a drop down menu for the user to select how many
question they want in the quiz from 1 to 10.
 */

class QuizPage extends StatefulWidget {                   // creates subclass of QuizPage that contains the widget

  @override
  State<StatefulWidget> createState() => _QuizPage();
}


class _QuizPage extends State<QuizPage> {                 // contains the display widget and the drop down menu

  List<int> numList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];    // list of numbers that the user can select
  Quiz _quiz = Quiz();                                    // creates an object Quiz

  int dropdownValue = 1;                                  // starts the dropDownValue at 1
  late bool _isLoading;                                   // bool that checks if page is loading or not

  @override
  void initState() {                                      // creates an initial state which makes the loading indicator start
    _isLoading = true;
    Future.delayed(const Duration(seconds: 20), () {      // loading indicator is set for 20 seconds
      setState(() {                                       // after the 20 seconds it sets the loading value to false
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {                    // widget that shows the display
    return Scaffold(
      appBar: AppBar(                                     // contains the title of the page
        backgroundColor: Colors.black,
        title: const Text("QStudy - Question Count"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _isLoading ? Center(child: LoadingIndicator(), )                // This checks if the loading bool is true or false. If true it shows the loading indicator
          : Container(child: Column (children: [                          // once its false it displays the question and the drop down menu
            ButtonTheme(child: ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('How many questions would you like?',          // asks user how many questions they would like on the quiz
                  style: TextStyle(fontSize: 16, ),),
                SizedBox(height: 45, width: 45,                           // calls drop down menu
                    child: _buildDropDown(context)),
               ],
            )),
            ConstrainedBox(constraints: const BoxConstraints(minHeight: 20),      // submit button. Which prompts the code to create the quiz with the select number of questions
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('Selected Q: ${_quiz.numQ}');
                  _quiz.createQuiz();                                        // creates quiz
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QuizDisplay(_quiz)));
                },
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.black)),
                child: const Text("Submit", style: TextStyle(fontSize: 16),),
              ),
            ),
          ],))
        ],
      ),
    );

  }

  @override
  Widget _buildDropDown(BuildContext context) {                     // widget that shows the drop down menu
    return DropdownButtonFormField<int>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward, size: 20,),            // shows arrow pointed downward
      elevation: 15,
      style: const TextStyle(color: Colors.orange, fontSize: 20),
      dropdownColor: Colors.blueGrey.shade50,
      onChanged: (int? value) {                                      // once pressed it saved the number the user selected
        // This is called when the user selects an item.
        dropdownValue = value!;
        this._quiz.numQ = dropdownValue;                             // saves number to the Quiz object
        debugPrint('Selected Q: ${_quiz.numQ}');
      },
      items: numList.map<DropdownMenuItem<int>>((int value) {        //maps the list of numbers on the drop down meny
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

}

