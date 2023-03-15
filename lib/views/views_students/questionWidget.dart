import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controllers/question.dart';
import 'package:my_project/models/option.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/views/views_students/option.dart';
import 'package:my_project/views/views_students/progressBar.dart';
import 'package:my_project/views/views_students/question_card.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({key, required this.quizId});

  final String quizId;
  
  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  
  Future<List<Question>> getQuestions() async {
    final CollectionReference questions =
        FirebaseFirestore.instance.collection('quizs').doc(widget.quizId).collection('questions');
    QuerySnapshot querySnapshot = await questions.get();
    List<Question> questionsList = [];
    querySnapshot.docs.forEach((doc) {
      Question question = Question(
        id: doc.id,
        question: doc['questions'],
      );
      questionsList.add(question);
    });
    return questionsList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlue,
        body: SafeArea(
          child: Center(
            child: FutureBuilder(
              future: getQuestions(),
              builder: (context, AsyncSnapshot<List<Question>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasData) {
                  return PageView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/logo.png'),
                                height: 50,
                                width: 50,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'QUIZZZ',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ProgressBar(),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            height: 550,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                                margin: EdgeInsets.all(20),
                                child: Center(
                                    child: Column(
                                  children: [
                                    Text(snapshot.data![index].question , style: TextStyle(fontSize: 16),),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Image.asset(
                                      'assets/logo.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Container(
                                        height: 355,
                                        width: 500,
                                        // decoration: BoxDecoration(
                                        //   borderRadius:
                                        //       BorderRadius.circular(20),
                                        //   // color: Colors.white,
                                        // ),
                                        child: optionWidget(quizId: widget.quizId, questionId: snapshot.data![index].id )
                                        // optionWidget()
                                        
                                        )
                                  ],
                                ))),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return Text('No Data');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
