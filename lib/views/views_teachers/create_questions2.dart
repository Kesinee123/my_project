import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_project/models/question.dart';
import 'package:my_project/models/userT.dart';
import 'package:my_project/views/views_teachers/add_questions.dart';

class CreateQuestion2 extends StatefulWidget {

const  CreateQuestion2({super.key});

  @override
  State<CreateQuestion2> createState() => _CreateQuestion2State();
}

class _CreateQuestion2State extends State<CreateQuestion2> {

  // _CreateQuestionState(this.quizId);
  bool _ch = false;
  bool _ch2 = false;
  bool _ch3 = false;
  bool _ch4 = false;

  final _formKey = GlobalKey<FormState>();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("error"),
              ),
              body: Center(child: Text("${snapshot.error}")),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(backgroundColor: Colors.deepPurple, title: Text('Checkbox'),),
              backgroundColor: Colors.white,
              body: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
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
                                        style: TextStyle(color: Colors.white),
                                        validator: ((val) => val!.isEmpty
                                            ? "Enter Question"
                                            : null),
                                        decoration:
                                            InputDecoration(hintText: "",),
                                            
                                        onSaved: ((val) {
                                          
                                        }),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 80, 200, 0),
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
                        SizedBox(height: 30,),
                        Text("เลือกได้มากกว่า 1 ข้อ !!",style: TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        Center(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: TextFormField(
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
                        Center(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: TextFormField(
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
                        Center(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: TextFormField(
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
                        Center(
                          child: CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: TextFormField(
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
                          height: 20,
                        ),
                        
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                          onPressed: (){
                               Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddQuestion()));
                          },
                          child: Text('บันทึกโจทย์'))
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
