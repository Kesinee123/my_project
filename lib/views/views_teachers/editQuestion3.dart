import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/models/usermodel.dart';
import 'package:my_project/views/views_teachers/details.dart';
import 'package:intl/intl.dart';

class EditQuestion3 extends StatefulWidget {
  final String quizId;
  final String questionId;
  final String question;
  final String option1;

  const EditQuestion3(
      {super.key, required this.quizId, required this.questionId, required this.question, required this.option1});

  @override
  State<EditQuestion3> createState() => _EditQuestion3State();
}

class _EditQuestion3State extends State<EditQuestion3> {
  final _formKey = GlobalKey<FormState>();
  String question = '';
  String option1 = '';

  final TextEditingController questionEdit = TextEditingController();
  final TextEditingController option1Edit = TextEditingController();

  Future editQuestionWrite() async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    final questionWrite =  FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(widget.questionId)
        .update({
      'questions': questionEdit.text,
      'createdAt': '$date $time',
    });
  }

  Future<void> editAnswer() async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());
    final answersDocumentSnapshot =
        await FirebaseFirestore.instance
            .collection('quizs')
            .doc(widget.quizId)
            .collection('questions')
            .doc(widget.questionId)
            .collection('answers')
            .doc(widget.option1)
            .update({
              'answer' : option1Edit.text,
              'createdAt': '$date $time',
            });
  }

  @override
  Widget build(BuildContext context) {
    questionEdit.text = widget.question;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          'แก้ไขโจทย์คำตอบแบบที่ 3',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ,color: Colors.black),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 119, 86, 174),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Container(
                    color: Colors.deepPurple,
                    // decoration: BoxDecoration(
                    //     image: DecorationImage(
                    //       image: ExactAssetImage("assets/dw.jpg"),
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                    child: Container(
                      width: 800,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 24.0),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "โจทย์คำถาม",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              TextFormField(
                                controller: questionEdit,
                                minLines: 1,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.white),
                                validator: ((val) =>
                                    val!.isEmpty ? "กรอกโจทย์คำถาม" : null),
                                decoration: InputDecoration(
                                  hintText: "",
                                ),
                                // onChanged: (value) {
                                //   question = value;
                                // },
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 80, 150, 0),
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
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.center,
                    width: 800,
                    height: 500,
                    color: Colors.white,
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "คำตอบ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 800,
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
                            return ListTile(
                              title: TextFormField(
                                controller: option1Edit,
                                decoration: InputDecoration(hintText: 'คำตอบ'),
                                onChanged: (value) {
                                  option1 = value;
                                },
                              ),
                            );
                          }
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple),
                          onPressed: () {
                            editQuestionWrite();
                            editAnswer();
                            Navigator.pop(context);
                          },
                          child: Text('บันทึกโจทย์'))
                    ]),
                  )
                ],
              ),
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

  Future<void> normalDialog(BuildContext context, String s) async {
  showDialog(context: context,
  builder: (context) => SimpleDialog(
    title: Text(s),
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () {
            Navigator.pop(context);
          },
          child: Text('ตกลง', style: TextStyle(fontSize: 16, color: Colors.red),),)
        ],
      )
    ],
  ));
}
}
