import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/views/firestoreservice.dart';
import 'package:my_project/views/views_teachers/details.dart';
import 'package:my_project/views/views_teachers/homepage.dart';

class EditQuestion extends StatefulWidget {
  const EditQuestion({
    super.key,
    required this.quizId,
    required this.questionId,
    required this.question,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.correct_answer,
  });
  final String quizId;
  final String questionId;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String correct_answer;

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {
  final _formKey = GlobalKey<FormState>();
  // String question = '';
  // String option1 = '';
  // String option2 = '';
  // String option3 = '';
  // String option4 = '';

  int correct_answer = 0;

  final TextEditingController questionEdit = TextEditingController();
  final TextEditingController option1Edit = TextEditingController();
  final TextEditingController option2Edit = TextEditingController();
  final TextEditingController option3Edit = TextEditingController();
  final TextEditingController option4Edit = TextEditingController();

  Future editQuestionRadio() async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    final questionDocumentReference = FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(widget.questionId);

    await questionDocumentReference.update({
      'questions': questionEdit.text,
      'createdAt': '$date $time',
      'correct_answer': correct_answer
    });
  }

  Future<void> editAnswer() async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());
    final answersDocumentSnapshot = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(widget.questionId)
        .collection('answers')
        .doc(widget.option1)
        .update({
      'answer': option1Edit.text,
      'createdAt': '$date $time',
    });

    final answersDocumentSnapshot2 = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(widget.questionId)
        .collection('answers')
        .doc(widget.option2)
        .update({
      'answer': option2Edit.text,
      'createdAt': '$date $time',
    });

    final answersDocumentSnapshot3 = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(widget.questionId)
        .collection('answers')
        .doc(widget.option3)
        .update({
      'answer': option3Edit.text,
      'createdAt': '$date $time',
    });

    final answersDocumentSnapshot4 = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(widget.questionId)
        .collection('answers')
        .doc(widget.option4)
        .update({
      'answer': option4Edit.text,
      'createdAt': '$date $time',
    });
  }

  @override
  Widget build(BuildContext context) {
    questionEdit.text = widget.question;
    // int correct_answer = int.parse(widget.correct_answer); // แสดงข้อที่เลือก

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          'แก้ไขโจทย์คำตอบแบบที่ 1',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(top: 50),
                  color: Colors.deepPurple,
                  // decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: ExactAssetImage("assets/dw.jpg"),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "โจทย์คำถาม",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: questionEdit,
                              minLines: 1,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              // onChanged: (value) {
                              //   setState(() {
                              //     questionEdit.text = value;
                              //   });
                              // },
                              style: TextStyle(color: Colors.white),
                              validator: ((val) =>
                                  val!.isEmpty ? "กรอกโจทย์คำถาม" : null),
                              decoration: InputDecoration(
                                hintText: "",
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Center(
                            //   child: _imageQs == null ? null : Image.file(_imageQs!, height: 300,width: 300,)
                            // ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 150, 0),
                              child: ElevatedButton.icon(
                                onPressed: (() {}),
                                icon: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  "เพิ่มรูปภาพ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.yellow),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "เลือกได้ 1 ข้อเท่านั้น !!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('quizs')
                          .doc(widget.quizId)
                          .collection('questions')
                          .doc(widget.questionId)
                          .collection('answers')
                          .doc(widget.option1)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return Text('ไม่มีคำตอบ');
                        }
                        Map<String, dynamic> answerData =
                            snapshot.data!.data()! as Map<String, dynamic>;
                        option1Edit.text = answerData['answer'];
                        

                        // correct_answer =  widget.correct_answer;
                        // String str = answerData['correct_answer'] != null ? answerData['correct_answer'].toString() : '';

                        return RadioListTile(
                            activeColor: Colors.red,
                            secondary: IconButton(
                                onPressed: () {
                                  // imagePicker();
                                },
                                icon: Icon(Icons.add_a_photo)),
                            value: 1,
                            groupValue: correct_answer,
                            onChanged: (value) {
                              setState(() {
                                correct_answer = value!;
                              });
                            },
                            title: Container(
                              // color: Colors.red,
                              child: TextFormField(
                                controller: option1Edit,
                                minLines: 1,
                                maxLines: 3,
                                validator: ((val) =>
                                    val!.isEmpty ? "กรอกคำตอบ" : null),
                                decoration:
                                    InputDecoration(hintText: 'คำตอบที่ 1'),
                              ),
                            ));
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('quizs')
                        .doc(widget.quizId)
                        .collection('questions')
                        .doc(widget.questionId)
                        .collection('answers')
                        .doc(widget.option2)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      if (!snapshot.hasData || !snapshot.data!.exists) {
                        return Text('ไม่มีคำตอบ');
                      }
                      Map<String, dynamic> answerData =
                          snapshot.data!.data()! as Map<String, dynamic>;
                      option2Edit.text = answerData['answer'];
                      
                      return Center(
                        child: RadioListTile(
                          activeColor: Colors.red,
                          secondary: IconButton(
                              onPressed: () {}, icon: Icon(Icons.add_a_photo)),
                          value: 2,
                          groupValue: correct_answer,
                          onChanged: (value) {
                            setState(() {
                              correct_answer = value!;
                            });
                          },
                          title: TextFormField(
                            controller: option2Edit,
                            minLines: 1,
                            maxLines: 3,
                            validator: ((val) =>
                                val!.isEmpty ? "กรอกคำตอบ" : null),
                            // onChanged: (value) {
                            //   setState(() {
                            //     option2 = value;
                            //   });
                            // },
                            decoration: InputDecoration(hintText: 'คำตอบที่ 2'),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('quizs')
                          .doc(widget.quizId)
                          .collection('questions')
                          .doc(widget.questionId)
                          .collection('answers')
                          .doc(widget.option3)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return Text('ไม่มีคำตอบ');
                        }
                        Map<String, dynamic> answerData =
                            snapshot.data!.data()! as Map<String, dynamic>;
                        option3Edit.text = answerData['answer'];
                        
                        return RadioListTile(
                          activeColor: Colors.red,
                          secondary: IconButton(
                              onPressed: () {}, icon: Icon(Icons.add_a_photo)),
                          value: 3,
                          groupValue: correct_answer,
                          onChanged: (value) {
                            setState(() {
                              correct_answer = value!;
                            });
                          },
                          title: TextFormField(
                            controller: option3Edit,
                            minLines: 1,
                            maxLines: 3,
                            validator: ((val) =>
                                val!.isEmpty ? "กรอกคำตอบ" : null),
                            // onChanged: (value) {
                            //   setState(() {
                            //     option3 = value;
                            //   });
                            // },
                            decoration: InputDecoration(hintText: 'คำตอบที่ 3'),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('quizs')
                          .doc(widget.quizId)
                          .collection('questions')
                          .doc(widget.questionId)
                          .collection('answers')
                          .doc(widget.option4)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return Text('ไม่มีคำตอบ');
                        }
                        Map<String, dynamic> answerData =
                            snapshot.data!.data()! as Map<String, dynamic>;
                        option4Edit.text = answerData['answer'];
                        
                        return RadioListTile(
                          activeColor: Colors.red,
                          secondary: IconButton(
                              onPressed: () {}, icon: Icon(Icons.add_a_photo)),
                          value: 4,
                          groupValue: correct_answer,
                          onChanged: (value) {
                            setState(() {
                              correct_answer = value!;
                            });
                          },
                          title: TextFormField(
                            controller: option4Edit,
                            minLines: 1,
                            maxLines: 3,
                            validator: ((val) =>
                                val!.isEmpty ? "กรอกคำตอบ" : null),
                            // onChanged: (value) {
                            //   setState(() {
                            //     option4 = value;
                            //   });
                            // },
                            decoration: InputDecoration(hintText: 'คำตอบที่ 4'),
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsQuizs(
                                        quizId: widget.quizId,
                                        questionId: widget.questionId,
                                      )));
                        },
                        child: Text('ยกเลิก')),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple),
                        onPressed: () {
                          // print('โจทย์ : $question ,คำตอบทีถูก = $selected , คำตอบอื่นๆ = $option1 $option2 $option3 $option4');
                          editQuestionRadio();
                          editAnswer();
                          Navigator.pop(context);
                        },
                        child: Text('บันทึกโจทย์')),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showSnackbar(context, color, message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 14),
      ),
      backgroundColor: color,
      duration: Duration(seconds: 5),
    ));
  }
}

Future<void> normalDialog(BuildContext context, String s) async {
  showDialog(
      context: context,
      builder: (context) => SimpleDialog(
            title: Text(s),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ตกลง',
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  )
                ],
              )
            ],
          ));
}
