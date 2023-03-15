// import 'dart:ffi';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:my_project/models/question.dart';

// class correctAnswer extends StatefulWidget {
//   const correctAnswer(
//       {super.key, required this.quizId, required this.questionId, required this.correct_answer});

//   final String quizId;
//   final String questionId;
//   final String correct_answer;

//   @override
//   State<correctAnswer> createState() => _correctAnswerState();
// }

// class _correctAnswerState extends State<correctAnswer> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//     stream: FirebaseFirestore.instance
//                 .collection('quizs')
//                 .doc(widget.quizId)
//                 .collection('questions') 
//                 // .where('questionId', 
//                 // isEqualTo: FirebaseFirestore.instance.collection('quizs')
//                 // .doc(widget.quizId)
//                 // .collection('questions')
//                 // .id
//                 // )
//                 // .doc(widget.questionId)
//                 .snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         return Text(
//           'No Data...',
//         );
//       } else { 
//           return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               final DocumentSnapshot documentSnapshot =
//                       snapshot.data!.docs[index];
//               return Text(documentSnapshot['correct_answer'].toString());
//                   }
//           )  ;    }
//     }
//     );
//   }
// }
