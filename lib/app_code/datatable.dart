


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../backcode/main_quiz.dart';
import '../backcode/questions.dart';

class DataTablePage extends StatefulWidget {
  
  
  late Quiz createdQuiz;
  
  DataTablePage(Quiz q){
    createdQuiz = q;
  }
  
  @override
  State<StatefulWidget> createState() => _DataTablePage();
}

class _DataTablePage extends State<DataTablePage> {
  @override
  Widget build(BuildContext context) {
    List<Map<String,dynamic>> quizlist = getRows();
    return Scaffold(
      appBar: AppBar(                                                     // App bar contain the name of the page
        backgroundColor: Colors.black,
        title: const Text("Data Table"),
        centerTitle: true,
      ),
      body: Container(
        child: DataTable(
          columns: [
            DataColumn(label: Text("Answered",  style: TextStyle(fontWeight: FontWeight.bold)),),
            DataColumn(label: Text("Question", style: TextStyle(fontWeight: FontWeight.bold),)),
            DataColumn(label: Text("Type", style: TextStyle(fontWeight: FontWeight.bold),),),
          ],
          rows: quizlist.map((e) => DataRow(
            cells: [
              DataCell((e['icon'])),
              DataCell(Text(e['question'])),
              DataCell(Text(e['type']))
            ]

          )).toList(),
        ),
      ),
    );
  }
  
  List<Map<String, dynamic>> getRows(){

    List<Map<String, dynamic>> temp =[];
    List<Questions> userQuiz = widget.createdQuiz.userQuiz;

    for(Questions q in userQuiz) {

      String typeQ = "";
      if(q.type == 1){
        typeQ = "Multiple Choice";
      } else {
        typeQ = "Fill the Blank";
      }

      dynamic ans = const Icon(Icons.check, color: Colors.orange, weight: 25,);

      if(!q.alreadyAnswered){
        ans = Icon(Icons.dangerous, color: Colors.black, weight: 25,);
      }

      temp.add({
        'icon' : ans,
        'question' : q.question,
        'type' : typeQ,
      });
    }

    return temp;
  }
}
