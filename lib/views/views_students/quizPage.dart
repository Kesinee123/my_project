import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:my_project/models/quiz.dart';
import 'package:my_project/views/views_students/questionWidget.dart';

class QuizPage extends StatefulWidget {
  final String quizId;

  const QuizPage({Key? key, required this.quizId});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 151, 114, 253),
        body: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('quizs')
                .doc(widget.quizId)
                .get(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> documentData = snapshot.data!.data();
                return Center(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            height: 300,
                            width: 300,
                            child: Image.network(
                                '${documentData['imageUrl'] ?? ''}')),
                        // Text('ชื่อของแบบทดสอบ : ' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white),),
                        SizedBox(
                          height: 30,
                        ),
                        Flexible(
                            child: Text(
                          '${documentData['quizTitle']}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        )),
                        SizedBox(
                          height: 30,
                        ),
                        // Text('ชื่อของวิชา : ' , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold , color: Colors.white),),

                        Flexible(
                            child: Text(
                          '${documentData['quizSubject']}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        )),
                        SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => QuestionWidget(
                              //       // quizCode: inputNumber,
                              //       quizId: widget.quizId, // ส่งข้อมูลไปด้วย
                              //     ),
                              //   ),
                              // );
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.amber)),
                            child: Text(
                              'เริ่มทำแบบทดสอบ',
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ),
                );
              }
              return Center(
                child: Text('โหลด...'),
              );
            }));
  }
}
