// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:my_project/controllers/question.dart';

// class Score extends StatefulWidget {
//   const Score({super.key});

//   @override
//   State<Score> createState() => _ScoreState();
// }

// class _ScoreState extends State<Score> {

//   bool isBack = true;
//   double angle = 0;

//   void _flip() {
//     setState(() {
//       angle = (angle + pi) % (2* pi);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     QuestionController _quController = Get.put(QuestionController());
//     return Scaffold(
//       backgroundColor: Color(0xFF292a3e),
//       body: SafeArea(
//         child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: _flip,
//               child: TweenAnimationBuilder(tween: Tween<double>(begin: 0 , end: angle),
//               duration: Duration(seconds: 1),
//               builder: (BuildContext context, double value , _) {
//                 if (value >= (pi / 2)) {
//                   isBack = false;
//                 }else{
//                   isBack = true;
//                 }
//                 return (
//                   Transform(
//                     alignment: Alignment.center,
//                 transform: Matrix4.identity()
//                 ..setEntry(3, 2, 0.001)
//                 ..rotateY(value)
//                 ,
//                 child: Container(
//                   width: 309,
//                   height: 474,
//                   child: isBack
//                   ? Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       image: DecorationImage(image: AssetImage("assets/back.png"))
//                     ),
//                   ) : Transform(
//                     alignment: Alignment.center,
//                     transform: Matrix4.identity()
//                     ..rotateY(pi),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10.0),
//                         image: DecorationImage(image: AssetImage("assets/face.png"))
//                       ),
//                       child: Center(child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Spacer(flex: 3,),
//                           Text('คะแนน' , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
//                           Spacer(),
//                           Image.asset('assets/win.png', height: 180, width: 180 ,),
//                           // CircleAvatar(
//                           //   radius: 70,
//                           // ),
//                           Spacer(),
//                           Text('20/30',style: TextStyle(fontSize: 30),),
//                           // Text('${_quController.correctAns! * 10}/${_quController.questions.length * 10}',style: TextStyle(fontSize: 30),),
//                           Spacer(flex: 3,)
//                         ],
//                       )),
//                     ),
//                   )
//                 ),
//               )
//                 );
//               }),
//             )
//           ],
//         ) ,)),
//     );
//   }
// }