// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class correctAnswer extends StatefulWidget {
//   const correctAnswer({super.key, required this.quizId, required this.questionId});

//   final String quizId;
//   final String questionId;

//   @override
//   State<correctAnswer> createState() => _correctAnswerState();
// }

// class _correctAnswerState extends State<correctAnswer> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//               future: FirebaseFirestore
//         .instance
//         .collection('quizs')
//         .doc(widget.quizId)
//         .collection('questions')
//         .get(),
//               builder: (context, AsyncSnapshot snapshot) {
//                 if(snapshot.hasError){
//                   return Scaffold(
//                     body: Center(
//                       child: Text('Error: ${snapshot.error}'),
//                     ),
//                   );
//                 }
//                 if(snapshot.connectionState == ConnectionState.done) {
//                  Map<String, dynamic> documentData1 = snapshot.data!.data();
//                   return Text("${documentData1["correct_answer"]}");
//                 }
                
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             );
//   }
// }