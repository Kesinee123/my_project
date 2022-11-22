// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String qid;
  String quizImageUrl;
  String quizTitle;
  String quizSubject;
  Timestamp createdAt;
  Timestamp updateAt;

 Quiz({required this.qid,required this.quizImageUrl,required this.quizTitle,required this.quizSubject, required this.createdAt , required this.updateAt });


 factory Quiz.fromMap(data) {
    return Quiz(
      qid: data['qid'],
      quizImageUrl: data['quizImageUrl'],
      quizTitle: data['quizTitle'],
      quizSubject: data['quizSubject'],
      createdAt : data['createdAt'],
      updateAt : data['updateAt']
      );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'qid' : qid,
      'quizImageUrl' : quizImageUrl,
      'quizTitle' : quizTitle,
      'quizSubject' : quizSubject,
      'createdAt' : createdAt,
      'updateAt' : updateAt
    };
  }
}
