// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Quiz {
  String qid;
  String quizImageUrl;
  String quizTitle;
  String quizSubject;

 Quiz({required this.qid,required this.quizImageUrl,required this.quizTitle,required this.quizSubject});


 factory Quiz.fromMap(map) {
    return Quiz(
      qid: map['qid'],quizImageUrl: map['quizImageUrl'], quizTitle: map['quizTitle'], quizSubject: map['quizSubject']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'qid' : qid,
      'quizImageUrl' : quizImageUrl,
      'quizTitle' : quizTitle,
       'quizSubject' : quizSubject,
    };
  }
}
