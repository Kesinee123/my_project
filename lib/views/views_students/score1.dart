import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/question_controller.dart';
import 'listname.dart';

class Score1 extends StatefulWidget {
  const Score1({super.key});


  @override
  State<Score1> createState() => _Score1State();
}

class _Score1State extends State<Score1> {
  final QuestionController _controller = Get.put(QuestionController());
  late DocumentReference quizRef; // declare quizRef here

  @override
  Widget build(BuildContext context) {
    
     // แก้ไขแล้วในอีก project
    Future<QuerySnapshot<Map<String, dynamic>>> documentSnapshot =
        FirebaseFirestore.instance.collection('quizs').get();

    documentSnapshot.then((QuerySnapshot<Map<String, dynamic>> snapshot) async {
      for (DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
        // เก็บรายชื่อนักเรียน
        quizRef = FirebaseFirestore.instance
            .collection('quizs')
            .doc(doc.id); // assign quizRef here

        CollectionReference<Map<String, dynamic>> studentListRef =
            quizRef.collection('studentList');
        QuerySnapshot<Map<String, dynamic>> studentListSnapshot =
            await studentListRef.get();

        for (DocumentSnapshot<Map<String, dynamic>> studentDoc
            in studentListSnapshot.docs) {
          String studentId =
              studentDoc.id; // เก็บค่า studentId ของ document นี้

          Map<String, dynamic>? data = studentDoc.data();
          int totalQuestions = data?['questions']?.length ?? 0;
          String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
          String time = DateFormat.Hm().format(DateTime.now());

          DocumentReference docRef = studentListRef.doc(studentId);
          await docRef.update({
            'score': _controller.correct_answer,
            'totalQuestions': totalQuestions,
            'makeQuizEnd': '$date $time',
          });
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 1000,
        width: 500,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 151, 114, 253),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'ยินด้วยที่ทำแบบทดสอบจนจบ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'คะแนนที่ได้ : ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '${_controller.correct_answer}',
              style: TextStyle(
                  color: Colors.amber,
                  fontSize: 80,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ListName(
                                quizId: quizRef.id,
                              )));
                },
                child: Text(
                  'ดูคะแนนของเพื่อนทั้งหมด',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
