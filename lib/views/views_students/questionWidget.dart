// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:my_project/models/question.dart';
// import 'package:my_project/views/views_students/option.dart';
// import 'package:my_project/views/views_students/progressBar.dart';
// import 'package:my_project/views/views_students/score.dart';
// import 'package:my_project/views/views_students/score1.dart';

// import '../../models/option.dart';

// class QuestionWidget extends StatefulWidget {
//   const QuestionWidget({Key? key, required this.quizId});

//   final String quizId;

//   @override
//   State<QuestionWidget> createState() => _QuestionWidgetState();
// }

// class _QuestionWidgetState extends State<QuestionWidget> {
//   // ดึงข้อมูล firebase ของ questions
//   Future<List<Question>> getQuestions() async {
//     final CollectionReference questions = FirebaseFirestore.instance
//         .collection('quizs')
//         .doc(widget.quizId)
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

//   bool _isLocked = false;
//   // String selectedAnswer = '';
//   int score = 0;
//   PageController? _controller = PageController(initialPage: 0);

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _controller = PageController(initialPage: 0);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     // เก็บค่าของ quizId
//     Stream<DocumentSnapshot<Map<String, dynamic>>> documentSnapshot =
//         FirebaseFirestore.instance
//             .collection('user')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .snapshots();

//     documentSnapshot.listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
//       Map<String, dynamic>? data = snapshot.data();
//       List<String> quizIds = List<String>.from(data?['quizId'] ?? []);

//       if (!quizIds.contains(widget.quizId)) {
//         quizIds.add(widget.quizId);

//         FirebaseFirestore.instance
//             .collection('user')
//             .doc(FirebaseAuth.instance.currentUser!.uid)
//             .update({
//           'quizId': quizIds,
//         });
//       }
//     });

//     // // เก็บรายชื่อนักเรียน
//     Stream<DocumentSnapshot<Map<String, dynamic>>> studentDocumentSnapshot =
//         FirebaseFirestore.instance
//             .collection('quizs')
//             .doc(widget.quizId)
//             .snapshots();

//     studentDocumentSnapshot
//         .listen((DocumentSnapshot<Map<String, dynamic>> snapshot) {
//       Map<String, dynamic>? data = snapshot.data();

//       FirebaseFirestore.instance
//           .collection('quizs')
//           .doc(widget.quizId)
//           .collection('studentList')
//           .add({
//         'name': FirebaseAuth.instance.currentUser!.displayName,
//       });
//     });

//     return MaterialApp(
//       home: Scaffold(
//         backgroundColor: Color.fromARGB(255, 151, 114, 253),
//         body: SafeArea(
//           child: Center(
//             child: FutureBuilder<List<Question>>(
//               future: getQuestions(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const CircularProgressIndicator();
//                 } else if (snapshot.hasData) {
//                   return PageView.builder(
//                       controller: _controller, // ตัวควบคุมการเลื่อนหน้า
//                       physics: NeverScrollableScrollPhysics(),
//                       // onPageChanged: (value) {
//                       //   setState(() {
//                       //     _isLocked = false;
//                       //   });
//                       // }, // ตัวที่ติดปัญหาอยู่ **
//                       itemCount: snapshot.data!.length, // จำนวนหน้าใน PageView
//                       itemBuilder: (context, index) {
//                         return Column(
//                           children: [
//                             ProgressBar(
//                               seconds: 20,
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   'โจทย์ข้อที่ ${index + 1} / ${snapshot.data!.length}',
//                                   style: TextStyle(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             buildQuestion(
//                                 snapshot.data![index]), // Widget แสดงคำถาม
//                             Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   OutlinedButton(
//                                       onPressed: _isLocked ? index + 1 == snapshot.data!.length 
//                                           ? () {
//                                             Navigator.push(context, MaterialPageRoute(builder: (context) => Score1()));
//                                           }
//                                           : (){
//                                             _controller!.nextPage(
//                                                   duration: const Duration(
//                                                       milliseconds: 500),
//                                                   curve: Curves.linear);
//                                             // setState(() {
//                                             //   _isLocked = false;
//                                             // });
//                                               print(score);
//                                           }
//                                       : null ,
//                                       child: Text( index + 1 == snapshot.data!.length 
//                                       ? 'สิ้นสุดการทำโจทย์'
//                                       : 'โจทย์ข้อถัดไป',
//                                         style: TextStyle(color: Colors.white),
//                                       )),
//                                 ],
//                               ),
//                             )
//                           ],
//                         );
//                       });
//                 } else {
//                   return const Text('...กำลังโหลด');
//                 }
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // void onClickedOption(String identifier, Question question,
//   //     AsyncSnapshot<QuerySnapshot> snapshot) {
//   //   selectedAnswer = identifier;
//   //   if (_questionNumber <= snapshot.data!.docs.length) {
//   //     _questionNumber++;
//   //     if (selectedAnswer == question.correct_answer) {
//   //       score++; // เพิ่มคะแนนเมื่อตอบถูก
//   //     }
//   //     // _controller.nextPage(
//   //     //     duration: const Duration(seconds: 1), curve: Curves.easeInExpo);
//   //   } else {
//   //     showDialog(
//   //         context: context,
//   //         builder: (context) => Score(score: '$score'));
//   //   }
//   // }

