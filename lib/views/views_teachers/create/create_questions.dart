import 'dart:io';
import 'dart:ui';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_project/config/responsive.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/views/views_teachers/detail/details.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:quill_delta/quill_delta.dart';

class CreateQuestion extends StatefulWidget {
  const CreateQuestion({
    super.key,
    required this.quizId,
    required this.questionId,
  });
  final String quizId;
  final String questionId;

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question = '';
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';

  int correct_answer = 0;

  Future createQuestionRadio(String question) async {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    if (_imageQs != null) {
      _imageUrlQs = await uploadImage(_imageQs!);
    } else {
      _imageUrlQs = null;
    }

    DocumentReference questionDocumentReference = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .add({
      'questions': question,
      'imageUrl': _imageUrlQs,
      'createdAt': '$date $time',
      'quizId': widget.quizId,
      'type_quiz': 'เลือกได้ 1 คำตอบ',
      "correct_answer": correct_answer.toString(),
    });
    await questionDocumentReference.update({
      "questionId": questionDocumentReference.id,
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
      'imageUrl': _imageUrlOp1,
      'createdAt': '$date $time',
      'answer': option1,
      'identifier': '1',
      "questionId": questionDocumentReference.id,
    });
    await questionAnwer1.update({'answerId': questionAnwer1.id});
    await questionDocumentReference.update({'answerId1': questionAnwer1.id});

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
      'createdAt': '$date $time',
      'imageUrl': _imageUrlOp2,
      'identifier': '2',
      "questionId": questionDocumentReference.id,
    });
    await questionAnwer2.update({'answerId': questionAnwer2.id});
    await questionDocumentReference.update({'answerId2': questionAnwer2.id});

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
      'createdAt': '$date $time',
      'imageUrl': _imageUrlOp3,
      'identifier': '3',
      "questionId": questionDocumentReference.id,
    });
    await questionAnwer3.update({'answerId': questionAnwer3.id});
    await questionDocumentReference.update({'answerId3': questionAnwer3.id});

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
      'createdAt': '$date $time',
      'imageUrl': _imageUrlOp4,
      'identifier': '4',
      "questionId": questionDocumentReference.id,
    });
    await questionAnwer4.update({'answerId': questionAnwer4.id});
    await questionDocumentReference.update({'answerId4': questionAnwer4.id});
  }

  // ImageQuestion
  File? _imageQs;
  String? _imageUrlQs;
  final picker = ImagePicker();

  Future imagePickerQuestion() async {
    try {
      final pickQs = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickQs != null) {
          _imageQs = File(pickQs.path);
        }
      });
    } catch (e) {
      showSnackbar(context, Colors.red, e.toString());
    }
  }

  // uploadImageQs
  Future uploadImage(File _imageQs) async {
    String url;
    String imgId = DateTime.now().microsecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance
        .ref()
        .child('question')
        .child('question$imgId');
    await reference.putFile(_imageQs);
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
    Reference reference =
        FirebaseStorage.instance.ref().child('option1').child('option1$imgId');
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
    Reference reference =
        FirebaseStorage.instance.ref().child('option2').child('option2$imgId');
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
    Reference reference =
        FirebaseStorage.instance.ref().child('option3').child('option3$imgId');
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
    Reference reference =
        FirebaseStorage.instance.ref().child('option4').child('option4$imgId');
    await reference.putFile(_imageOp4);
    url = await reference.getDownloadURL();
    return url;
  }

  // final quill.QuillController _controller = quill.QuillController.basic();
  // final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.deepPurple, title: Text(''),),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
                child: Responsive(
              mobile: Column(
                children: [
                  Container(
                    // margin: EdgeInsets.only(top: 30),
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
                                maxLines: 100,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: Colors.white),
                                validator: ((val) =>
                                    val!.isEmpty ? "กรอกโจทย์คำถาม" : null),
                                decoration: InputDecoration(
                                  hintText: "",
                                ),
                                onChanged: (value) {
                                  question = value;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                  child: _imageQs == null
                                      ? null
                                      : Image.file(_imageQs!, height: 200, width: 200,)),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 20, 150, 0),
                                child: ElevatedButton.icon(
                                  onPressed: (() {
                                    imagePickerQuestion();
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
                    height: 670,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: 20,),
                        Text(
                          "เลือกได้ 1 ข้อเท่านั้น !!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RadioListTile(
                              activeColor: Colors.red,
                              secondary: IconButton(
                                  onPressed: () {
                                    imagePickeOption1();
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
                                child: Center(
                                    child: _imageOp1 == null
                                        ? TextFormField(
                                            minLines: 1,
                                            maxLines: 3,
                                            validator: ((val) => val!.isEmpty
                                                ? "กรอกคำตอบ"
                                                : null),
                                            onChanged: (value) {
                                              setState(() {
                                                option1 = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'คำตอบที่ 1'),
                                          )
                                        : Image.file(
                                            _imageOp1!,
                                            height: 100,
                                          )),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RadioListTile(
                              activeColor: Colors.red,
                              secondary: IconButton(
                                  onPressed: () {
                                    imagePickeOption2();
                                  },
                                  icon: Icon(Icons.add_a_photo)),
                              value: 2,
                              groupValue: correct_answer,
                              onChanged: (value) {
                                setState(() {
                                  correct_answer = value!;
                                });
                              },
                              title: Container(
                                // color: Colors.red,
                                child: Center(
                                    child: _imageOp2 == null
                                        ? TextFormField(
                                            minLines: 1,
                                            maxLines: 3,
                                            validator: ((val) => val!.isEmpty
                                                ? "กรอกคำตอบ"
                                                : null),
                                            onChanged: (value) {
                                              setState(() {
                                                option2 = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'คำตอบที่ 2'),
                                          )
                                        : Image.file(
                                            _imageOp2!,
                                            height: 100,
                                          )),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RadioListTile(
                              activeColor: Colors.red,
                              secondary: IconButton(
                                  onPressed: () {
                                    imagePickeOption3();
                                  },
                                  icon: Icon(Icons.add_a_photo)),
                              value: 3,
                              groupValue: correct_answer,
                              onChanged: (value) {
                                setState(() {
                                  correct_answer = value!;
                                });
                              },
                              title: Container(
                                // color: Colors.red,
                                child: Center(
                                    child: _imageOp3 == null
                                        ? TextFormField(
                                            minLines: 1,
                                            maxLines: 3,
                                            validator: ((val) => val!.isEmpty
                                                ? "กรอกคำตอบ"
                                                : null),
                                            onChanged: (value) {
                                              setState(() {
                                                option3 = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'คำตอบที่ 3'),
                                          )
                                        : Image.file(
                                            _imageOp3!,
                                            height: 100,
                                          )),
                              )),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: RadioListTile(
                              activeColor: Colors.red,
                              secondary: IconButton(
                                  onPressed: () {
                                    imagePickeOption4();
                                  },
                                  icon: Icon(Icons.add_a_photo)),
                              value: 4,
                              groupValue: correct_answer,
                              onChanged: (value) {
                                setState(() {
                                  correct_answer = value!;
                                });
                              },
                              title: Container(
                                // color: Colors.red,
                                child: Center(
                                    child: _imageOp4 == null
                                        ? TextFormField(
                                            minLines: 1,
                                            maxLines: 3,
                                            validator: ((val) => val!.isEmpty
                                                ? "กรอกคำตอบ"
                                                : null),
                                            onChanged: (value) {
                                              setState(() {
                                                option4 = value;
                                              });
                                            },
                                            decoration: InputDecoration(
                                                hintText: 'คำตอบที่ 4'),
                                          )
                                        : Image.file(
                                            _imageOp4!,
                                            height: 100,
                                          )),
                              )),
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
                                                path: '',
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
                                  // print('โจทย์ : $question , รูปภาพ : $_imageUrlQs');
                                  if (_formKey.currentState!.validate()) {
                                    if (correct_answer == 0) {
                                      //  showSnackbar(
                                      //   context, Colors.red, "โปรดเลือกตอบที่ถูกต้อง");
                                      normalDialog(
                                          context, 'โปรดเลือกคำตอบที่ถูกต้อง');
                                      return;
                                    } else if (question == null) {
                                      showSnackbar(context, Colors.red,
                                          "สร้างโจทย์ไม่คำถามสำเร็จ!!");
                                    }
                                    try {
                                      createQuestionRadio(question);
      
                                      showSnackbar(context, Colors.green,
                                          "สร้างโจทย์คำถามสำเร็จ");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailsQuizs(
                                                    quizId: widget.quizId,
                                                    questionId: widget.questionId, path: '',
                                                  )));
                                    } catch (e) {
                                      showSnackbar(
                                          context, Colors.red, e.toString());
                                    }
                                  }
                                },
                                child: Text('บันทึกโจทย์')),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              destop: Container(
                
               decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black)
                ),
                margin: EdgeInsets.symmetric(horizontal: 400 , vertical: 20),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      // margin: EdgeInsets.symmetric(horizontal: 400),
      
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //       image: ExactAssetImage("assets/dw.jpg"),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 24.0),
                        // margin: EdgeInsets.symmetric(horizontal: 400),
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                Text(
                                  "โจทย์คำถาม",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  minLines: 1,
                                  maxLines: 100,
                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(color: Colors.white),
                                  validator: ((val) =>
                                      val!.isEmpty ? "กรอกโจทย์คำถาม" : null),
                                  decoration: InputDecoration(
                                    hintText: "",
                                  ),
                                  onChanged: (value) {
                                    question = value;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Center(
                                    child: _imageQs == null
                                        ? null
                                        : Image.file(_imageQs!)),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 150, 0),
                                  child: ElevatedButton.icon(
                                    onPressed: (() {
                                      imagePickerQuestion();
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
                    // SizedBox(
                    //   height: 30,
                    // ),
                    Container(
                       decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)
                          )
                        ),
                      child: Column(
                        children: [
                          SizedBox(height: 30,),
                          Text(
                            "เลือกได้ 1 ข้อเท่านั้น !!",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RadioListTile(
                          activeColor: Colors.red,
                          secondary: IconButton(
                              onPressed: () {
                                imagePickeOption1();
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
                            child: Center(
                                child: _imageOp1 == null
                                    ? TextFormField(
                                        minLines: 1,
                                        maxLines: 3,
                                        validator: ((val) =>
                                            val!.isEmpty ? "กรอกคำตอบ" : null),
                                        onChanged: (value) {
                                          setState(() {
                                            option1 = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'คำตอบที่ 1'),
                                      )
                                    : Image.file(
                                        _imageOp1!,
                                        height: 100,
                                      )),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RadioListTile(
                          activeColor: Colors.red,
                          secondary: IconButton(
                              onPressed: () {
                                imagePickeOption2();
                              },
                              icon: Icon(Icons.add_a_photo)),
                          value: 2,
                          groupValue: correct_answer,
                          onChanged: (value) {
                            setState(() {
                              correct_answer = value!;
                            });
                          },
                          title: Container(
                            // color: Colors.red,
                            child: Center(
                                child: _imageOp2 == null
                                    ? TextFormField(
                                        minLines: 1,
                                        maxLines: 3,
                                        validator: ((val) =>
                                            val!.isEmpty ? "กรอกคำตอบ" : null),
                                        onChanged: (value) {
                                          setState(() {
                                            option2 = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'คำตอบที่ 2'),
                                      )
                                    : Image.file(
                                        _imageOp2!,
                                        height: 100,
                                      )),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RadioListTile(
                          activeColor: Colors.red,
                          secondary: IconButton(
                              onPressed: () {
                                imagePickeOption3();
                              },
                              icon: Icon(Icons.add_a_photo)),
                          value: 3,
                          groupValue: correct_answer,
                          onChanged: (value) {
                            setState(() {
                              correct_answer = value!;
                            });
                          },
                          title: Container(
                            // color: Colors.red,
                            child: Center(
                                child: _imageOp3 == null
                                    ? TextFormField(
                                        minLines: 1,
                                        maxLines: 3,
                                        validator: ((val) =>
                                            val!.isEmpty ? "กรอกคำตอบ" : null),
                                        onChanged: (value) {
                                          setState(() {
                                            option3 = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'คำตอบที่ 3'),
                                      )
                                    : Image.file(
                                        _imageOp3!,
                                        height: 100,
                                      )),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: RadioListTile(
                          activeColor: Colors.red,
                          secondary: IconButton(
                              onPressed: () {
                                imagePickeOption4();
                              },
                              icon: Icon(Icons.add_a_photo)),
                          value: 4,
                          groupValue: correct_answer,
                          onChanged: (value) {
                            setState(() {
                              correct_answer = value!;
                            });
                          },
                          title: Container(
                            // color: Colors.red,
                            child: Center(
                                child: _imageOp4 == null
                                    ? TextFormField(
                                        minLines: 1,
                                        maxLines: 3,
                                        validator: ((val) =>
                                            val!.isEmpty ? "กรอกคำตอบ" : null),
                                        onChanged: (value) {
                                          setState(() {
                                            option4 = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            hintText: 'คำตอบที่ 4'),
                                      )
                                    : Image.file(
                                        _imageOp4!,
                                        height: 100,
                                      )),
                          )),
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
                                            questionId: widget.questionId, path: '',
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
                              // print('โจทย์ : $question , รูปภาพ : $_imageUrlQs');
                              if (_formKey.currentState!.validate()) {
                                if (correct_answer == 0) {
                                  //  showSnackbar(
                                  //   context, Colors.red, "โปรดเลือกตอบที่ถูกต้อง");
                                  normalDialog(
                                      context, 'โปรดเลือกคำตอบที่ถูกต้อง');
                                  return;
                                } else if (question == null) {
                                  showSnackbar(context, Colors.red,
                                      "สร้างโจทย์ไม่คำถามสำเร็จ!!");
                                }
                                try {
                                  createQuestionRadio(question);
      
                                  showSnackbar(context, Colors.green,
                                      "สร้างโจทย์คำถามสำเร็จ");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsQuizs(
                                                quizId: widget.quizId,
                                                questionId: widget.questionId, path: '',
                                              )));
                                } catch (e) {
                                  showSnackbar(context, Colors.red, e.toString());
                                }
                              }
                            },
                            child: Text('บันทึกโจทย์')),
                      ],
                    ),
                    SizedBox(height: 50,)
                        ],
                      ),
                    ),
                    
                    
                  ],
                ),
              ),
            )),
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
