// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_project/controllers/question_controller.dart';
// import 'package:my_project/models/option.dart';

// class OptionPage extends StatefulWidget {
//   const OptionPage({
//     super.key,
//     required this.quizId,
//     required this.questionId,
//     required this.press,
//     required this.index,
//   });

//   final String quizId;
//   final String questionId;
//   final VoidCallback press;
//   final int index;

//   @override
//   State<OptionPage> createState() => _OptionPageState();
// }

// class _OptionPageState extends State<OptionPage> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<QuestionController>(
//         init: QuestionController(),
//         builder: (qnController) {
//           Color getTheRigthColor() {
//             if (qnController.isLocked) {
//               if(widget.index == qnController.correct_answer) {
//                 return Colors.green;
//               } else if (widget.index == qnController.selectedAns && qnController.selectedAns != qnController.correct_answer) {
//                 return Colors.red;
//               }
//             }
//             return Colors.grey;
//             // if (qnController.selectedAns == 0) {
//             //   if (qnController.isAnswered == qnController.correctAns) {
//             //     // return Colors.green;
//             //     print('${qnController.isAnswered} , ${qnController.correctAns} , ${qnController.selectedAns} ** GREEN');
//             //   } else {
//             //     // return Colors.red;
//             //     print('${qnController.isAnswered} , ${qnController.correctAns} , ${qnController.selectedAns} , ** RED' );
//             //   }
//             // }
//             // return Colors.grey;
//           }

//           return InkWell(
//             onTap: widget.press,
//             child: StreamBuilder(
//                 stream: FirebaseFirestore.instance
//                     .collection('quizs')
//                     .doc(widget.quizId)
//                     .collection('questions')
//                     .doc(widget.questionId)
//                     .collection('answers')
//                     .snapshots(),
//                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     return ListView.builder(
//                         itemCount: snapshot.data!.docs.length,
//                         shrinkWrap: true,
//                         itemBuilder: (context, index) {
//                           final DocumentSnapshot documentSnapshot =
//                               snapshot.data!.docs[index];
//                           return Container(
//                             margin: EdgeInsets.only(top: 20),
//                             padding: EdgeInsets.all(20),
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: getTheRigthColor()),
//                                 borderRadius: BorderRadius.circular(15)),
//                             child: Row(
//                               children: [
//                                 // Text('${index + 1}.'),
//                                 Text(documentSnapshot['identifier']),
//                                 SizedBox(
//                                   width: 10,
//                                 ),
//                                 Text(documentSnapshot['answer'])
//                               ],
//                             ),
//                           );
//                         });
//                   }
//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }),
//           );
//         });
//   }
// }
