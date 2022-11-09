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
import 'package:my_project/views/views_teachers/homepage.dart';

class CreateQuestion extends StatefulWidget {
  const CreateQuestion({super.key});

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  final _formKey = GlobalKey<FormState>();

  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Radio'),
      ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                      child: Center(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "โจทย์คำถาม",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 18),
                              ),
                              TextFormField(
                                onChanged: (value) {},
                                style: TextStyle(color: Colors.white),
                                validator: ((val) =>
                                    val!.isEmpty ? "กรอกโจทย์คำถาม" : null),
                                decoration: InputDecoration(
                                  hintText: "",
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 80, 200, 0),
                                child: ElevatedButton.icon(
                                  onPressed: (() {}),
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
                    width: 800,
                    height: 500,
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
                  Container(
                    width: 800,
                    child: RadioListTile(
                      secondary: IconButton(
                          onPressed: () {}, icon: Icon(Icons.add_a_photo)),
                      value: 1,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                      title: TextFormField(
                        decoration: InputDecoration(hintText: 'คำตอบที่ 1'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 800,
                    child: RadioListTile(
                      secondary: IconButton(
                          onPressed: () {}, icon: Icon(Icons.add_a_photo)),
                      value: 2,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                      title: TextFormField(
                        decoration: InputDecoration(hintText: 'คำตอบที่ 2'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 800,
                    child: RadioListTile(
                      secondary: IconButton(
                          onPressed: () {}, icon: Icon(Icons.add_a_photo)),
                      value: 3,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                      title: TextFormField(
                        decoration: InputDecoration(hintText: 'คำตอบที่ 3'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 800,
                    child: RadioListTile(
                      secondary: IconButton(
                          onPressed: () {}, icon: Icon(Icons.add_a_photo)),
                      value: 4,
                      groupValue: _value,
                      onChanged: (value) {
                        setState(() {
                          _value = value!;
                        });
                      },
                      title: TextFormField(
                        decoration: InputDecoration(hintText: 'คำตอบที่ 4'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AddQuestion()));
                        },
                        child: Text('บันทึกโจทย์')),
                  )
                      ],
                    ) ,
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
