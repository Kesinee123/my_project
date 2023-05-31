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
import 'package:my_project/config/responsive.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/views/views_teachers/homepage.dart';

import '../detail/details.dart';

class EditQuestion2 extends StatefulWidget {
  const EditQuestion2({
    super.key,
    required this.quizId,
    required this.questionId,
    required this.question, required this.option1, required this.option2, required this.option3, required this.option4, required this.imageUrl,
  });
  final String quizId;
  final String questionId;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String imageUrl;

  @override
  State<EditQuestion2> createState() => _EditQuestion2State();
}

class _EditQuestion2State extends State<EditQuestion2> {
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

  final TextEditingController questionEdit = TextEditingController();
  final TextEditingController option1Edit = TextEditingController();
  final TextEditingController option2Edit = TextEditingController();
  final TextEditingController option3Edit = TextEditingController();
  final TextEditingController option4Edit = TextEditingController();

    Future EditQuestionCheckbox() async {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    List ints = getIntsFromCheckboxListTiles();

    if (_imageQs != null) {
      _imageUrlQs = await uploadImage(_imageQs!);
    } else {
      final answerSnapshot = await FirebaseFirestore.instance
          .collection('quizs')
          .doc(widget.quizId)
          .collection('questions')
          .doc(widget.questionId)
          .get();

      if (answerSnapshot.exists) {
        final answerData = answerSnapshot.data()!;
        _imageUrlOp1 = answerData['imageUrl'] ?? null;
      }
    }

    final questionDocumentReference = FirebaseFirestore.instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(widget.questionId);

    await questionDocumentReference.update({
      'questions': questionEdit.text,
      'createdAt': '$date $time',
      "correct_answer": ints.toString(),
      'imageUrl': _imageUrlQs,
    });
  }