//   // Color getColorForOption(AsyncSnapshot<QuerySnapshot> snapshot, int index,
//   //     String correctAnswer, String selectedAnswer) {
//   //       snapshot.data!.docs[index]['identifier'] == selectedAnswer ? Color.fromARGB(255, 140, 232, 36) : Color.fromARGB(255, 249, 61, 48);
//   //   // if (snapshot.data!.docs[index]['identifier'] == selectedAnswer) {
//   //   //   if (snapshot.data!.docs[index]['identifier'] == correctAnswer) {
//   //   //     return Color.fromARGB(255, 140, 232, 36);
//   //   //   } else {
//   //   //     return Color.fromARGB(255, 249, 61, 48);
//   //   //   }
//   //   // }
//   //   // return Colors.black;
//   // }

//   // Widget getIconForOption(AsyncSnapshot<QuerySnapshot> snapshot, int index,
//   //     String correctAnswer, String selectedAnswer) {
//   //   if (snapshot.data!.docs[index]['identifier'] == selectedAnswer) {
//   //     if (snapshot.data!.docs[index]['identifier'] == correctAnswer) {
//   //       return Icon(
//   //         Icons.check_circle,
//   //         color: Color.fromARGB(255, 47, 237, 53),
//   //       );
//   //     } else {
//   //       return Icon(
//   //         Icons.cancel,
//   //         color: Colors.red,
//   //       );
//   //     }
//   //   }
//   //   return const SizedBox.shrink();
//   // }

//   Widget buildQuestion(Question question) {
//     return Container(
//       margin: EdgeInsets.all(20),
//       height: 540,
//       width: 360,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           Container(
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Center(
//               child: Text(
//                 question.question,
//                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           Column(children: [
//             Container(
//                 // color: Colors.blue,
//                 height: 360,
//                 child: Center(
//                   child: StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection('quizs')
//                         .doc(widget.quizId)
//                         .collection('questions')
//                         .doc(question.id)
//                         .collection('answers')
//                         .snapshots(),
//                     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                       if (snapshot.hasData) {
//                         return ListView.builder(
//                           itemCount: snapshot.data!.docs.length,
//                           shrinkWrap: true,
//                           itemBuilder: (context, index) {
//                             //  final color = getColorForOption(snapshot, index,
//                             //     question.correct_answer, selectedAnswer);
//                             final DocumentSnapshot documentSnapshot =
//                                 snapshot.data!.docs[index];
//                             return GestureDetector(
//                               onTap: _isLocked
//                                   ? () {}
//                                   : () {
//                                       setState(() {
//                                         _isLocked = true;
//                                         print(score);
//                                       });
//                                       if (documentSnapshot['identifier'] == question.correct_answer) {
//                                         score++; // เพิ่มคะแนนเมื่อตอบถูก
//                                       }
//                                     },
//                               child: Container(
//                                 margin: EdgeInsets.symmetric(
//                                     horizontal: 20, vertical: 10),
//                                 height: 65,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                       color: _isLocked
//                                           ? documentSnapshot['identifier'] ==
//                                                   question.correct_answer
//                                               ? Color.fromARGB(
//                                                   255, 140, 232, 36)
//                                               : Color.fromARGB(255, 249, 61, 48)
//                                           : Colors.black),
//                                 ),
//                                 child: question.typeQuestion == 'แบบเขียน'
//                                     ? Container(
//                                         margin: EdgeInsets.all(20),
//                                         child: TextFormField(),
//                                       )
//                                     : Container(
//                                         margin: EdgeInsets.symmetric(
//                                             horizontal: 30),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Text(documentSnapshot['answer'],
//                                                 style: TextStyle(fontSize: 16)),
//                                             _isLocked
//                                                 ? documentSnapshot[
//                                                             'identifier'] ==
//                                                         question.correct_answer
//                                                     ? Icon(Icons.check_circle,
//                                                         color: Color.fromARGB(
//                                                             255, 140, 232, 36))
//                                                     : Icon(Icons.cancel,
//                                                         color: Color.fromARGB(
//                                                             255, 249, 61, 48))
//                                                 : SizedBox.shrink()
//                                           ],
//                                         ),
//                                       ),
//                               ),
//                             );
//                           },
//                         );
//                       } else {
//                         return Center(
//                           child: Text('...กำลังโหลด'),
//                         );
//                       }
//                     },
//                   ),
//                 ))
//           ]),
//         ],
//       ),
//     );
//   }
// }
