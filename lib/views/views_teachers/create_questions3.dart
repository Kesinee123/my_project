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

class CreateQuestion3 extends StatefulWidget {

const  CreateQuestion3({super.key});

  @override
  State<CreateQuestion3> createState() => _CreateQuestion3State();
}

class _CreateQuestion3State extends State<CreateQuestion3> {

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(backgroundColor: Colors.deepPurple, title: Text('Text'),),
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
                          Container(
                            width: 800,
                            height: 500,
                            color: Colors.white,
                            child: Column(children: [
                              SizedBox(height: 20,),
                              Text("คำตอบ",style: TextStyle(fontWeight: FontWeight.bold),),
                          SizedBox(height: 20,),
                          Container(
                            width: 800,
                            child: ListTile(
                              title: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'คำตอบ'
                                ),
                              ),
                              ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          
                         ElevatedButton(
                            style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                            onPressed: (){
                               Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AddQuestion()));
                            },
                            child: Text('บันทึกโจทย์'))
                            ]),
                          )
                         
                          
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }

}