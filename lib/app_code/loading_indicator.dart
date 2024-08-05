
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/*
This class loads the loading animation after signing in the app to create the quiz.
This loading feature last 18 seconds while the question pool is gathered from the online source.
 */
class LoadingIndicator extends StatefulWidget {  // creates the subclass containing the loading widget

  @override
  State<StatefulWidget> createState() => _LoadingIndicator();

}

class _LoadingIndicator extends State<LoadingIndicator> {  // class that has loading widget

  @override
  Widget build(BuildContext context) {                // Widget allows for the loading circle to be centered in the middle
    return Container(                                 // of the screen.
      padding: EdgeInsets.all(10),
      child: Center(
          child: Column(
            children: [
              SpinKitFadingCircle(                     // loading widget
                size: 85,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(                            // returns the spinning with the specific colors
                      color: index.isEven ? Colors.black : Colors.orange,

                    ),
                  );
                },
              ),
              textBuild(context),                       // calls the text widget
            ],
          )
      ),
    );
  }

  @override
  Widget textBuild(BuildContext context){               // Text widget that appears below the loading widget
    return Container(
      alignment: Alignment.center,
      child: const Text("Loading. Please Wait...",
        style: TextStyle(color: Colors.orange) ,),
    );
  }
}