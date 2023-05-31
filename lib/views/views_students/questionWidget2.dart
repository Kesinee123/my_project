import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_project/views/views_students/quizWidget/body.dart';

import '../../controllers/question_controller.dart';

class QuizWidget extends StatefulWidget {
  const QuizWidget({super.key, required this.quizId});

  final String quizId;

  @override
  State<QuizWidget> createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());

    // เก็บรายชื่อนักเรียน
    Stream<DocumentSnapshot<Map<String, dynamic>>> studentDocumentSnapshot =
        FirebaseFirestore.instance
            .collection('quizs')
            .doc(widget.quizId)
            .snapshots();

    studentDocumentSnapshot
        .listen((DocumentSnapshot<Map<String, dynamic>> snapshot) async {
      Map<String, dynamic>? data = snapshot.data();

      String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String time = DateFormat.Hm().format(DateTime.now());

      DocumentReference docRef = FirebaseFirestore.instance
          .collection('quizs')
          .doc(widget.quizId)
          .collection('studentList')
          .doc();
      await docRef.set({
        'studentId': docRef.id,
        'quizId': widget.quizId,
        'name': FirebaseAuth.instance.currentUser!.displayName,
        'email' : FirebaseAuth.instance.currentUser!.email,
        'imageUrl' : FirebaseAuth.instance.currentUser!.photoURL,
        'startmakeQuiz': '$date $time',
        'score' : '0'
        // เวลาจบการทำแบบทดสอบ
        // คะแนนที่ได้
      });
      // String studentId = docRef.id;
      // print('Student ID: $studentId');
    });

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 151, 114, 253),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () =>  _controller.nextQuestion,
            child: Text(
              'ข้าม',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Body(
        quizId: widget.quizId,
      ),
    );
  }
}
