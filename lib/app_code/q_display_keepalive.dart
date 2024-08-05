
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../backcode/questions.dart';

class QuestionKeepAlive extends StatefulWidget { // This class creates the widget for select button on Multiple Choice Questions

  late Questions q;

  QuestionKeepAlive(Questions question) {        // constructor to pass the question
    this.q = question;
  }

  @override
  State<StatefulWidget> createState() => _QuestionKeepAlive();

}

class _QuestionKeepAlive extends State<QuestionKeepAlive> with AutomaticKeepAliveClientMixin {    //subclass that contains keep alive

  final selectedColor = Colors.orange;           // color for the option that was selected
  final unselectedC = Colors.black;              // color for those not selected
  String? selectedValue;

  @override
  Widget build(BuildContext context){
    super.build(context);

    return Theme(
        data: Theme.of(context).copyWith(
          unselectedWidgetColor: unselectedC,
        ),
        child: Column(
          children: widget.q.ansOptions.map<Widget>(             // maps the question answer options
                (value){
              //print("OUT SELECT: $selectedValue");
              //print("OUT VALUE: $value");
              var selected = selectedValue == value;             // sets the colors
              var color = selected ? selectedColor : unselectedC;

              return RadioListTile<String>(                     // uses Radio List to show the buttons
                value: value,
                groupValue: selectedValue,
                title: Text(value, style: TextStyle(color: color)),
                activeColor: selectedColor,
                onChanged: (value) { setState(() {               // once changed the colors changed and the selected Value is checked
                  selectedValue = value;
                  print("HERE: $value");
                  print("SLECTED: $selectedValue");
                  widget.q.checkAnswerMatch(selectedValue);      // checks if the user answer is correct
                });
                },
              );
            },
          ).toList(),
        )
    );
  }

  @override
  bool get wantKeepAlive => true;                              // keep the widget alive
}