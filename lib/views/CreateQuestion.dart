import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/views/AddQuestion.dart';
import 'package:my_project/views/AddQuiz.dart';
import 'package:my_project/views/CreateQuiz.dart';

class CreateQuestion extends StatefulWidget {
  const CreateQuestion({super.key});

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  final _formKey = GlobalKey<FormState>();
  // Question question = Question(
  //     question: 'question',
  //     option1: 'option1',
  //     option2: 'option2',
  //     option3: 'option3',
  //     option4: 'option4');

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  // final CollectionReference _quizCollection = FirebaseFirestore.instance.collection("Quizs");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.purple),
      backgroundColor: Color.fromARGB(255, 252, 220, 254),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          children: [
                            TextFormField(
                              decoration:
                                  InputDecoration(hintText: "โจทย์คำถาม"),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 80, 200, 0),
                              child: ElevatedButton.icon(
                                onPressed: (() {}),
                                icon: Icon(Icons.add_a_photo),
                                label: Text("Add Phohto"),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurple),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "คำตอบที่ 1",
                    fillColor: Colors.yellow,
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: (() {}), icon: Icon(Icons.add_a_photo))
                      ],
                    ),
                  ),
                  onSaved: (val) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "คำตอบที่ 2",
                    fillColor: Colors.orange,
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: (() {}), icon: Icon(Icons.add_a_photo))
                      ],
                    ),
                  ),
                  onSaved: (val) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "คำตอบที่ 3",
                    fillColor: Colors.blueAccent,
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: (() {}), icon: Icon(Icons.add_a_photo))
                      ],
                    ),
                  ),
                  onSaved: (val) {},
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "คำตอบที่ 4",
                    fillColor: Colors.lightBlue,
                    suffixIcon: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: (() {}), icon: Icon(Icons.add_a_photo))
                      ],
                    ),
                  ),
                  onSaved: (val) {},
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: (() {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => AddQuestion() ,) );
                  }),
                   child: Text("Save"),
                   style: ElevatedButton.styleFrom(
                                    primary: Colors.purple),
                   ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
