import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/views/firestoreservice.dart';
import 'package:my_project/views/views_teachers/update/editQuestion.dart';
import 'package:my_project/views/views_teachers/update/editQuestion2.dart';
import 'package:my_project/views/views_teachers/update/editQuestion3.dart';

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
              margin: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
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
                                            const Text(
                                              'โจทย์ข้อที่ : ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text('${index + 1}'),
                                          ],
                                        ),
                                        const SizedBox(
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
                                                      option1: documentSnapshot[
                                                          'answerId1'],
                                                      option2: documentSnapshot[
                                                          'answerId2'],
                                                      option3: documentSnapshot[
                                                          'answerId3'],
                                                      option4: documentSnapshot[
                                                          'answerId4'],
                                                      correct_answer:
                                                          documentSnapshot[
                                                                  'correct_answer']
                                                              .toString(),
                                                      imageUrl: documentSnapshot['imageUrl']?? null .toString(),
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
                                                        option1:
                                                            documentSnapshot[
                                                                'answerId1'],
                                                        imageUrl: documentSnapshot['imageUrl'] ?? null .toString()
                                                    );
                                                  } else {
                                                    return EditQuestion2(
                                                      quizId: widget.quizId,
                                                      questionId:
                                                          documentSnapshot.id,
                                                      question:
                                                          documentSnapshot[
                                                              'questions'],
                                                      option1: documentSnapshot[
                                                          'answerId1'],
                                                      option2: documentSnapshot[
                                                          'answerId2'],
                                                      option3: documentSnapshot[
                                                          'answerId3'],
                                                      option4: documentSnapshot[
                                                          'answerId4'],
                                                      imageUrl: documentSnapshot['imageUrl'] ?? null .toString(),
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
                                                            const EdgeInsets.all(20),
                                                        height: 150,
                                                        width: 200,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Text(
                                                              'ต้องการลบโจทย์หรือไม่ ??',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            const SizedBox(
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
                                                                    child: const Text(
                                                                        'ยกเลิก')),
                                                                const SizedBox(
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
                                                                    child: const Text(
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
                                    const SizedBox(
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
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                            child: Text(
                                          documentSnapshot['questions']
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 100,
                                        )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        child: documentSnapshot['imageUrl'] !=
                                                null
                                            ? Image.network(
                                                documentSnapshot['imageUrl'],
                                                height: 250,
                                                width: 250,
                                              )
                                            : Container()),
                                    const SizedBox(
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
                                          style: const TextStyle(color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  noQuestion() {
    return Container(
      margin: const EdgeInsets.all(80),
      child: Center(
        child: Column(
          children: const [
            // Image.asset('Question_Mark.webp' , height: 70,),
            SizedBox(
              height: 10,
            ),
            Text(
              'ไม่มีโจทย์คำถามที่สร้าง',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
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
    return Column(
      children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('quizs')
                .doc(widget.quizId)
                .collection('questions')
                .doc(widget.questionId)
                .collection('answers')
                .where("identifier", isEqualTo: '1')
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
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text('คำตอบที่ 1 :' , style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(
                              width: 10,
                            ),
                            // Icon(Icons.circle),
                            widget.correct_answer
                                    .contains(documentSnapshot['identifier'])
                                ? const Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: documentSnapshot['imageUrl'] != null
                                  ? Image.network(
                                      documentSnapshot['imageUrl'],
                                      height: 100,
                                      // width: 50,
                                    )
                                  : Flexible(
                                      child: Text(
                                        documentSnapshot['answer'] ?? '',
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
              return const Center(child: Center(child: CircularProgressIndicator()));
            }),
            StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('quizs')
                .doc(widget.quizId)
                .collection('questions')
                .doc(widget.questionId)
                .collection('answers')
                .where("identifier", isEqualTo: '2')
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
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text('คำตอบที่ 2 :' , style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(
                              width: 10,
                            ),
                            // Icon(Icons.circle),
                            widget.correct_answer
                                    .contains(documentSnapshot['identifier'])
                                ? const Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: documentSnapshot['imageUrl'] != null
                                  ? Image.network(
                                      documentSnapshot['imageUrl'],
                                      height: 100,
                                      // width: 50,
                                    )
                                  : Flexible(
                                      child: Text(
                                        documentSnapshot['answer'] ?? '',
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
              return const Center(child: Center(child: CircularProgressIndicator()));
            }),
            StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('quizs')
                .doc(widget.quizId)
                .collection('questions')
                .doc(widget.questionId)
                .collection('answers')
                .where("identifier", isEqualTo: '3')
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
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text('คำตอบที่ 3 :' , style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(
                              width: 10,
                            ),
                            // Icon(Icons.circle),
                            widget.correct_answer
                                    .contains(documentSnapshot['identifier'])
                                ? const Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: documentSnapshot['imageUrl'] != null
                                  ? Image.network(
                                      documentSnapshot['imageUrl'],
                                      height: 100,
                                      // width: 50,
                                    )
                                  : Flexible(
                                      child: Text(
                                        documentSnapshot['answer'] ?? '',
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
              return const Center(child: Center(child: CircularProgressIndicator()));
            }),
            StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('quizs')
                .doc(widget.quizId)
                .collection('questions')
                .doc(widget.questionId)
                .collection('answers')
                .where("identifier", isEqualTo: '4')
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
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            const Text('คำตอบที่ 4 :' , style: TextStyle(fontWeight: FontWeight.bold),),
                            const SizedBox(
                              width: 10,
                            ),
                            // Icon(Icons.circle),
                            widget.correct_answer
                                    .contains(documentSnapshot['identifier'])
                                ? const Icon(
                                    Icons.circle,
                                    color: Colors.green,
                                  )
                                : const Icon(
                                    Icons.circle,
                                    color: Colors.red,
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: documentSnapshot['imageUrl'] != null
                                  ? Image.network(
                                      documentSnapshot['imageUrl'],
                                      height: 100,
                                      // width: 50,
                                    )
                                  : Flexible(
                                      child: Text(
                                        documentSnapshot['answer'] ?? '',
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
              return const Center(child: Center(child: CircularProgressIndicator()));
            }),
      ],
    );
  }
}
