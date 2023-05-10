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
import 'package:my_project/config/responsive.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/models/usermodel.dart';
import 'package:my_project/views/views_teachers/detail/details.dart';
import 'package:intl/intl.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;

class CreateQuestion3 extends StatefulWidget {
  final String quizId;
  final String questionId;

  const CreateQuestion3(
      {super.key, required this.quizId, required this.questionId});

  @override
  State<CreateQuestion3> createState() => _CreateQuestion3State();
}

class _CreateQuestion3State extends State<CreateQuestion3> {
  final _formKey = GlobalKey<FormState>();
  String question = '';
  String option1 = '';

  Future createQuestionWrite(
    String question,
  ) async {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    if (_imageQs3 != null) {
      _imageUrlQs3 = await uploadImage(_imageQs3!);
    } else {
      _imageUrlQs3 = null;
    }

    // final questionJson = _controller.document.toDelta().toJson();

    DocumentReference questionWrite = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .add({
      'questions': question,
      'imageUrl': _imageUrlQs3,
      'createdAt': '$date $time',
      'quizId': widget.quizId,
      'type_quiz': 'แบบเขียน',
      "correct_answer": '1'
    });
    await questionWrite.update({
      "questionId": questionWrite.id,
    });
    DocumentReference questionAnwer1 = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionWrite.id)
        .collection('answers')
        .add({
      'answer': option1,
      'imageUrl': null,
      // "correct_answer" : '1',
      'identifier': '1',
      "questionId": questionWrite.id,
    });
    await questionAnwer1.update({'answerId': questionAnwer1.id});
    await questionWrite.update({'answerId1': questionAnwer1.id});
  }

  // ImageQuestion3
  File? _imageQs3;
  String? _imageUrlQs3;
  final picker = ImagePicker();

  Future imagePickerQuestion3() async {
    try {
      final pickQs3 = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickQs3 != null) {
          _imageQs3 = File(pickQs3.path);
        }
      });
    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
    }
  }

  // uploadImageQs
  Future uploadImage(File _imageQs3) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('question3')
        .child('question3$imgId');
    await reference.putFile(_imageQs3);
    url = await reference.getDownloadURL();
    return url;
  }

  // final quill.QuillController _controller = quill.QuillController.basic();
  // final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.deepPurple,
      // ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Responsive(
                mobile: Column(
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
                              minLines: 1,
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              onChanged: (value) {
                                setState(() {
                                  question = value;
                                });
                              },
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
                           Center(
                                child: _imageQs3 == null
                                    ? null
                                    : Image.file(_imageQs3! , height: 200, width: 200,)),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 150, 0),
                              child: ElevatedButton.icon(
                                onPressed: (() {
                                  imagePickerQuestion3();
                                }),
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
                    // width: 800,
                    height: 600,
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
                        child: ListTile(
                          title: TextFormField(
                            // validator: (value) =>
                            //     value!.isEmpty ? "กรอกคำตอบที่ถูกต้อง" : null,
                            decoration: InputDecoration(hintText: 'คำตอบ'),
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
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurple),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (option1 == "") {
                                //  showSnackbar(
                                //   context, Colors.red, "โปรดเลือกตอบที่ถูกต้อง");
                                normalDialog(
                                    context, 'โปรดกรอกคำตอบที่ถูกต้อง');
                                return;
                              }
                              createQuestionWrite(
                                question,
                              );
                              showSnackbar(context, Colors.green,
                                  "สร้างโจทย์คำถามสำเร็จ");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailsQuizs(
                                            quizId: widget.quizId,
                                            questionId: widget.questionId,
                                          )));
                            }
                          },
                          child: Text('บันทึกโจทย์'))
                    ]),
                  )
                ],
              ),
              destop: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black)
              ),
              margin: EdgeInsets.symmetric(horizontal: 450 , vertical: 50),
                child: Column(
                  children: [
                    Container(
                    // margin: EdgeInsets.only(top: 50),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
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
                                minLines: 1,
                                maxLines: 5,
                                keyboardType: TextInputType.multiline,
                                onChanged: (value) {
                                  setState(() {
                                    question = value;
                                  });
                                },
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
                             Center(
                                  child: _imageQs3 == null
                                      ? null
                                      : Image.file(_imageQs3!)),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 150, 0),
                                child: ElevatedButton.icon(
                                  onPressed: (() {
                                    imagePickerQuestion3();
                                  }),
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
                      // width: 800,
                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20)
                        )
                      ),
                      child: Column(children: [
                        SizedBox(
                          height: 30,
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
                          child: ListTile(
                            title: TextFormField(
                              // validator: (value) =>
                              //     value!.isEmpty ? "กรอกคำตอบที่ถูกต้อง" : null,
                              decoration: InputDecoration(hintText: 'คำตอบ'),
                              onChanged: (value) {
                                option1 = value;
                              },
                            ),
                          ),
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
                                  if (_formKey.currentState!.validate()) {
                                    if (option1 == "") {
                                      //  showSnackbar(
                                      //   context, Colors.red, "โปรดเลือกตอบที่ถูกต้อง");
                                      normalDialog(
                                          context, 'โปรดกรอกคำตอบที่ถูกต้อง');
                                      return;
                                    }
                                    createQuestionWrite(
                                      question,
                                    );
                                    showSnackbar(context, Colors.green,
                                        "สร้างโจทย์คำถามสำเร็จ");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailsQuizs(
                                                  quizId: widget.quizId,
                                                  questionId: widget.questionId,
                                                )));
                                  }
                                },
                                child: Text('บันทึกโจทย์')),
                                
                          ],
                        ),
                        SizedBox(height: 100,)
                      ]),
                    ),
                    
                  ],
                ),
              ),
              )
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
}
