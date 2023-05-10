// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:my_project/models/option.dart';
// import 'package:my_project/models/question.dart';
// import 'package:my_project/views/views_students/score.dart';

// class optionWidget extends StatefulWidget {
//   const optionWidget({
//     key,
//     required this.quizId,
//     required this.questionId,
//     required this.typeQuestion,
//     required this.correct_answer,
//   });

//   final String quizId;
//   final String questionId;
//   final String typeQuestion;
//   final String correct_answer;

//   @override
//   State<optionWidget> createState() => _optionWidgetState();
// }

// class _optionWidgetState extends State<optionWidget> {
//   String selectedAnswer =
//       ''; // สร้างตัวแปรไว้เก็บ index ของตัวเลือกที่ถูกเลือกไว้
//   int score = 0;

//   PageController? _pageController;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _pageController = PageController(initialPage: 0);
//   // }

//   @override
//   void initState() {
//     super.initState();
//     score = 0;
//     _pageController = PageController(initialPage: 0);
//   }

//   @override
//   void dispose() {
//     _pageController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future<List<Option>> getOptions() async {
//       final CollectionReference options = FirebaseFirestore.instance
//           .collection('quizs')
//           .doc(widget.quizId)
//           .collection('questions')
//           .doc(widget.questionId)
//           .collection('answers');
//       QuerySnapshot querySnapshot = await options.get();
//       List<Option> optionsList = [];
//       querySnapshot.docs.forEach((doc) {
//         Option answer = Option(
//           id: doc.id,
//           answer: doc['answer'],
//           identifier: doc['identifier'],
//         );
//         optionsList.add(answer);
//       });
//       return optionsList;
//     }

//     return Center(
//       child: FutureBuilder(
//         future: getOptions(),
//         builder: (context, AsyncSnapshot<List<Option>> snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasData) {
//             return ListView.builder(
//               controller: _pageController,
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       if (snapshot.data![index].identifier ==
//                           widget.correct_answer) {
//                         score += 1;
//                       }
//                       selectedAnswer = snapshot.data![index].identifier;
//                       if (index == snapshot.data!.length - 1) {
//                         // showDialog(
//                         //   context: context,
//                         //   builder: (context) {
//                         //     return Score(
//                         //       score: '$score',
//                         //     );
//                         //   },
//                         // );
//                         showDialog(
//                             context: context,
//                             builder: (context) => AlertDialog(
//                                     title: Text(
//                                       "แจ้งเตือน",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     content:
//                                         Text("แบบทดสอบที่คุณทำได้คะแนน ..."),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () =>
//                                             Navigator.pop(context, 'OK'),
//                                         child: const Text('ตกลง'),
//                                       )
//                                     ]));
//                         _pageController?.nextPage(
//                           duration: Duration(milliseconds: 300),
//                           curve: Curves.easeInOut,
//                         );
//                       }
//                     });
//                     print('Your score is $score');
//                   },
//                   child: Column(
//                     children: [
//                       buildOption(snapshot, index),
//                     ],
//                   ),
//                 );
//               },
//             );
//           } else {
//             return const Text('No Data');
//           }
//         },
//       ),
//     );
//   }

//   Container buildOption(AsyncSnapshot<List<Option>> snapshot, int index) {
//     Color backgroundColor = getBackgroundColor(
//         snapshot, index, widget.correct_answer, selectedAnswer);
//     return Container(
//       height: 70,
//       padding: const EdgeInsets.all(12),
//       margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.green),
//       ),
//       child: widget.typeQuestion == 'แบบเขียน'
//           ? TextFormField()
//           : Row(
//               children: [
//                 Text(
//                   snapshot.data![index].answer,
//                   style: const TextStyle(fontSize: 16),
//                 )
//                 // getIconForOption(option, question),
//               ],
//             ),
//     );
//   }

//   Color getBackgroundColor(AsyncSnapshot<List<Option>> snapshot, int index,
//       String correctAnswer, String selectedAnswer) {
//     if (snapshot.data![index].identifier == selectedAnswer) {
//       if (snapshot.data![index].identifier == correctAnswer) {
//         return Color.fromARGB(255, 140, 232, 36);
//       } else {
//         return Color.fromARGB(255, 249, 61, 48);
//       }
//     } else {
//       return Colors.white;
//     }
//   }
// }
