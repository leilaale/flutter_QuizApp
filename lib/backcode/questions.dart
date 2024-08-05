
import 'dart:io';
import 'dart:convert';
import 'dart:core';


abstract class Questions {  // has all the variables for the questions for Multiple choice and fill in the blank Questions

  String question  = "";         // written question
  List ansOptions;               // options list
  dynamic correctAns;            // correct answer
  bool userWasCorW = false;      // if user answered correctly = true
  int type;                      // Multiple Choice is type 1 and Fill in the Blank is type 2
  String figure;                 // saves link to image if any
  bool hasImage = false;         // checks if question has image
  bool alreadyAnswered = false;

  Questions(this.question, this.ansOptions, this.correctAns, this.type, this.figure);   // Constructor

  // Getters and Setters
  bool getuserC() => userWasCorW;

  String get getQuestion => question;
  set setQuestion(String q){
    question = q;
  }

  dynamic get getAns => ansOptions;
  set setAnswer(dynamic x){
    ansOptions = x;
  }

  dynamic get getCorrect => correctAns;
  set setCorrectAns(dynamic ans){
    correctAns = ans;
  }

  dynamic getType() => type;


  checkAnswerMatch(dynamic userAns){                            // checks user answer with correct answer

    if(type ==1){
      String answer = ansOptions[correctAns - 1];               // gets index and compares String to String
      if(userAns == answer){
        alreadyAnswered = true;
        userWasCorW = true;                                     // it then changes boolean if user was right or wrong
        return true;
      } else {
        alreadyAnswered =true;
        //print("Wrong Answer");
        userWasCorW = false;
        return false;
      }
    } else {
      List corr = correctAns as List;                          // there can be multiple choice for fill in the blank
      if(corr.contains(userAns)){                              // matches user answer to any in the list
        alreadyAnswered = true;
        userWasCorW = true;
        return true;
      } else {
        alreadyAnswered = true;
        userWasCorW = false;
        print("Wrong Answer");
        return false;
      }
    }
  }

}

class MultipleChoiceQ extends Questions{  // class extends question

  MultipleChoiceQ(question, options, ans, type, figure) : super(question, options, ans, type, figure);  // constructor

  @override
  checkAnswerMatch(userAns) {                     // checks if user was right
    return super.checkAnswerMatch(userAns);
  }

}

class FilltheBlankQ extends Questions { // class extends question

  FilltheBlankQ(super.question, super.options, super.ans, super.type, super.figure);           // constructor

  @override
  checkAnswerMatch(dynamic userAns) {             // checks if user was right
    return super.checkAnswerMatch(userAns);
  }

}

