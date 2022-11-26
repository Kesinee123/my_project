// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
 
  String quizImageUrl;
  String quizTitle;
  String quizSubject;
  

 Quiz({required this.quizImageUrl,required this.quizTitle,required this.quizSubject,});


 factory Quiz.fromMap(data) {
    return Quiz(
      
      quizImageUrl: data['quizImageUrl'],
      quizTitle: data['quizTitle'],
      quizSubject: data['quizSubject'],
     
      );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
     
      'quizImageUrl' : quizImageUrl,
      'quizTitle' : quizTitle,
      'quizSubject' : quizSubject,
      
    };
  }
}
