import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Question {
  final String id;
  final String question;
  final String typeQuestion;
  final String correct_answer;

  Question({
    required this.question,
    required this.id,
    required this.typeQuestion,
    required this.correct_answer,
  });
}

// Future<List<Question>> getQuestions() async {
//     final CollectionReference questions = FirebaseFirestore.instance
//         .collection('quizs')
//         .doc('h98ceZEsLHKJWnpODf2v')
//         .collection('questions');
//     QuerySnapshot querySnapshot = await questions.get();
//     List<Question> questionsList = [];
//     querySnapshot.docs.forEach((doc) {
//       Question question = Question(
//         id: doc.id,
//         question: doc['questions'].toString(),
//         typeQuestion: doc['type_quiz'].toString(),
//         correct_answer: doc['correct_answer'].toString(),
//       );
//       questionsList.add(question);
//     });
//     return questionsList;
//   }