  Future<void> editAnswer() async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());
    if (_imageOp1 != null) {
      _imageUrlOp1 = await uploadImage(_imageOp1!);
    }  else {
      final answerSnapshot1 = await FirebaseFirestore.instance
          .collection('quizs')
          .doc(widget.quizId)
          .collection('questions')
          .doc(widget.questionId)
          .collection('answers')
          .doc(widget.option1)
          .get();

      if (answerSnapshot1.exists) {
        final answerData = answerSnapshot1.data()!;
        _imageUrlOp1 = answerData['imageUrl'] ?? null;
      }
    }

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
      'imageUrl': _imageUrlOp1,
    });

    // Option2
    if (_imageOp2 != null) {
      _imageUrlOp2 = await uploadImage(_imageOp2!);
    }  else {
      final answerSnapshot2 = await FirebaseFirestore.instance
          .collection('quizs')
          .doc(widget.quizId)
          .collection('questions')
          .doc(widget.questionId)
          .collection('answers')
          .doc(widget.option2)
          .get();

      if (answerSnapshot2.exists) {
        final answerData = answerSnapshot2.data()!;
        _imageUrlOp2 = answerData['imageUrl'] ?? null;
      }
    }

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
      'imageUrl': _imageUrlOp2,
    });

    // Option 3
    if (_imageOp3 != null) {
      _imageUrlOp3 = await uploadImage(_imageOp3!);
    } else {
      final answerSnapshot3 = await FirebaseFirestore.instance
          .collection('quizs')
          .doc(widget.quizId)
          .collection('questions')
          .doc(widget.questionId)
          .collection('answers')
          .doc(widget.option3)
          .get();

      if (answerSnapshot3.exists) {
        final answerData = answerSnapshot3.data()!;
        _imageUrlOp3 = answerData['imageUrl'] ?? null;
      }
    }

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
      'imageUrl': _imageUrlOp3,
    });

    if (_imageOp4 != null) {
      _imageUrlOp4 = await uploadImage(_imageOp4!);
    } else {
      final answerSnapshot4 = await FirebaseFirestore.instance
          .collection('quizs')
          .doc(widget.quizId)
          .collection('questions')
          .doc(widget.questionId)
          .collection('answers')
          .doc(widget.option4)
          .get();

      if (answerSnapshot4.exists) {
        final answerData = answerSnapshot4.data()!;
        _imageUrlOp4 = answerData['imageUrl'] ?? null;
      }
    }

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
      'imageUrl': _imageUrlOp4,
    });
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

  @override
  Widget build(BuildContext context) {
    questionEdit.text = widget.question;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          'แก้ไขโจทย์คำตอบแบบที่ 2',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Responsive(mobile: Column(
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
                              controller: questionEdit,
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
                              child: _imageQs != null
                                  ? Image.file(_imageQs! , height: 200 , width: 200,)
                                  : widget.imageUrl == 'null'
                                      ? null
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              widget.imageUrl,
                                              height: 200,
                                              width: 200,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance
                                                      .collection('quizs')
                                                      .doc(widget.quizId)
                                                      .collection('questions')
                                                      .doc(widget.questionId)
                                                      .update(
                                                          {'imageUrl': null});
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 30,
                                                ))
                                          ],
                                        ),
                            ),
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
                      return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title:  Center(
                              child: _imageOp1 != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.file(
                                          _imageOp1!,
                                          height: 100,
                                        ),
                                      ],
                                    )
                                  : answerData['imageUrl'] != null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              answerData['imageUrl'],
                                              height: 100,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection('quizs')
                                                        .doc(widget.quizId)
                                                        .collection('questions')
                                                        .doc(widget.questionId)
                                                        .collection('answers')
                                                        .doc(widget.option1)
                                                        .update(
                                                            {'imageUrl': null , 'answer' : ''});
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 30,
                                                ))
                                          ],
                                        )
                                      : TextFormField(
                                          controller: option1Edit,
                                          minLines: 1,
                                          maxLines: 3,
                                          validator: ((val) => val!.isEmpty
                                              ? "กรอกคำตอบ"
                                              : null),
                                          // onChanged: (value) {
                                          //   setState(() {
                                          //     option1 = value;
                                          //   });
                                          // },
                                          decoration: InputDecoration(
                                              hintText: 'คำตอบที่ 1'),
                                        ),
                            ),
                          secondary: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                      .collection('quizs')
                                      .doc(widget.quizId)
                                      .collection('questions')
                                      .doc(widget.questionId)
                                      .collection('answers')
                                      .doc(widget.option1)
                                      .update({'answer': ''});
                                  imagePickeOption1();
                              }, icon: Icon(Icons.add_a_photo)),
                          value: _value1,
                          onChanged: (value) {
                            setState(() {
                              _value1 = value!;
                            });
                          });
                    }
                  ),
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
                          .doc(widget.option2)
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
                        option2Edit.text = answerData['answer'];
                      return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Center(
                              child: _imageOp2 != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.file(
                                          _imageOp2!,
                                          height: 100,
                                        ),
                                      ],
                                    )
                                  : answerData['imageUrl'] != null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              answerData['imageUrl'],
                                              height: 100,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection('quizs')
                                                        .doc(widget.quizId)
                                                        .collection('questions')
                                                        .doc(widget.questionId)
                                                        .collection('answers')
                                                        .doc(widget.option2)
                                                        .update(
                                                            {'imageUrl': null , 'answer' : ''});
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 30,
                                                ))
                                          ],
                                        )
                                      : TextFormField(
                                          controller: option2Edit,
                                          minLines: 1,
                                          maxLines: 3,
                                          validator: ((val) => val!.isEmpty
                                              ? "กรอกคำตอบ"
                                              : null),
                                          // onChanged: (value) {
                                          //   setState(() {
                                          //     option1 = value;
                                          //   });
                                          // },
                                          decoration: InputDecoration(
                                              hintText: 'คำตอบที่ 2'),
                                        ),
                            ),
                          secondary: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                      .collection('quizs')
                                      .doc(widget.quizId)
                                      .collection('questions')
                                      .doc(widget.questionId)
                                      .collection('answers')
                                      .doc(widget.option2)
                                      .update({'answer': ''});
                                  imagePickeOption2();
                              }, icon: Icon(Icons.add_a_photo)),
                          value: _value2,
                          onChanged: (value) {
                            setState(() {
                              _value2 = value!;
                              // print('2');
                            });
                          }
                      );
                    }
                  ),
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
                      return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Center(
                              child: _imageOp3 != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.file(
                                          _imageOp3!,
                                          height: 100,
                                        ),
                                      ],
                                    )
                                  : answerData['imageUrl'] != null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              answerData['imageUrl'],
                                              height: 100,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection('quizs')
                                                        .doc(widget.quizId)
                                                        .collection('questions')
                                                        .doc(widget.questionId)
                                                        .collection('answers')
                                                        .doc(widget.option3)
                                                        .update(
                                                            {'imageUrl': null , 'answer' : ''});
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 30,
                                                ))
                                          ],
                                        )
                                      : TextFormField(
                                          controller: option3Edit,
                                          minLines: 1,
                                          maxLines: 3,
                                          validator: ((val) => val!.isEmpty
                                              ? "กรอกคำตอบ"
                                              : null),
                                          // onChanged: (value) {
                                          //   setState(() {
                                          //     option1 = value;
                                          //   });
                                          // },
                                          decoration: InputDecoration(
                                              hintText: 'คำตอบที่ 3'),
                                        ),
                            ),
                          secondary: IconButton(
                              onPressed: () {
                                 FirebaseFirestore.instance
                                      .collection('quizs')
                                      .doc(widget.quizId)
                                      .collection('questions')
                                      .doc(widget.questionId)
                                      .collection('answers')
                                      .doc(widget.option3)
                                      .update({'answer': ''});
                                  imagePickeOption3();
                              }, icon: Icon(Icons.add_a_photo)),
                          value: _value3,
                          onChanged: (value) {
                            setState(() {
                              _value3 = value!;
                              // print('3');
                            });
                          });
                    }
                  ),
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
                      return CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Center(
                              child: _imageOp4 != null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.file(
                                          _imageOp4!,
                                          height: 100,
                                        ),
                                      ],
                                    )
                                  : answerData['imageUrl'] != null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              answerData['imageUrl'],
                                              height: 100,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    FirebaseFirestore.instance
                                                        .collection('quizs')
                                                        .doc(widget.quizId)
                                                        .collection('questions')
                                                        .doc(widget.questionId)
                                                        .collection('answers')
                                                        .doc(widget.option4)
                                                        .update(
                                                            {'imageUrl': null , 'answer' : ''});
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 30,
                                                ))
                                          ],
                                        )
                                      : TextFormField(
                                          controller: option4Edit,
                                          minLines: 1,
                                          maxLines: 3,
                                          validator: ((val) => val!.isEmpty
                                              ? "กรอกคำตอบ"
                                              : null),
                                          // onChanged: (value) {
                                          //   setState(() {
                                          //     option1 = value;
                                          //   });
                                          // },
                                          decoration: InputDecoration(
                                              hintText: 'คำตอบที่ 4'),
                                        ),
                            ),
                          secondary: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                      .collection('quizs')
                                      .doc(widget.quizId)
                                      .collection('questions')
                                      .doc(widget.questionId)
                                      .collection('answers')
                                      .doc(widget.option4)
                                      .update({'answer': ''});
                                  imagePickeOption4();
                              }, icon: Icon(Icons.add_a_photo)),
                          value: _value4,
                          onChanged: (value) {
                            setState(() {
                              _value4 = value!;
                              // print(selected[3]);
                            });
                          });
                    }
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
                          EditQuestionCheckbox();
                          editAnswer();
                          Navigator.pop(context);
                        },
                        child: Text('บันทึกโจทย์')),
                  ],
                )
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
                      // margin: EdgeInsets.only(top: 50),
                      decoration: BoxDecoration(
                      color: Colors.deepPurple,
                borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
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
                                controller: questionEdit,
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
                                child: _imageQs != null
                                    ? Image.file(_imageQs!)
                                    : widget.imageUrl == 'null'
                                        ? null
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                widget.imageUrl,
                                                height: 200,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    FirebaseFirestore.instance
                                                        .collection('quizs')
                                                        .doc(widget.quizId)
                                                        .collection('questions')
                                                        .doc(widget.questionId)
                                                        .update(
                                                            {'imageUrl': null});
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ))
                                            ],
                                          ),
                              ),
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
                        return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title:  Center(
                                child: _imageOp1 != null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.file(
                                            _imageOp1!,
                                            height: 100,
                                          ),
                                        ],
                                      )
                                    : answerData['imageUrl'] != null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                answerData['imageUrl'],
                                                height: 100,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      FirebaseFirestore.instance
                                                          .collection('quizs')
                                                          .doc(widget.quizId)
                                                          .collection('questions')
                                                          .doc(widget.questionId)
                                                          .collection('answers')
                                                          .doc(widget.option1)
                                                          .update(
                                                              {'imageUrl': null});
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ))
                                            ],
                                          )
                                        : TextFormField(
                                            controller: option1Edit,
                                            minLines: 1,
                                            maxLines: 3,
                                            validator: ((val) => val!.isEmpty
                                                ? "กรอกคำตอบ"
                                                : null),
                                            // onChanged: (value) {
                                            //   setState(() {
                                            //     option1 = value;
                                            //   });
                                            // },
                                            decoration: InputDecoration(
                                                hintText: 'คำตอบที่ 1'),
                                          ),
                              ),
                            secondary: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                        .collection('quizs')
                                        .doc(widget.quizId)
                                        .collection('questions')
                                        .doc(widget.questionId)
                                        .collection('answers')
                                        .doc(widget.option1)
                                        .update({'answer': ''});
                                    imagePickeOption1();
                                }, icon: Icon(Icons.add_a_photo)),
                            value: _value1,
                            onChanged: (value) {
                              setState(() {
                                _value1 = value!;
                              });
                            });
                      }
                    ),
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
                            .doc(widget.option2)
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
                          option2Edit.text = answerData['answer'];
                        return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Center(
                                child: _imageOp2 != null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.file(
                                            _imageOp2!,
                                            height: 100,
                                          ),
                                        ],
                                      )
                                    : answerData['imageUrl'] != null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                answerData['imageUrl'],
                                                height: 100,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      FirebaseFirestore.instance
                                                          .collection('quizs')
                                                          .doc(widget.quizId)
                                                          .collection('questions')
                                                          .doc(widget.questionId)
                                                          .collection('answers')
                                                          .doc(widget.option2)
                                                          .update(
                                                              {'imageUrl': null});
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ))
                                            ],
                                          )
                                        : TextFormField(
                                            controller: option2Edit,
                                            minLines: 1,
                                            maxLines: 3,
                                            validator: ((val) => val!.isEmpty
                                                ? "กรอกคำตอบ"
                                                : null),
                                            // onChanged: (value) {
                                            //   setState(() {
                                            //     option1 = value;
                                            //   });
                                            // },
                                            decoration: InputDecoration(
                                                hintText: 'คำตอบที่ 2'),
                                          ),
                              ),
                            secondary: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                        .collection('quizs')
                                        .doc(widget.quizId)
                                        .collection('questions')
                                        .doc(widget.questionId)
                                        .collection('answers')
                                        .doc(widget.option2)
                                        .update({'answer': ''});
                                    imagePickeOption2();
                                }, icon: Icon(Icons.add_a_photo)),
                            value: _value2,
                            onChanged: (value) {
                              setState(() {
                                _value2= value!;
                                // print('2');
                              });
                            }
                        );
                      }
                    ),
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
                        return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Center(
                                child: _imageOp3 != null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.file(
                                            _imageOp3!,
                                            height: 100,
                                          ),
                                        ],
                                      )
                                    : answerData['imageUrl'] != null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                answerData['imageUrl'],
                                                height: 100,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      FirebaseFirestore.instance
                                                          .collection('quizs')
                                                          .doc(widget.quizId)
                                                          .collection('questions')
                                                          .doc(widget.questionId)
                                                          .collection('answers')
                                                          .doc(widget.option3)
                                                          .update(
                                                              {'imageUrl': null});
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ))
                                            ],
                                          )
                                        : TextFormField(
                                            controller: option3Edit,
                                            minLines: 1,
                                            maxLines: 3,
                                            validator: ((val) => val!.isEmpty
                                                ? "กรอกคำตอบ"
                                                : null),
                                            // onChanged: (value) {
                                            //   setState(() {
                                            //     option1 = value;
                                            //   });
                                            // },
                                            decoration: InputDecoration(
                                                hintText: 'คำตอบที่ 3'),
                                          ),
                              ),
                            secondary: IconButton(
                                onPressed: () {
                                   FirebaseFirestore.instance
                                        .collection('quizs')
                                        .doc(widget.quizId)
                                        .collection('questions')
                                        .doc(widget.questionId)
                                        .collection('answers')
                                        .doc(widget.option3)
                                        .update({'answer': ''});
                                    imagePickeOption3();
                                }, icon: Icon(Icons.add_a_photo)),
                            value: _value3,
                            onChanged: (value) {
                              setState(() {
                                _value3 = value!;
                                // print('3');
                              });
                            });
                      }
                    ),
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
                        return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Center(
                                child: _imageOp4 != null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.file(
                                            _imageOp4!,
                                            height: 100,
                                          ),
                                        ],
                                      )
                                    : answerData['imageUrl'] != null
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.network(
                                                answerData['imageUrl'],
                                                height: 100,
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      FirebaseFirestore.instance
                                                          .collection('quizs')
                                                          .doc(widget.quizId)
                                                          .collection('questions')
                                                          .doc(widget.questionId)
                                                          .collection('answers')
                                                          .doc(widget.option4)
                                                          .update(
                                                              {'imageUrl': null});
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 30,
                                                  ))
                                            ],
                                          )
                                        : TextFormField(
                                            controller: option4Edit,
                                            minLines: 1,
                                            maxLines: 3,
                                            validator: ((val) => val!.isEmpty
                                                ? "กรอกคำตอบ"
                                                : null),
                                            // onChanged: (value) {
                                            //   setState(() {
                                            //     option1 = value;
                                            //   });
                                            // },
                                            decoration: InputDecoration(
                                                hintText: 'คำตอบที่ 4'),
                                          ),
                              ),
                            secondary: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                        .collection('quizs')
                                        .doc(widget.quizId)
                                        .collection('questions')
                                        .doc(widget.questionId)
                                        .collection('answers')
                                        .doc(widget.option4)
                                        .update({'answer': ''});
                                    imagePickeOption4();
                                }, icon: Icon(Icons.add_a_photo)),
                            value: _value4,
                            onChanged: (value) {
                              setState(() {
                                _value4 = value!;
                                // print(selected[3]);
                              });
                            });
                      }
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
                            EditQuestionCheckbox();
                            editAnswer();
                            Navigator.pop(context);
                          },
                          child: Text('บันทึกโจทย์')),
                    ],
                  ),
                   SizedBox(height: 50,)
                ],
              ),
            ),)
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