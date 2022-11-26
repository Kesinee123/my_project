import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_project/models/quiz.dart';
import 'package:my_project/views/views_teachers/create_questions.dart';

import 'package:my_project/views/views_teachers/homepage.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();

  final _quiz = FirebaseAuth.instance;
  final CollectionReference quizCollection = FirebaseFirestore.instance.collection("quizs");

  Future createQuiz(String quizTitle, String quizSubject , String Id ) async {
     DocumentReference quizDocumentReference = await quizCollection.add({
        "quizTitle" : quizTitle,
        "quizSubject" : quizSubject,
        "quizId" : _quiz.currentUser!.uid,
     });
  }

  // adddataquiz(value) async{
  //   await FirebaseFirestore.instance.collection("quizs").add({
  //       "quizTitle": quizTitle,
  //       "quizSubject": quizSubject,
  //       "quizId" : "",
  //   });

  //   await documentReference.update
  // }

  String quizTitle = '';
  String quizSubject = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
                appBar: AppBar(
                  title: Text("สร้างแบบทดสอบ"),
                  backgroundColor: Colors.deepPurple,
                ),
                backgroundColor: Colors.deepPurple,
                body: Container(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: _formkey,
                    child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.white,
                              height: 550,
                                child: Container(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                    Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Container(
                                            height: 150,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    width: 250,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(20),
                                                      border: Border.all(
                                                          color:
                                                              Colors.deepPurple),
                                                    ),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          // Expanded(
                                                          //   child: _image == null
                                                          //       ? Center(
                                                          //           child:
                                                          //               Text("No image selected"))
                                                          //       : Image.file(_image!),
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(primary: Colors.yellow),
                                        onPressed: () {},
                                        child: Text('เพิ่มรูปภาพ',style: TextStyle(color: Colors.black),)),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      child: Container(
                                        child: Text(
                                          "ชื่อแบบทดสอบ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      child: Container(
                                        child: TextFormField(
                                          onChanged: (value){
                                            setState(() {
                                              quizTitle = value;
                                            });
                                          } ,
                                          validator: ((val) => val!.isEmpty
                                              ? "โปรดกรอกชื่อแบบทดสอบ"
                                              : null),
                                          // decoration: InputDecoration(hintText: "Quiz Title"),
                                          
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 25),
                                      child: Container(
                                        child: Text(
                                          "ชื่อวิชาของแบบทดสอบ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                child: TextFormField(
                                  onChanged: (value){
                                            setState(() {
                                              quizSubject = value;
                                            });
                                          } ,
                                  validator: ((val) => val!.isEmpty
                                      ? "โปรดกรอกชื่อวิชาของแบบทดสอบ"
                                      : null),
                                  // decoration: InputDecoration(hintText: "Quiz Subject"),
                                  
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              margin: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                        style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('ยกเลิก')),
                                  SizedBox(width: 50,),
                                 ElevatedButton(
                                      style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                                        onPressed: () {
                                          if(_formkey.currentState!.validate()){
                                              createQuiz(
                                                quizTitle,
                                                quizSubject,
                                                _quiz.currentUser!.uid);
                            
                                              _formkey.currentState!.reset();
                                              Navigator.of(context).pop();
                                              SnackBar(content: Text('การสร้างแบบทดสอบสำเร็จ'));
                                                //  Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                                            }
                                          },
                                        child: Text('ตกลง')),
                                  
                                ],
                              ),
                            ),
                                  ]),
                                )),
                          ]),
                    ),
                  ),
                ));
          }
        }