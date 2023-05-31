// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:my_project/models/question.dart';

// import 'option.dart';

// class Questions extends StatelessWidget {
//   const Questions({
//     super.key, required this.question,
//   });

//   // ดึงข้อมูล firebase ของ questions
//   Future<List<Question>> getQuestions() async {
//     final CollectionReference questions = FirebaseFirestore.instance
//         .collection('quizs')
//         .doc('R7wN0dwEbTVDqba8BMfx')
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

//   final Question question;

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Question>>(
//         future: getQuestions(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData) {
//             return FutureBuilder<List<Question>>(
//                 future: getQuestions(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasData) {
//                     return Container(
//                       padding: EdgeInsets.all(20),
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(25)),
//                       child: Column(children: [
//                         Text(''),
//                         Option()
//                       ]),
//                     );
//                   }

//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 });
//           }

//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         });
//   }
// }
