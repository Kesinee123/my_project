// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:my_project/controllers/question.dart';
// import 'package:my_project/models/question.dart';
// import 'package:my_project/views/views_students/option.dart';
// import 'package:my_project/views/views_students/questionWidget.dart';

// class QuestionCard extends StatelessWidget {
//   const QuestionCard({
//     super.key, required this.question,
//   });

//   final Question question;


//   @override
//   Widget build(BuildContext context) {
//     QuestionController _controller = Get.put(QuestionController());
//      return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Column(
//         children: [
//         Text(
//           question.question,
//             style: TextStyle(
//               fontSize: 18,
//             )),
//         SizedBox(height: 20,),
//         ...List.generate(
//           question.options.length,
//           (index) => Option(
//             text: question.options[index],
//             index: index,
//             press: () => _controller.checkAns(question, index)))
//       ]),
//     );
//   }
// }