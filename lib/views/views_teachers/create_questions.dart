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
import 'package:my_project/service/database_service.dart';
import 'package:my_project/views/views_teachers/details.dart';
import 'package:my_project/views/views_teachers/homepage.dart';

class CreateQuestion extends StatefulWidget {
  const CreateQuestion({
    super.key,
    required this.quizId,
  });
  final String quizId;

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

  Future createQuestionRadio(String question,)async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    final _imageUrlQs = await uploadImage(_imageQs!);
    DocumentReference questionRadio = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .add({
      'questions': question,
      'imageUrl' : _imageUrlQs ? null : null ,
      // 'option1': option1,
      // 'option2': option2,
      // 'option3': option3,
      // 'option4': option4,
      'createdAt': '$date $time',
      'quizId': widget.quizId,
      'type_quiz': 'Radio',
      "correct_answer" : correct_answer,
    });
    await questionRadio.update({
      "questionId": questionRadio.id,
    });

    DocumentReference questionAnwer1 = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionRadio.id)
        .collection('answers')
        .add({
      'answer': option1,
      'identifier': '1',
      "questionId": questionRadio.id,
    });
    DocumentReference questionAnwer2 = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionRadio.id)
        .collection('answers')
        .add({
      'answer': option2,
      'identifier': '2',
      "questionId": questionRadio.id,
    });
    DocumentReference questionAnwer3 = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionRadio.id)
        .collection('answers')
        .add({
      'answer': option3,
      'identifier': '3',
      "questionId": questionRadio.id,
    });
    DocumentReference questionAnwer4 = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionRadio.id)
        .collection('answers')
        .add({
      'answer': option4,
      'identifier': '4',
      "questionId": questionRadio.id,
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
    Reference reference =
        FirebaseStorage.instance.ref().child('question').child('question$imgId');
    await reference.putFile(_imageQs);
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
                              "??????????????????????????????",
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
                                  val!.isEmpty ? "??????????????????????????????????????????" : null),
                              decoration: InputDecoration(
                                hintText: "",
                              ),
                            ),
                            SizedBox(height: 20,),
                            // Center(
                            //   child: _imageQs == null ? null : Image.file(_imageQs!)
                            // ),
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
                                  "?????????????????????????????????",
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
                  "???????????????????????? 1 ????????????????????????????????? !!",
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
                          validator: ((val) =>
                              val!.isEmpty ? "???????????????????????????" : null),
                          onChanged: (value) {
                            setState(() {
                              option1 = value;
                            });
                          },
                          decoration: InputDecoration(hintText: '???????????????????????? 1'),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
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
                      validator: ((val) => val!.isEmpty ? "???????????????????????????" : null),
                      onChanged: (value) {
                        setState(() {
                          option2 = value;
                        });
                      },
                      decoration: InputDecoration(hintText: '???????????????????????? 2'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RadioListTile(
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
                      validator: ((val) => val!.isEmpty ? "???????????????????????????" : null),
                      onChanged: (value) {
                        setState(() {
                          option3 = value;
                        });
                      },
                      decoration: InputDecoration(hintText: '???????????????????????? 3'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: RadioListTile(
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
                      validator: ((val) => val!.isEmpty ? "???????????????????????????" : null),
                      onChanged: (value) {
                        setState(() {
                          option4 = value;
                        });
                      },
                      decoration: InputDecoration(hintText: '???????????????????????? 4'),
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
                                      )));
                        },
                        child: Text('??????????????????')),
                    SizedBox(
                      width: 50,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if(correct_answer == 0){
                              //  showSnackbar(
                              //   context, Colors.red, "??????????????????????????????????????????????????????????????????");
                              normalDialog(context, '????????????????????????????????????????????????????????????????????????');
                              return;
                            }else if (question == null){
                              showSnackbar(
                                context, Colors.red, "????????????????????????????????????????????????????????????????????????!!");
                            }
                            try{
                               createQuestionRadio(question,);
                               showSnackbar(
                                context, Colors.green, "???????????????????????????????????????????????????????????????");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsQuizs(
                                          quizId: widget.quizId,
                                        )));
                            }catch (e){
                              showSnackbar(context, Colors.red, e.toString() );
                            }
                          }
                        },
                        child: Text('?????????????????????????????????')),
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
          child: Text('????????????', style: TextStyle(fontSize: 16, color: Colors.red),),)
        ],
      )
    ],
  ));
}
