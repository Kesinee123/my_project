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
import 'package:my_project/views/views_teachers/details.dart';
import 'package:my_project/views/views_teachers/homepage.dart';

class CreateQuestion2 extends StatefulWidget {
  const CreateQuestion2({
    super.key,
    required this.quizId,
    required this.questionId,
  });
  final String quizId;
  final String questionId;

  @override
  State<CreateQuestion2> createState() => _CreateQuestion2State();
}

class _CreateQuestion2State extends State<CreateQuestion2> {
  final _formKey = GlobalKey<FormState>();
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';

  // bool 1 = false;
  // bool _ch2 = false;
  // bool _ch3 = false;
  // bool _ch4 = false;

bool _value1 = false;
bool _value2 = false;
bool _value3 = false;
bool _value4 = false;

List  getIntsFromCheckboxListTiles() {
  return [_value1 ? 1 : 0 ,_value2 ? 2: 0 ,_value3 ? 3: 0 ,_value4 ? 4 : 0];
}

// var correct_answer = [false, false, false, false];


  Future CreateQuestionCheckbox(
    String question,
  ) async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    List ints = getIntsFromCheckboxListTiles();

    if (_imageQs2 != null) {
      _imageUrlQs2 = await uploadImage(_imageQs2!);
    } else {
     _imageUrlQs2 = null;
    }

    DocumentReference questionDocumentReference = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .add({
      'questions': question,
      'imageUrl' : _imageUrlQs2,
      'createdAt': '$date $time',
      'quizId': widget.quizId,
      'type_quiz': 'เลือกได้มากกว่า 1 คำตอบ',
      "correct_answer": ints.toString(),
    });
    await questionDocumentReference.update({
      "questionId": questionDocumentReference.id,
      // "correct_answer": correct_answer,
    });

    if (_imageOp1 != null) {
      _imageUrlOp1 = await uploadImage(_imageOp1!);
    } else {
      _imageUrlOp1 = null;
    }
    DocumentReference questionAnwer1 = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionDocumentReference.id)
        .collection('answers')
        .add({
      'answer': option1,
      'imageUrl': _imageUrlOp1,
      'identifier': '1',
      "questionId": questionDocumentReference.id,
    });
    await questionAnwer1.update({
      'answerId' : questionAnwer1.id
    });
    await questionDocumentReference.update({
      'answerId1': questionAnwer1.id
    });

    if (_imageOp2 != null) {
      _imageUrlOp2 = await uploadImage(_imageOp2!);
    } else {
      _imageUrlOp2 = null;
    }
    DocumentReference questionAnwer2 = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionDocumentReference.id)
        .collection('answers')
        .add({
      'answer': option2,
      'imageUrl': _imageUrlOp2,
      'identifier': '2',
      "questionId": questionDocumentReference.id,
    });
    await questionAnwer2.update({
      'answerId' : questionAnwer2.id
    });
    await questionDocumentReference.update({
      'answerId2': questionAnwer2.id
    });

    if (_imageOp3 != null) {
      _imageUrlOp3 = await uploadImage(_imageOp3!);
    } else {
      _imageUrlOp3 = null;
    }
    DocumentReference questionAnwer3 = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionDocumentReference.id)
        .collection('answers')
        .add({
      'answer': option3,
      'imageUrl': _imageUrlOp3,
      'identifier': '3',
      "questionId": questionDocumentReference.id,
    });
    await questionAnwer3.update({
      'answerId' : questionAnwer3.id
    });
    await questionDocumentReference.update({
      'answerId3': questionAnwer3.id
    });

    if (_imageOp4 != null) {
      _imageUrlOp4 = await uploadImage(_imageOp4!);
    } else {
      _imageUrlOp4 = null;
    }
    DocumentReference questionAnwer4 = await FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionDocumentReference.id)
        .collection('answers')
        .add({
      'answer': option4,
      'imageUrl': _imageUrlOp4,
      'identifier': '4',
      "questionId": questionDocumentReference.id,
    });
    await questionAnwer4.update({
      'answerId' : questionAnwer4.id
    });
    await questionDocumentReference.update({
      'answerId4': questionAnwer4.id
    });
  }

