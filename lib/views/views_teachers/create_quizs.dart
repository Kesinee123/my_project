import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_project/views/views_teachers/create_questions.dart';
import 'package:my_project/views/views_teachers/homepage.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  String quizTitle = '';
  String quizSubject = '';

  File? _image;
  String? _imageUrl;
  final picker = ImagePicker();
  //String? downloadURL;

  Future createQuiz(String quizTitle, String quizSubject) async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    // final _imageUrl = await uploadImage(_image!);
    if(_image != null){
      _imageUrl = await uploadImage(_image!);
    } else {
      _imageUrl = "https://img.icons8.com/sf-regular-filled/256/question-mark.png";
    }
    DocumentReference quizDocumentReference =
        await FirebaseFirestore.instance.collection('quizs').add({
      'uid': _auth.currentUser!.uid,
      'quizTitle': quizTitle,
      'quizSubject': quizSubject,
      'createdAt': '$date $time',
      'imageUrl': _imageUrl
    });
    await quizDocumentReference.update({
      // "questions" : FieldValue.arrayUnion(["${uid}_$userName"]),
      "quizId": quizDocumentReference.id
    });
  }

  void _showImage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('โปรดใส่รูปภาพ'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              InkWell(
                onTap: () {
                  //
                  imagePicker();
                },
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.camera,
                        color: Colors.black,
                      ),
                    ),
                    Text('Gallery')
                  ],
                ),
              )
            ]),
          );
        });
  }

  Future imagePicker() async {
    try {
      final pick = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pick != null) {
          _image = File(pick.path);
    }
    });
    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
    }
  }

  Future uploadImage(File _image) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child('images').child('quiz$imgId');
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(
                height: 550,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
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
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.grey , width: 2)
                                        ),
                                        child: _image == null ? Center(child: Icon(Icons.image),) : Image.file(_image!) ,
                                      ),
                                     
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.yellow),
                            onPressed: () {
                              imagePicker();
                            },
                            child: Text(
                              'เพิ่มรูปภาพ',
                              style: TextStyle(color: Colors.black),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(horizontal: 25),
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
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: Container(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  quizTitle = value;
                                });
                              },
                              validator: ((val) =>
                                  val!.isEmpty ? "โปรดกรอกชื่อแบบทดสอบ" : null),
                              // decoration: InputDecoration(hintText: "Quiz Title"),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(horizontal: 25),
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
                              onChanged: (value) {
                                setState(() {
                                  quizSubject = value;
                                });
                              },
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
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blueGrey),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('ยกเลิก')),
                              SizedBox(
                                width: 50,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.deepPurple),
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      // if (_image == null) {
                                      //   showSnackbar(context, Colors.red,
                                      //       "โปรดเพิ่มรูปภาพ");
                                      //   return;
                                      // }
                                      try {
                                        createQuiz(quizTitle, quizSubject);
                                        showSnackbar(context, Colors.green,
                                            "สร้างแบบทดสอบสำเร็จ");
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    HomePage()));
                                      } catch (e) {
                                        showSnackbar(
                                            context, Colors.red, e.toString());
                                      }
                                    }
                                  },
                                  child: Text('ตกลง')),
                            ],
                          ),
                        ),
                      ]),
                ),
              )
            ]),
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
