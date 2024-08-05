
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../backcode/questions.dart';

class QBlank extends StatefulWidget {   // This class creates the widget for the blank button on Fill in the Blank Questions

  late Questions q;

  QBlank(Questions question){              //constructor
    q = question;
  }

  @override
  State<StatefulWidget> createState() => _QBlank();     //creates _QBlank object

}

class _QBlank extends State<QBlank> with AutomaticKeepAliveClientMixin {   // class contains the widget for Fill in the Blank Questions

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? selectedValue;

  @override
  Widget build(BuildContext context){
    super.build(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(left: 50, right: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(                                          // field where user can input the answer to fill in the blank
                keyboardType: TextInputType.text,
                validator: (String? inValue){                         // validator makes sure it is not left empty
                  if(inValue?.length == 0){
                    return "Empty answer.";
                  }
                  return null;
                },
                onSaved: (String? inValue){                           // saves user's input to selected value
                  selectedValue = inValue!;
                },
                decoration: const InputDecoration(                    // hints the user to type answer
                  hintText: "Type answer",
                ),
              ),
              const SizedBox(height: 25,),
              ConstrainedBox(constraints: BoxConstraints(minHeight: 20),        // submit button that saves the answers, validates.
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _formKey.currentState?.save();
                        widget.q.checkAnswerMatch(selectedValue);               // this checks if the user answer is correct and it is saved.
                      }
                    },
                    style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll<Color>(Colors.amber)),
                    child: const Text("Submit Answer", style: TextStyle(fontSize: 18, color: Colors.black),),
                  )
              )
            ],
          ),
        ),
      ),
    );


  }


  @override                                // makes the widget alive all the time.
  bool get wantKeepAlive => true;

}