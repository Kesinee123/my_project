import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Question {
  final String id;
  final String question;

  Question({
    required this.question,
    required this.id,
  });
}

// class QuizData {
//   static Future<List<Question>> getQuestions() async {
//     final CollectionReference questions =
//         FirebaseFirestore.instance.collection('quizs').doc('bCoH94IdwMPRkf1wyWE4').collection('questions');
//     QuerySnapshot querySnapshot = await questions.get();
//     List<Question> questionsList = [];
//     querySnapshot.docs.forEach((doc) {
//       Question question = Question(
//         id: doc.id,
//         question: doc['questions'],
//       );
//       questionsList.add(question);
//     });
//     return questionsList;
//   }
// }
