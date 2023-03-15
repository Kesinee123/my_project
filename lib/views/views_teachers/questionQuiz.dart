import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/views/firestoreservice.dart';
import 'package:my_project/views/views_teachers/correctAnswer.dart';
import 'package:my_project/views/views_teachers/editQuestion.dart';
import 'package:my_project/views/views_teachers/editQuestion2.dart';
import 'package:my_project/views/views_teachers/editQuestion3.dart';

class QuestionQuiz extends StatefulWidget {
  QuestionQuiz(
      {required this.question,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      super.key,
      required this.quizId,
      required this.questionId});

  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  final String quizId;
  final String questionId;
  // final String option1;

  @override
  State<QuestionQuiz> createState() => _QuestionQuizState();
}

class _QuestionQuizState extends State<QuestionQuiz> {
  List<String> popList = ["แก้ไข", "ลบ"];

  Text? correct_answer;

  Future<void> deleteQuestion(id) async {
    await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('quizs')
            .doc(widget.quizId)
            .collection("questions")
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length != 0) {
            } else {
              return noQuestion();
            }
            return Container(
              margin: EdgeInsets.only(top: 20),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return Column(
                      children: [
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                // contentPadding: EdgeInsets.all(20),
                                title: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'โจทย์ข้อที่ : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('${index + 1}'),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        PopupMenuButton(onSelected: (value) {
                                          if (value == "แก้ไข") {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  // int correct_answerInt = int.parse(documentSnapshot['correct_answer']);
                                                  if (documentSnapshot[
                                                          'type_quiz'] ==
                                                      'เลือกได้ 1 คำตอบ') {
                                                    return EditQuestion(
                                                      quizId: widget.quizId,
                                                      questionId:
                                                          documentSnapshot.id,
                                                      question:
                                                          documentSnapshot[
                                                              'questions'],
                                                      option1: documentSnapshot['answerId1'],
                                                      option2: documentSnapshot['answerId2'],
                                                      option3: documentSnapshot['answerId3'],
                                                      option4: documentSnapshot['answerId4'],
                                                      correct_answer: documentSnapshot['correct_answer'].toString(),
                                                     
                                                    );
                                                  } else if (documentSnapshot[
                                                          'type_quiz'] ==
                                                      'แบบเขียน') {
                                                    return EditQuestion3(
                                                      quizId: widget.quizId,
                                                      questionId:
                                                          documentSnapshot.id,
                                                      question:
                                                          documentSnapshot[
                                                              'questions'],
                                                      option1: documentSnapshot['answerId1'],
                                                    );
                                                  } else {
                                                    return EditQuestion2(
                                                      quizId: widget.quizId,
                                                      questionId:
                                                          documentSnapshot.id,
                                                      question:
                                                          documentSnapshot[
                                                              'questions'],
                                                              option1: documentSnapshot['answerId1'],
                                                              option2: documentSnapshot['answerId2'],
                                                              option3: documentSnapshot['answerId3'],
                                                              option4: documentSnapshot['answerId4'],
                                                    );
                                                  }
                                                  // return Center(child: CircularProgressIndicator());
                                                });
                                          } else {
                                            showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return Dialog(
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.all(20),
                                                        height: 150,
                                                        width: 200,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'ต้องการลบโจทย์หรือไม่ ??',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                            ),

                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .grey),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'ยกเลิก')),
                                                                SizedBox(
                                                                  width: 50,
                                                                ),
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        backgroundColor:
                                                                            Colors
                                                                                .red),
                                                                    onPressed:
                                                                        () {
                                                                      deleteQuestion(
                                                                          documentSnapshot
                                                                              .id);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: Text(
                                                                        'ลบ'))
                                                              ],
                                                            ),
                                                            // )
                                                          ],
                                                        )),
                                                  );
                                                });
                                          }
                                        }, itemBuilder: (context) {
                                          return popList
                                              .map((e) => PopupMenuItem(
                                                  value: e, child: Text(e)))
                                              .toList();
                                        }),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: [
                                        //     Text(
                                        //       'โจทย์ :', style: TextStyle(fontWeight: FontWeight.bold),
                                        //     ),
                                        //   ],
                                        // ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                            child: Text(
                                          documentSnapshot['questions'],
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 10,
                                        )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        child: documentSnapshot['imageUrl'] !=
                                                null
                                            ? Image.network(
                                                documentSnapshot['imageUrl'],
                                                height: 300,
                                                width: 300,
                                              )
                                            : Container()),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Answer(
                                      quizId: widget.quizId,
                                      questionId: documentSnapshot.id,
                                      correct_answer:
                                          documentSnapshot['correct_answer']
                                              .toString(),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          documentSnapshot['type_quiz'],
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Divider(
                                      color: Colors.black,
                                    )
                                    //  Text(documentSnapshot['correct_answer'].toString())
                                  ],
                                ),
                              ),
                            ))
                      ],
                    );
                  }),
            );
          } else {
            // return Scaffold(body: Center(child: CircularProgressIndicator()));
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  noQuestion() {
    return Container(
      margin: EdgeInsets.all(80),
      child: Center(
          child: Column(
            children: [
              Image.network('https://static.wikia.nocookie.net/scribblenauts/images/6/60/Question_Mark.png/revision/latest?cb=20140409201911' , height: 70,),
              SizedBox(height: 10,),
              Text(
                'ไม่มีโจทย์คำถามที่สร้าง',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),),
    );
  }
}

class Answer extends StatefulWidget {
  final String quizId;
  final String questionId;
  final String correct_answer;

  const Answer(
      {super.key,
      required this.quizId,
      required this.questionId,
      required this.correct_answer});

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  List<String> myFunction() {
    return ['1', '2'];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('quizs')
            .doc(widget.quizId)
            .collection('questions')
            .doc(widget.questionId)
            .collection('answers')
            // .where("identifier1", isEqualTo: '1')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text('คำตอบที่ ${index + 1} :'),
                        SizedBox(
                          width: 10,
                        ),
                        // Icon(Icons.circle),
                        widget.correct_answer
                                .contains(documentSnapshot['identifier'])
                            ? Icon(
                                Icons.circle,
                                color: Colors.green,
                              )
                            : Icon(
                                Icons.circle,
                                color: Colors.red,
                              ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: documentSnapshot['imageUrl'] != null
                              ? Image.network(
                                  documentSnapshot['imageUrl'],
                                  height: 100,
                                  width: 100,
                                )
                              : Flexible(
                                  child: Text(
                                    documentSnapshot['answer'],
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                });
          }
          return Center(child: Center(child: CircularProgressIndicator()));
        });
  }
}
