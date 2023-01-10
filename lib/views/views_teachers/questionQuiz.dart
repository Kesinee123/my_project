import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/models/question.dart';

class QuestionQuiz extends StatefulWidget {
  QuestionQuiz(
      {required this.question,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4,
      super.key,
      required this.quizId});

  String? question;
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  final String quizId;

  @override
  State<QuestionQuiz> createState() => _QuestionQuizState();
}

class _QuestionQuizState extends State<QuestionQuiz> {
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
            // .where('quizId')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length != 0) {
            } else {
              return noQuestion();
            }
            return Container(
              margin: EdgeInsets.only(top: 200),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return Column(
                      children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: InkWell(
                              onTap: () {},
                              child: ListTile(
                                contentPadding: EdgeInsets.all(20),
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
                                        Row(
                                          children: [
                                            // IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                                            IconButton(
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return Dialog(
                                                          child: Container(
                                                              margin: EdgeInsets
                                                                  .all(20),
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
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 20,
                                                                  ),
                                                                  // MouseRegion(
                                                                  //   cursor: SystemMouseCursors.click,
                                                                  //   child:
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors
                                                                                  .grey),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('ยกเลิก')),
                                                                      SizedBox(
                                                                        width:
                                                                            50,
                                                                      ),
                                                                      ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              backgroundColor: Colors
                                                                                  .red),
                                                                          onPressed:
                                                                              () {
                                                                            deleteQuestion(documentSnapshot.id);
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('ลบ'))
                                                                    ],
                                                                  ),
                                                                  // )
                                                                ],
                                                              )),
                                                        );
                                                      });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'โจทย์ :',
                                            ),
                                          ],
                                        ),
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
                                    // Container(child: Image.network(documentSnapshot['imageUrlQs'])),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Answer(quizId: widget.quizId, questionId: documentSnapshot['questionId'] ,),
                                  ],
                                ),
                                subtitle: 
                                Row(
                                  children: [
                                    Text('type-quizs : ', style: TextStyle(color: Colors.red),),
                                    Text(documentSnapshot['type_quiz'], style: TextStyle(color: Colors.red),),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    );
                  }),
            );
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        });
  }

  noQuestion() {
    return Center(
        child: Text(
      'ไม่มีโจทย์ที่สร้าง',
      style: TextStyle(fontSize: 20, color: Colors.white),
    ));
  }
}

class Answer extends StatefulWidget {
  final String quizId;
  final String questionId;
  const Answer({super.key, required this.quizId, required this.questionId});

  @override
  State<Answer> createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(widget.questionId)
        .collection('answers')
        // .where("identifier1", isEqualTo: '1')
        .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasData){
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
              Icon(Icons.circle),
              // StreamBuilder(
              //   stream: FirebaseFirestore.instance
              //     .collection('quizs')
              //     .doc(widget.quizId)
              //     .collection("questions")
              //     // .where('quizId')
              //     .snapshots(),
              //   // initialData: initialData,
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     if(snapshot.hasData){
              //       if(documentSnapshot[''] == null){
              //         return Icon(Icons.camera);
              //       }
              //     }
              //     return CircularProgressIndicator();
              //   },
              // ),
              // correctAnswer(quizId: widget.quizId,),
              SizedBox(
                width: 10,
              ),
              Text(documentSnapshot['answer'],),
            ],
          ),
      );
            });
        }
       return CircularProgressIndicator();
      }
    );
  }
}

// class correctAnswer extends StatefulWidget {
//    final String quizId;
//   const correctAnswer({super.key, required this.quizId});

//   @override
//   State<correctAnswer> createState() => _correctAnswerState();
// }

// class _correctAnswerState extends State<correctAnswer> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         StreamBuilder<QuerySnapshot<Object>>(
//                 stream: FirebaseFirestore.instance
//                   .collection('quizs')
//                   .doc(widget.quizId)
//                   .collection("questions")
//                   // .where('quizId')
//                   .snapshots(),
//                 // initialData: initialData,
//                 builder: (BuildContext context, AsyncSnapshot snapshot,) {
//                   // final DocumentSnapshot documentSnapshot =
//                   //       snapshot.data!.docs[index];
//                   if(snapshot.hasData){
//                     if(snapshot.data!.docs['questions'] == 'w'){
//                       return Icon(Icons.camera);
//                     }
//                   }
//                   return CircularProgressIndicator();
//                 },
//               ),
//       ],
//     );
//   }
// }