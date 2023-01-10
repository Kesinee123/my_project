import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/models/usermodel.dart';
import 'package:my_project/views/views_teachers/add_questions.dart';
import 'package:my_project/views/views_teachers/details.dart';

class CreateQuestion2 extends StatefulWidget {

const  CreateQuestion2({super.key, required this.quizId});

final String quizId;

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

  bool _ch = false;
  bool _ch2 = false;
  bool _ch3 = false;
  bool _ch4 = false;

  // checkBox 
  // List<Map> availableChoice = [
  //   {'choice' : '1' , 'isChecked' : false},
  //   {'choice' : '2' , 'isChecked' : false},
  //   {'choice' : '3' , 'isChecked' : false},
  //   {'choice' : '4' , 'isChecked' : false},
  // ];
   
   Future CreateQuestionCheckbox(String question,)async {
    String date = DateFormat.yMMMMd().format(DateTime.now());
    String time = DateFormat.Hm().format(DateTime.now());

    DocumentReference questionCheckbox = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .add({
      'questions': question,
      // 'option1': option1,
      // 'option2': option2,
      // 'option3': option3,
      // 'option4': option4,
      'createdAt': '$date $time',
      'quizId': widget.quizId,
      'type_quiz': 'Checkbox',
      "correct_answer" : 'ตอบได้มากกว่า 1 ข้อ'
    });
    await questionCheckbox.update({
      "questionId": questionCheckbox.id,
    });
    DocumentReference questionAnwer1 = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionCheckbox.id)
        .collection('answers')
        .add({
      'answer': option1,
      'identifier': '1',
      "questionId": questionCheckbox.id,
    });
    DocumentReference questionAnwer2 = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionCheckbox.id)
        .collection('answers')
        .add({
      'answer': option2,
      'identifier': '2',
      "questionId": questionCheckbox.id,
    });
    DocumentReference questionAnwer3 = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionCheckbox.id)
        .collection('answers')
        .add({
      'answer': option3,
      'identifier': '3',
      "questionId": questionCheckbox.id,
    });
    DocumentReference questionAnwer4 = await FirebaseFirestore
        .instance
        .collection('quizs')
        .doc(widget.quizId)
        .collection('questions')
        .doc(questionCheckbox.id)
        .collection('answers')
        .add({
      'answer': option4,
      'identifier': '4',
      "questionId": questionCheckbox.id,
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
              // appBar: AppBar(backgroundColor: Colors.deepPurple, title: Text(''),),
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 24.0),
                                child: Center(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("โจทย์คำถาม",style: TextStyle(color: Colors.white,fontSize: 18),),
                                        TextFormField(
                                          minLines: 1,
                                          maxLines: 5,
                                          keyboardType: TextInputType.multiline,
                                          style: TextStyle(color: Colors.white),
                                          validator: ((val) => val!.isEmpty
                                              ? "กรอกโจทย์คำถาม"
                                              : null),
                                          decoration:
                                              InputDecoration(hintText: "",),
                                              
                                         onChanged: (value) {
                                            setState(() {
                                              question = value;
                                            });
                                          },
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 80, 150, 0),
                                          child: ElevatedButton.icon(
                                            onPressed: (() {}),
                                            icon: Icon(Icons.add_a_photo,color: Colors.black,),
                                            label: Text("เพิ่มรูปภาพ", style: TextStyle(color: Colors.black),),
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
                            height: 550,
                            color: Colors.white,
                            child: Column(children: [
                              SizedBox(height: 20,),
                              Text("เลือกได้มากกว่า 1 ข้อ !!",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Container(
                            width: 800,
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: TextFormField(
                                 validator: ((val) => val!.isEmpty
                                              ? "กรอกคำตอบ"
                                              : null),
                                onChanged: (value) {
                                  setState(() {
                                    option1 = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'คำตอบที่ 1'
                                ),
                              ),
                              secondary: IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo)),
                              value: _ch,
                              onChanged: (value){
                                setState(() {
                                  _ch = value!;
                                });
                              }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 800,
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: TextFormField(
                                 validator: ((val) => val!.isEmpty
                                              ? "กรอกคำตอบ"
                                              : null),
                                onChanged: (value) {
                                  setState(() {
                                    option2 = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'คำตอบที่ 2'
                                ),
                              ),
                              secondary: IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo)),
                              value: _ch2,
                              onChanged: (value){
                                setState(() {
                                  _ch2 = value!;
                                });
                              }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 800,
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: TextFormField(
                                 validator: ((val) => val!.isEmpty
                                              ? "กรอกคำตอบ"
                                              : null),
                                onChanged: (value) {
                                  setState(() {
                                    option3 = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'คำตอบที่ 3'
                                ),
                              ),
                              secondary: IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo)),
                              value: _ch3,
                              onChanged: (value){
                                setState(() {
                                  _ch3 = value!;
                                });
                              }),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 800,
                            child: CheckboxListTile(
                              controlAffinity: ListTileControlAffinity.leading,
                              title: TextFormField(
                                 validator: ((val) => val!.isEmpty
                                              ? "กรอกคำตอบ"
                                              : null),
                                onChanged: (value) {
                                  setState(() {
                                    option4 = value;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'คำตอบที่ 4'
                                ),
                              ),
                              secondary: IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo)),
                              value: _ch4,
                              onChanged: (value){
                                setState(() {
                                  _ch4 = value!;
                                });
                              }),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey
                              ),  
                              onPressed: (){
                                Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsQuizs(quizId: widget.quizId,)));
                              },
                              child: Text('ยกเลิก')),
                              SizedBox(width: 50,),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    CreateQuestionCheckbox(question,);
                              showSnackbar(context, Colors.green, "สร้างโจทย์คำถามสำเร็จ");
                              Navigator.push(context,MaterialPageRoute(builder: (context) => DetailsQuizs(quizId: widget.quizId,)));
                                  }
                                },
                                child: Text('บันทึกโจทย์')),
                            ],
                          )
                            ]),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
void showSnackbar(context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message, style: TextStyle(fontSize: 14),),
    backgroundColor: color,
    duration: Duration(seconds: 5),
    ));
  }

}
