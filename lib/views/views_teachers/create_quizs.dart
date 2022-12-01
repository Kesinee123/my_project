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
import 'package:my_project/models/quiz.dart';
import 'package:my_project/service/database_service.dart';
import 'package:my_project/views/views_teachers/create_questions.dart';

import 'package:my_project/views/views_teachers/homepage.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();

  final CollectionReference quizCollection = FirebaseFirestore.instance.collection("quizs");

  String quizTitle = '';
  String quizSubject = '';
  String userName = '';

  File? _image;
  final picker = ImagePicker();
  //String? downloadURL;

  void addImage() async {
    final imgURL = await uploadImage(_image!);
    await quizCollection.add({
      "imageURL" : imgURL
    }).whenComplete(() => showSnackbar(context, Colors.green , "อัปโหลดรูปภาพ"));
  }

  Future imagePicker() async {
    try{
      final pick =  await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if(pick != null) {
        _image = File(pick.path);
      }else{
        showSnackbar(context, Colors.red , "ไม่มีรูปภาพ");
      }
    });
    } catch (e) {
      showSnackbar(context , Colors.red , e.toString());
    }
    
  }

  Future uploadImage(File _image) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child('images').child('quiz$imgId');
    await reference.putFile(_image);
    url = await reference.getDownloadURL();
    return url;
  }

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
                                                          Expanded(
                                                            child: _image == null
                                                                ? Center(
                                                                    child:
                                                                        Text("ไม่มีรูปภาพ"))
                                                                : Image.file(_image!),
                                                          ),
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
                                        onPressed: () {
                                          imagePicker();
                                        },
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
                                          if(quizTitle != ""){
                                            // setState(() {
                                              
                                            // });
                                            DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                                            .createQuiz(userName, FirebaseAuth.instance.currentUser!.uid, quizTitle, quizSubject);
                                            // addImage();
                                            Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage()));
                                            showSnackbar(context, Colors.green , "สร้างแบบทดสอบสำเร็จแล้ว");
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
void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: TextStyle(fontSize: 14),),
    backgroundColor: color,
    duration: Duration(seconds: 5),
    ));
  }
}