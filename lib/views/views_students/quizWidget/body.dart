import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:my_project/controllers/question_controller.dart';
import 'package:my_project/models/option.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/views/views_students/quizWidget/question.dart';
import 'package:my_project/views/views_students/quizWidget/time.dart';

import '../questionWidget2.dart';
import 'option.dart';

class Body extends StatefulWidget {
  const Body({super.key, required this.quizId});

  final String quizId;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // ดึงข้อมูล firebase ของ questions
  Future<List<Question>> getQuestions() async {
    final CollectionReference questions = FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions');
    QuerySnapshot querySnapshot = await questions.get();
    List<Question> questionsList = [];
    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      List<Option> optionsList = [];
      // Fetch options for the current question
      QuerySnapshot optionsSnapshot =
          await doc.reference.collection('answers').get();
      for (QueryDocumentSnapshot optionDoc in optionsSnapshot.docs) {
        Option option = Option(
          id: optionDoc.id,
          answer: optionDoc['answer'].toString(),
          identifier: optionDoc['identifier'].toString(),
          imageUrl: optionDoc['imageUrl'].toString(),
        );
        optionsList.add(option);
      }
      // Create the Question object with options
      Question question = Question(
        id: doc.id,
        question: doc['questions'].toString(),
        typeQuestion: doc['type_quiz'].toString(),
        correct_answer: doc['correct_answer'].toString(),
        options: optionsList,
      );
      questionsList.add(question);
    }
    return questionsList;
  }

  final QuestionController _controller = Get.put(QuestionController());
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Time(),
              ),

              // Questions
              Expanded(
                child: FutureBuilder(
                  future: getQuestions(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data!.length,
                              controller: _controller.pageController,
                              onPageChanged: _controller.updateTheQsNum,
                              itemBuilder: (context, index) => questionPage(
                                question: snapshot.data![index],
                                qsint: index,
                                length: snapshot.data!.length,
                                quizId: widget.quizId,
                                // qsint: index,
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class questionPage extends StatefulWidget {
  const questionPage({
    Key? key,
    required this.question,
    required this.qsint,
    required this.length,
    required this.quizId,
    // required this.qsint,
  }) : super(key: key);

  final Question question;
  final int qsint;
  final int length;
  final String quizId;

  @override
  State<questionPage> createState() => _questionPageState();
}

class _questionPageState extends State<questionPage> {
  QuestionController _controller = Get.put(QuestionController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text.rich(
            TextSpan(
                text: 'โจทย์ข้อที่ ${widget.qsint + 1}',
                // text: 'โจทย์ข้อที่ 1',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: ' / ${widget.length.toString()}',
                      // text: widget.question,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ]),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Divider(
            thickness: 1.5,
          ),
        ),
        // SizedBox(
        //   height: 20,
        // ),
        
          
            Container(
              height: 530,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    // question
                    Text(
                      widget.question.question,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Image.network(
                    //   'https://thumbs.dreamstime.com/b/computer-code-30692565.jpg',
                    //   height: 200, width: 200,
                    // ),
                    // Options
                    ...List.generate(
                        widget.question.options.length,
                        (index) => optionPage(
                              quizId: widget.quizId,
                              questionId: widget.question.id,
                              opindex: index,
                              question: widget.question,
                              press: () => _controller.checkAns(widget.question,
                                  widget.question.options, index, widget.length),
                            )),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          
        
      ],
    );
  }
}

class optionPage extends StatefulWidget {
  const optionPage({
    super.key,
    required this.quizId,
    required this.questionId,
    required this.opindex,
    required this.press,
    required this.question,
  });

  final String quizId;
  final String questionId;
  final int opindex;
  final VoidCallback press;
  final Question question;

  @override
  State<optionPage> createState() => _optionPageState();
}

class _optionPageState extends State<optionPage> {
  String selectedAnswer = '';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          Color getTheRightColor() {
            if (qnController.isLocked) {
              if (qnController.identifier == qnController.correct_answer) {
                return Colors.green;
              } else {
                return Colors.red;
              }
            }
            return Colors.black;
          }

          Widget getTheRightIcon() {
            if (qnController.isLocked) {
              if (qnController.identifier == qnController.correct_answer) {
                return Icon(
                  Icons.check_circle,
                  color: Colors.green,
                );
              } else {
                return Icon(
                  Icons.cancel,
                  color: Colors.red,
                );
              }
            }

            return SizedBox.shrink();
          }

          return InkWell(
            onTap: widget.press,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: getTheRightColor()),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                children: [
                  // Text(widget.question.options[opindex].identifier),
                  Text(
                    '${widget.opindex + 1} .',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.question.options[widget.opindex].answer,
                    style: TextStyle(fontSize: 16),
                  ),
                  // Image.network(
                  //     'https://thumbs.dreamstime.com/b/computer-code-30692565.jpg',
                  //     height: 100, width: 100,
                  //   ),
                  Spacer(),
                  getTheRightIcon()
                ],
              ),
            ),
          );
        });
  }
}
