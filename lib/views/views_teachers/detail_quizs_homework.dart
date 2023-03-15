import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/views_teachers/questionQuiz.dart';

class DetialQuizs_Homework extends StatefulWidget {
  const DetialQuizs_Homework(
      {super.key, required this.quizId, required this.questionId});

  final String quizId;
  final String questionId;

  @override
  State<DetialQuizs_Homework> createState() => _DetialQuizs_HomeworkState();
}

class _DetialQuizs_HomeworkState extends State<DetialQuizs_Homework> {
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text('หน้าการบ้าน'),
          centerTitle: true,
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
                  height: 600,
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
                                  Text(
                                    "${documentData['quizTitle']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "ชื่อวิชา : ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
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
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "เริ่มต้น : ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '12.00 น.',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "สิ้นสุด : ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    '00.00 น.',
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
                                    'แชร์ลิงค์แบบทดสอบให้กับนักเรียน',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black, width: 2),
                                        color: Colors.white),
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Row(
                                        children: [
                                          Icon(Icons.link),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text('123456789'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  
                                ],
                              ),
                            SizedBox(height: 20,),
                             Row(
                              
                              children: [
                                ElevatedButton(onPressed: (){}, child: Text('ยกเลิก')),
                                SizedBox(width: 20,),
                                ElevatedButton(onPressed: (){}, child: Text('คัดลอกลิงค์')),
                              ],
                             )
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
}
