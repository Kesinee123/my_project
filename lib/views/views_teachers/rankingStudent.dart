import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/views_teachers/homepage.dart';

import '../../models/student.dart';
import '../../sheets/student_sheets_api.dart';

class RankingStudent extends StatefulWidget {
  const RankingStudent({super.key, required this.quizId});

  final String quizId;

  @override
  State<RankingStudent> createState() => _RankingStudentState();
}

class _RankingStudentState extends State<RankingStudent> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // backgroundColor: Colors.purple,
            body: Container(
                height: 1000,
                color: Colors.grey[300],
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(colors:[ Colors.deepPurple , Colors.purple])
                // ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: () {
                                showSheet(context);
                              },
                              icon: const Icon(Icons.exit_to_app))),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: 500,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.purple),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'ลำดับ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'ชื่อ-นามสกุล',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'คะแนน',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('quizs')
                              .doc(widget.quizId)
                              .collection('studentList')
                              .orderBy('score', descending: true)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        snapshot.data!.docs[index];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${index + 1}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons.arrow_drop_up,
                                                  color: Colors.black,
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      documentSnapshot[
                                                          'imageUrl'])),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                documentSnapshot['name'],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20, top: 5),
                                            child: Text(
                                              documentSnapshot['score'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }))
                ]))));
  }

  showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                // top: 20,
                // left: 20,
                // right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 60,
                      color: Colors.green,
                      child: ButtonWidget(
                        onClicked: () async {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                      title: Text(
                                        "แจ้งเตือน",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      content: Text(
                                          "การดาวน์โหลด ข้อมูลของนักเรียนของคุณสำเร็จแล้ว"),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
                                          child: const Text('ตกลง'),
                                        )
                                      ]));
                          insertStudent();
                          // final student = {
                          //   StudentFields.id : 1,
                          //   StudentFields.name : 'pailin',
                          //   StudentFields.email : '123@gmail.com',
                          //   StudentFields.score : '10'
                          // };
                          // await StudentSheetApi.insert([student]);
                        },
                      )),
                  Container(
                    color: Colors.red,
                    child: ListTile(
                      leading: Icon(
                        Icons.exit_to_app,
                        color: Colors.white,
                        size: 20,
                      ),
                      title: Text(
                        'ออกจากแบบทดสอบ',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      path: '',
                                    )));
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> insertStudent() async {
    int index = 0;
    final db = FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('studentList')
        .where('type_quiz' ,isEqualTo: 'ห้องเรียน');
    try {
      final querySnapshot = await db.get();
      final students = querySnapshot.docs.map((doc) => doc.data()).toList();

      if (students != null && students.isNotEmpty) {
        final studentDataList = students.map((student) {
          final studentData = {
            StudentFields.id: '${index + 1}',
            StudentFields.name: student['name'],
            // StudentFields.email: student['email'],
            StudentFields.quizTitle: student['quizTitle'],
            StudentFields.quizsubject: student['quizSubject'],
            // StudentFields.makeQuizStart: student['makeQuizStart'],
            // StudentFields.makeQuizEnd: student['makeQuizEnd'],
            StudentFields.score: student['score'],
            StudentFields.status: student['type_quiz'],
          };
          return studentData;
        }).toList();

        await StudentSheetApi.insert(studentDataList);
      }
    } catch (error) {
      print(error);
    }
  }
}

class ButtonWidget extends StatelessWidget {
  // final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    super.key,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) => ElevatedButton(
      onPressed: onClicked,
      child: Row(
        children: [
          SizedBox(
            width: 30,
          ),
          Icon(
            Icons.download,
            color: Colors.white,
            size: 20,
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            'ดาวน์โหลด',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ));
}
