// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:my_project/models/quiz.dart';
// import 'package:my_project/views/views_teachers/create_questions.dart';

// import 'package:my_project/views/views_teachers/homepage.dart';

// class EditCreateQuiz extends StatefulWidget {
//   const EditCreateQuiz({super.key});

//   @override
//   State<EditCreateQuiz> createState() => _EditCreateQuizState();
// }

// class _EditCreateQuizState extends State<EditCreateQuiz> {
//   final _formkey = GlobalKey<FormState>();

//   final TextEditingController _quizTitleEdit = TextEditingController();
//   final TextEditingController _quizSubjectEdit = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//                 appBar: AppBar(
//                   centerTitle: true,
//                   title: Text("แก้ไขหน้าแบบทดสอบ"),
//                   backgroundColor: Colors.deepPurple,
//                 ),
//                 backgroundColor: Colors.deepPurple,
//                 body: Container(
//                   padding: EdgeInsets.all(30),
//                   child: Form(
//                     key: _formkey,
//                     child: SingleChildScrollView(
//                       child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Container(
//                               color: Colors.white,
//                               height: 550,
//                                 child: Container(
//                                   child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                     Center(
//                                       child: Padding(
//                                         padding: EdgeInsets.all(8.0),
//                                         child: ClipRRect(
//                                           borderRadius: BorderRadius.circular(30),
//                                           child: Container(
//                                             height: 150,
//                                             width: double.infinity,
//                                             child: Column(
//                                               children: [
//                                                 Expanded(
//                                                   child: Container(
//                                                     width: 250,
//                                                     decoration: BoxDecoration(
//                                                       borderRadius:
//                                                           BorderRadius.circular(20),
//                                                       border: Border.all(
//                                                           color:
//                                                               Colors.deepPurple),
//                                                     ),
//                                                     child: Center(
//                                                       child: Column(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                         children: [
//                                                           // Expanded(
//                                                           //   child: _image == null
//                                                           //       ? Center(
//                                                           //           child:
//                                                           //               Text("No image selected"))
//                                                           //       : Image.file(_image!),
//                                                           // ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     ElevatedButton(
//                                       style: ElevatedButton.styleFrom(primary: Colors.yellow),
//                                         onPressed: () {},
//                                         child: Text('เพิ่มรูปภาพ',style: TextStyle(color: Colors.black),)),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Container(
//                                       alignment: Alignment.centerLeft,
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 25),
//                                       child: Container(
//                                         child: Text(
//                                           "ชื่อแบบทดสอบ",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
                                    
//                                     Container(
//                                       alignment: Alignment.centerLeft,
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 25),
//                                       child: Container(
//                                         child: TextFormField(
                                          
                                         
//                                           // decoration: InputDecoration(hintText: "Quiz Title"),
                                          
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Container(
//                                       alignment: Alignment.centerLeft,
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 25),
//                                       child: Container(
//                                         child: Text(
//                                           "ชื่อวิชาของแบบทดสอบ",
//                                           style: TextStyle(
//                                               color: Colors.black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                     ),
//                                     Container(
//                               alignment: Alignment.centerLeft,
//                               margin: EdgeInsets.symmetric(horizontal: 25),
//                               child: Container(
//                                 child: TextFormField(
//                                   // decoration: InputDecoration(hintText: "Quiz Subject"),
                                  
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 ElevatedButton(
//                                       style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                       child: Text('ยกเลิก')),
                                
//                                 SizedBox(width: 100,),
//                                 ElevatedButton(
//                                     style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
//                                       onPressed: () {

//                                       },
//                                       child: Text('ตกลง')),
//                                       ]
//                                 ),
//                                       ]
//                                 )
//                             )
//                             )
//                               ],
//                       )
//                     )
//                   )
//                 )
    
//                             );
//   }
// }
                                  