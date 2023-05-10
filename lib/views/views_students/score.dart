// import 'dart:async';
// import 'dart:math';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:my_project/controllers/question.dart';

// import 'listname.dart';

// class Score extends StatefulWidget {
//   const Score({super.key, required this.score});

//   final String score;

//   @override
//   State<Score> createState() => _ScoreState();
// }

// class _ScoreState extends State<Score> {
//   bool isBack = false;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _navigatetScore();
//   // }

//   // _navigatetScore() async {
//   //   await Future.delayed(Duration(milliseconds: 2000), () {});
//   //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListName()));
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 151, 114, 253),
//         body: SafeArea(
//             child: Center(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//               SizedBox(
//                 width: 309,
//                 height: 474,
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10.0),
//                       image: const DecorationImage(
//                           image: AssetImage("assets/face.png"))),
//                   child: Center(
//                       child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Spacer(
//                         flex: 3,
//                       ),
//                       CircleAvatar(
//                         radius: 80,
//                         backgroundImage: NetworkImage(
//                             FirebaseAuth.instance.currentUser!.photoURL!),
//                       ),
//                       const Spacer(),
//                       Text(
//                         FirebaseAuth.instance.currentUser!.displayName!,
//                         style: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       const Spacer(),
//                       Text(
//                         widget.score,
//                         style: const TextStyle(
//                             fontSize: 30, fontWeight: FontWeight.bold),
//                       ),
//                       const Spacer(
//                         flex: 3,
//                       )
//                     ],
//                   )),
//                 ),
//               )
//             ]))));
//   }
// }