// ImageQuestion
  File? _imageQs2;
  String? _imageUrlQs2;
  final picker = ImagePicker();

  Future imagePickerQuestion2() async {
    try {
      final pickQs2 = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickQs2 != null) {
          _imageQs2 = File(pickQs2.path);
        }
      });
    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
    }
  }

  // uploadImageQs2
  Future uploadImage(File _imageQs2) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('question2')
        .child('question2$imgId');
    await reference.putFile(_imageQs2);
    url = await reference.getDownloadURL();
    return url;
  }

  // ImageOption1
  File? _imageOp1;
  String? _imageUrlOp1;
  final picker1 = ImagePicker();

  Future imagePickeOption1() async {
    try {
      final pickOp1 = await picker1.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickOp1 != null) {
          _imageOp1 = File(pickOp1.path);
        }
      });
    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
    }
  }

  // uploadOption1
  Future uploadImageOp1(File _imageOp1) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('option1')
        .child('option1$imgId');
    await reference.putFile(_imageOp1);
    url = await reference.getDownloadURL();
    return url;
  }

  // ImageOption2
  File? _imageOp2;
  String? _imageUrlOp2;
  final picker2 = ImagePicker();

  Future imagePickeOption2() async {
    try {
      final pickOp2 = await picker2.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickOp2 != null) {
          _imageOp2 = File(pickOp2.path);
        }
      });
    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
    }
  }

  // uploadOption2
  Future uploadImageOp2(File _imageOp2) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('option2')
        .child('option2$imgId');
    await reference.putFile(_imageOp2);
    url = await reference.getDownloadURL();
    return url;
  }

  // ImageOption3
  File? _imageOp3;
  String? _imageUrlOp3;
  final picker3 = ImagePicker();

  Future imagePickeOption3() async {
    try {
      final pickOp3 = await picker3.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickOp3 != null) {
          _imageOp3 = File(pickOp3.path);
        }
      });
    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
    }
  }

  // uploadImageOption3
  Future uploadImageOp3(File _imageOp3) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('option3')
        .child('option3$imgId');
    await reference.putFile(_imageOp3);
    url = await reference.getDownloadURL();
    return url;
  }

  // ImageOption4
  File? _imageOp4;
  String? _imageUrlOp4;
  final picker4 = ImagePicker();

  Future imagePickeOption4() async {
    try {
      final pickOp4 = await picker4.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickOp4 != null) {
          _imageOp4 = File(pickOp4.path);
        }
      });
    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
    }
  }

  // uploadImageOption4
  Future uploadImageOp4(File _imageOp4) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('option4')
        .child('option4$imgId');
    await reference.putFile(_imageOp4);
    url = await reference.getDownloadURL();
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.deepPurple, title: Text(''),),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
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
                                child: _imageQs2 == null
                                    ? null
                                    : Image.file(_imageQs2!)),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 150, 0),
                              child: ElevatedButton.icon(
                                onPressed: (() {
                                  imagePickerQuestion2();
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
                SizedBox(
                  height: 30,
                ),
                Text(
                  "เลือกได้มากกว่า 1 ข้อ !!",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Center(
                                child: _imageOp1 == null
                                    ? TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        validator: ((val) => val!.isEmpty ? "กรอกคำตอบ" : null),
                        onChanged: (value) {
                          setState(() {
                            option1 = value;
                          });
                        },
                        decoration: InputDecoration(hintText: 'คำตอบที่ 1'),
                      )
                                    : Image.file(_imageOp1!)),
                      
                      secondary: IconButton(
                          onPressed: () {
                            imagePickeOption1();
                          }, icon: Icon(Icons.add_a_photo)),
                      value: _value1,
                      onChanged: (value) {
                        setState(() {
                          _value1 = value!;
                          // print('1');
                        });
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Center(
                                child: _imageOp2 == null
                                    ? TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        validator: ((val) => val!.isEmpty ? "กรอกคำตอบ" : null),
                        onChanged: (value) {
                          setState(() {
                            option2 = value;
                          });
                        },
                        decoration: InputDecoration(hintText: 'คำตอบที่ 2'),
                      )
                                    : Image.file(_imageOp2!)),
                      
                      secondary: IconButton(
                          onPressed: () {
                            imagePickeOption2();
                          }, icon: Icon(Icons.add_a_photo)),
                      value: _value2,
                      onChanged: (value) {
                        setState(() {
                          _value2 = value!;
                          // print('2');
                        });
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Center(
                                child: _imageOp3 == null
                                    ? TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        validator: ((val) => val!.isEmpty ? "กรอกคำตอบ" : null),
                        onChanged: (value) {
                          setState(() {
                            option3 = value;
                          });
                        },
                        decoration: InputDecoration(hintText: 'คำตอบที่ 3'),
                      )
                                    : Image.file(_imageOp3!)),
                      
                      secondary: IconButton(
                          onPressed: () {
                            imagePickeOption3();
                          }, icon: Icon(Icons.add_a_photo)),
                      value: _value3,
                      onChanged: (value) {
                        setState(() {
                          _value3 = value!;
                          // print('3');
                        });
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: Center(
                                child: _imageOp4 == null
                                    ? TextFormField(
                        minLines: 1,
                        maxLines: 3,
                        validator: ((val) => val!.isEmpty ? "กรอกคำตอบ" : null),
                        onChanged: (value) {
                          setState(() {
                            option4 = value;
                          });
                        },
                        decoration: InputDecoration(hintText: 'คำตอบที่ 4'),
                      )
                                    : Image.file(_imageOp4!)),
                      
                      secondary: IconButton(
                          onPressed: () {
                            imagePickeOption4();
                          }, icon: Icon(Icons.add_a_photo)),
                      value: _value4,
                      onChanged: (value) {
                        setState(() {
                          _value4 = value!;
                          // print(selected[3]);
                        });
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
                          // getIntFromCheckbox();
                          
                          // print(ints);
                          // print('$_value1,$_value2 ,$_value3 ,$_value4');
                          if (_formKey.currentState!.validate()) {
                            // if(correct_answer == 0){
                            //   //  showSnackbar(
                            //   //   context, Colors.red, "โปรดเลือกตอบที่ถูกต้อง");
                            //   normalDialog(context, 'โปรดเลือกคำตอบที่ถูกต้อง');
                            //   return;
                            // } else if (question == null){
                            //   showSnackbar(
                            //     context, Colors.red, "สร้างโจทย์ไม่คำถามสำเร็จ!!");
                            // }
                            try{
                               CreateQuestionCheckbox(question,);
                               showSnackbar(
                                context, Colors.green, "สร้างโจทย์คำถามสำเร็จ");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsQuizs(
                                          quizId: widget.quizId, questionId: widget.questionId,
                                        )));
                            }catch (e){
                              showSnackbar(context, Colors.red, e.toString() );
                            }
                          }
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

// ** 