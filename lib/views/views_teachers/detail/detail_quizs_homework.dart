import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:my_project/sheets/student_sheets_api_homework.dart';
import 'package:my_project/views/views_teachers/questionQuiz.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../models/student_homeword.dart';
import '../update/detail_quizs_time._edit.dart';

class DetialQuizs_Homework extends StatefulWidget {
  const DetialQuizs_Homework(
      {super.key,
      required this.quizId,
      required this.questionId,
      required this.startMakeQuiz,
      // required this.timeOfDay,
      required this.path,
      required this.endMakeQuiz});

  final String quizId;
  final String questionId;
  final String startMakeQuiz;
  final String endMakeQuiz;
  final String path;

  @override
  State<DetialQuizs_Homework> createState() => _DetialQuizs_HomeworkState();
}

class _DetialQuizs_HomeworkState extends State<DetialQuizs_Homework> {
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';

  bool linkquiz = false;

  TimeOfDay _timeOfDay = TimeOfDay.now();
  DateTime _dateTime = DateTime.now();

  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((c) => openQuiz());
    // print('link = ${widget.path}');
  }

  openQuiz() {
    if (widget.path == null) {
      setState(() {
        linkquiz = true;
      });
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => QuizPage(
      //       quizId: widget.quizId,
      //     ),
      //   ),
      // );
    }
  }

  //  void _showTimePicker() {
  //   showTimePicker(context: context, initialTime: TimeOfDay.now())
  //       .then((value) {
  //     setState(() {
  //       _timeOfDay = value!;
  //     });
  //   });
  // }

  // void _showDatePicker() {
  //   showDatePicker(
  //           context: context,
  //           initialDate: DateTime.now(),
  //           firstDate: DateTime(2000),
  //           lastDate: DateTime(2025))
  //       .then((value) {
  //     setState(() {
  //       _dateTime = value!;
  //     });
  //   });
  // }

  // editTime() {
  //   showDialog(
  //     context: context,
  //     builder: (_) {
  //       String startMakeQuiz = widget.endMakeQuiz; // เก็บค่าเวลาเดิม

  //       return Dialog(
  //         child: Container(
  //           padding: EdgeInsets.all(10),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(30),
  //           ),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Container(
  //                 width: 300,
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(30),
  //                 ),
  //                 padding: EdgeInsets.all(20),
  //                 child: Column(
  //                   children: [
  //                     Text(
  //                       'แก้กำหนดส่งการบ้าน',
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     SizedBox(height: 20),
  //                     GestureDetector(
  //                       onTap: _showDatePicker,
  //                       child: Container(
  //                         height: 60,
  //                         decoration: BoxDecoration(
  //                           color: Colors.purple,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         padding: EdgeInsets.symmetric(horizontal: 20),
  //                         child: Row(
  //                           children: [
  //                             Icon(Icons.calendar_today, color: Colors.white),
  //                             SizedBox(width: 20),
  //                             Text(
  //                               '${_dateTime.day.toString()}/${_dateTime.month.toString()}/${_dateTime.year.toString()}',
  //                               style: TextStyle(
  //                                   fontSize: 18, color: Colors.white),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 20),
  //                     GestureDetector(
  //                       onTap: _showTimePicker,
  //                       child: Container(
  //                         height: 60,
  //                         decoration: BoxDecoration(
  //                           color: Colors.purple,
  //                           borderRadius: BorderRadius.circular(10),
  //                         ),
  //                         padding: EdgeInsets.symmetric(horizontal: 20),
  //                         child: Row(
  //                           children: [
  //                             Icon(Icons.alarm, color: Colors.white),
  //                             SizedBox(width: 20),
  //                             Text(
  //                               _timeOfDay.format(context).toString(),
  //                               style: TextStyle(
  //                                   fontSize: 18, color: Colors.white),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 20),
  //                     Text(
  //                       'ค่าเวลาเดิม: $startMakeQuiz',
  //                       style: TextStyle(fontSize: 16),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //               ElevatedButton(
  //                 style: ElevatedButton.styleFrom(
  //                   primary: Colors.purple,
  //                   padding: EdgeInsets.symmetric(horizontal: 40),
  //                 ),
  //                 onPressed: () async {
  //                   String date = DateFormat('yyyy-MM-dd').format(_dateTime);
  //                   String time = _timeOfDay.format(context);

  //                   DocumentReference docRef = FirebaseFirestore.instance
  //                       .collection('quizs')
  //                       .doc(widget.quizId);

  //                   await docRef.update({
  //                     'startMakeQuiz': '$date $time', // อัปเดตค่าเวลาใหม่
  //                   });

  //                   Navigator.pop(context); // ปิด dialog
  //                 },
  //                 child: Text(
  //                   'ตกลง',
  //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
  //                 ),
  //               ),
  //               SizedBox(height: 20),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(''),
          centerTitle: true,
          actions: [
            SizedBox(
              width: 20,
            ),
            IconButton(
              onPressed: insertStudentHomeWork,
              icon: Icon(Icons.download),
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: size.height,
              child: Stack(children: [
                Center(
                    child: Container(
                  width: 800,
                  margin: EdgeInsets.only(top: 300),
                  height: 700,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24))),
                  child: QuestionQuiz(
                    question: question,
                    option1: option1,
                    option2: option2,
                    option3: option3,
                    option4: option4,
                    quizId: widget.quizId,
                    questionId: widget.questionId,
                  ),
                )),
                Container(
                  margin: EdgeInsets.all(20),
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('quizs')
                          .doc(widget.quizId)
                          .get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> documentData =
                              snapshot.data!.data();
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "ชื่อแบบทดสอบ :",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${documentData['quizTitle']}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "ชื่อวิชา : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${documentData['quizSubject']}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "เริ่มต้น : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.startMakeQuiz,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "สิ้นสุด : ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    widget.endMakeQuiz,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetialQuizs_Time_Edit(
                                                    path: '',
                                                    quizId: widget.quizId,
                                                    questionId:
                                                        widget.questionId,
                                                    makeQuizEnd:
                                                        widget.endMakeQuiz,
                                                  )));
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  // Text(
                                  //   widget.timeOfDay,
                                  //   style: TextStyle(
                                  //       color: Colors.black, fontSize: 16),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              // แชร์ลิงค์แบบทดสอบให้กับนักเรียน
                              // Row(
                              //   children: [
                              //     Text(
                              //       'แชร์ลิงค์แบบทดสอบให้กับนักเรียน',
                              //       style: TextStyle(color: Colors.white),
                              //     ),
                              //   ],
                              // ),

                              // Row(
                              //   children: [
                              //     Container(
                              //       height: 50,
                              //       width: 300,
                              //       decoration: BoxDecoration(
                              //           // borderRadius: BorderRadius.circular(10),
                              //           border: Border.all(
                              //               color: Colors.black, width: 2),
                              //           color: Colors.white),
                              //       child: Container(
                              //         margin: EdgeInsets.all(10),
                              //         child: Row(
                              //           children: [
                              //             Icon(Icons.link),
                              //             SizedBox(
                              //               width: 20,
                              //             ),
                              //             Text('123456789'),
                              //           ],
                              //         ),
                              //       ),
                              //     ),

                              //   ],
                              // ),
                              Row(
                                children: [
                                  TextButton(
                                      onPressed: () async {
                                        final Map<String, dynamic>
                                            additionalData = {
                                          'quizId': widget.quizId,

                                          // เพิ่มข้อมูลตามต้องการ
                                        };

                                        final dynamicLinkParams =
                                            DynamicLinkParameters(
                                          uriPrefix: 'https://quizs.page.link',
                                          link: Uri.parse(
                                                  'https://quizs.page.link/QuizPage')
                                              .replace(
                                                  queryParameters:
                                                      additionalData),
                                          androidParameters: AndroidParameters(
                                            packageName:
                                                'com.example.my_project',
                                            fallbackUrl: Uri.parse(
                                                'https://myandroidapp.link'),
                                          ),
                                        );

                                        Uri link = await FirebaseDynamicLinks
                                            .instance
                                            .buildLink(dynamicLinkParams);

                                        // ให้แสดง URL ที่มี Query Parameters เพิ่มเติม
                                        print(link);

                                        Share.share(link.toString());

                                        // Save link to Firebase
                                        FirebaseFirestore.instance
                                            .collection('quizs')
                                            .doc(widget.quizId)
                                            .update({
                                          'code': null,
                                          'link': link.toString()
                                        });
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.share,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            'แชร์แบบทดสอบให้นักเรียน',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ],
                              ),
                            ],
                          );
                        }
                        return CircularProgressIndicator();
                      }),
                )
              ]),
            ),
          ]),
        )));
  }

  insertStudentHomeWork() async {
  await StudentSheetApiHomeWork.init();

  final db = FirebaseFirestore.instance
      .collection('quizs')
      .doc(widget.quizId)
      .collection('studentList')
      .where('type_quiz' , isEqualTo: 'การบ้าน');
  try {
    final querySnapshot = await db.get();
    final students = querySnapshot.docs.map((doc) => doc.data()).toList();

    if (students != null && students.isNotEmpty) {
      final studentDataList = students.map((student) {
        final String status = student['status'];
        final DateTime endMakeQuiz = DateTime.parse(
            student['makeQuizEnd']); // แยกวิเคราะห์เวลาสิ้นสุดของแบบทดสอบ

        // ตรวจสอบว่าเวลาปัจจุบันเกินเวลาที่กำหนดหรือไม่
        final bool isExpired = DateTime.now().isAfter(endMakeQuiz);

        final studentData = {
          StudentFieldsHomeWork.id: '${students.indexOf(student) + 1}',
          StudentFieldsHomeWork.name: student['name'],
          // StudentFields.email: student['email'],
          StudentFieldsHomeWork.quizTitle: student['quizTitle'],
          StudentFieldsHomeWork.quizsubject: student['quizSubject'],
          StudentFieldsHomeWork.makeQuizStart: student['makeQuizStart'],
          StudentFieldsHomeWork.makeQuizEnd: student['makeQuizEnd'],
          StudentFieldsHomeWork.score: student['score'],
          StudentFieldsHomeWork.type_quiz: student['type_quiz'],
          StudentFieldsHomeWork.status: isExpired
              ?  status
              : 'เกินเวลาที่กำหนด', // อัปเดตสถานะขึ้นอยู่กับการหมดอายุ
        };

        return studentData;
      }).toList();

      await StudentSheetApiHomeWork.insert(studentDataList);
    }
  } catch (error) {
    print(error);
  }
}
}
