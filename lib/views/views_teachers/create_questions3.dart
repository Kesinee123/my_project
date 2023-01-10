import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/models/usermodel.dart';
import 'package:my_project/views/views_teachers/add_questions.dart';
import 'package:my_project/views/views_teachers/details.dart';
import 'package:intl/intl.dart';

class CreateQuestion3 extends StatefulWidget {

  final String quizId;

const  CreateQuestion3({super.key, required this.quizId});

  @override
  State<CreateQuestion3> createState() => _CreateQuestion3State();
}

class _CreateQuestion3State extends State<CreateQuestion3> {

  final _formKey = GlobalKey<FormState>();
  String question = '';
  String option1 = '';

  Future createQuestionWrite(String question,)async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    DocumentReference questionWrite = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .add({
      'questions': question,
      'createdAt': '$date $time',
      'quizId': widget.quizId,
      'type_quiz': 'Write',
      // "correct_answer" : correct_answer
    });
    await questionWrite.update({
      "questionId": questionWrite.id,
    });
     DocumentReference questionAnwer1 = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionWrite.id)
        .collection('answers')
        .add({
      'answer': option1,
      // 'identifier': '1',
      "questionId": questionWrite.id,
    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(backgroundColor: Colors.deepPurple,),
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
                                        Text("โจทย์คำถาม",style: TextStyle(color: Colors.white,fontSize: 18),),
                                        TextFormField(
                                          minLines: 1,
                                          maxLines: 5,
                                          keyboardType: TextInputType.multiline,
                                          style: TextStyle(color: Colors.white),
                                          validator: ((val) => val!.isEmpty
                                              ? "กรอกโจทย์คำถาม"
                                              : null),
                                          decoration:
                                              InputDecoration(hintText: "",),
                                              
                                         onChanged:(value) {
                                           question = value;
                                         },
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 80, 150, 0),
                                          child: ElevatedButton.icon(
                                            onPressed: (() {}),
                                            icon: Icon(Icons.add_a_photo,color: Colors.black,),
                                            label: Text("เพิ่มรูปภาพ", style: TextStyle(color: Colors.black),),
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
                            alignment: Alignment.center,
                            width: 800,
                            height: 500,
                            color: Colors.white,
                            child: Column(children: [
                              SizedBox(height: 20,),
                              Text("คำตอบ",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Container(
                            width: 800,
                            child: ListTile(
                              title: TextFormField(
                                validator: (value) => value!.isEmpty ? "กรอกคำตอบที่ถูกต้อง" : null,
                                decoration: InputDecoration(
                                  hintText: 'คำตอบ'
                                ),
                                onChanged: (value) {
                                  option1 = value;
                                },
                              ),
                              ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          
                         ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                               
                                createQuestionWrite(question,);
                                showSnackbar(
                                context, Colors.green, "สร้างโจทย์คำถามสำเร็จ");
                                 Navigator.push(context,
                            MaterialPageRoute(builder: (context) => DetailsQuizs(quizId: widget.quizId,)));
                              }
                              
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
}