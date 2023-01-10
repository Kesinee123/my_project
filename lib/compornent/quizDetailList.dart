import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/models/menu_item.dart';
import 'package:my_project/views/views_teachers/details.dart';
import 'package:my_project/views/views_teachers/editCreate_quizs.dart';

class QuizDetailList extends StatefulWidget {
  QuizDetailList({super.key});

  // final String quizId;

  @override
  State<QuizDetailList> createState() => _QuizDetailListState();
}

class _QuizDetailListState extends State<QuizDetailList> {
  List<String> popList = ["แก้ไข", "ลบ"];

  final TextEditingController quizTitleEdit = TextEditingController();
  final TextEditingController quizSubjectEdit = TextEditingController();

  Future<void> _deleteQuiz(id) async {
    await FirebaseFirestore.instance.collection("quizs").doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("quizs")
        .where('uid' , isEqualTo: FirebaseAuth.instance.currentUser!.uid )
        .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if(snapshot.data!.docs.length != 0) {

            }else{
              return noQuiz();
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.deepPurple),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsQuizs(
                                          quizId: documentSnapshot.id, 
                                        )));
                          },
                          child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              leading: CircleAvatar(
                                radius: 32,
                                backgroundImage: NetworkImage(documentSnapshot['imageUrl'])
                              ),
                              title: Text(documentSnapshot['quizTitle'], style: TextStyle(color: Colors.white),),
                              subtitle: Text(documentSnapshot['quizSubject'], style: TextStyle(color: Colors.white),),
                              trailing: PopupMenuButton(onSelected: (value) {
                                if (value == "ลบ") {
                                  showDialog(
                                      context: context,
                                      builder: (_) {
                                        return Dialog(
                                          child: Container(
                                              margin: EdgeInsets.all(20),
                                              height: 150,
                                              width: 300,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'ต้องการลบแบบทดสอบหรือไม่ ??',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                  // MouseRegion(
                                                  //   cursor: SystemMouseCursors.click,
                                                  //   child: 
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .grey),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child:
                                                                Text('ยกเลิก')),
                                                        SizedBox(
                                                          width: 50,
                                                        ),
                                                        ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red),
                                                            onPressed: () {
                                                              _deleteQuiz(
                                                                  documentSnapshot
                                                                      .id);
                                                              Navigator.pop(context);
                                                            },
                                                            child: Text('ลบ'))
                                                      ],
                                                    ),
                                                  // )
                                                ],
                                              )),
                                        );
                                      });
                                } else {
                                  quizTitleEdit.text = documentSnapshot['quizTitle'];
                                  quizSubjectEdit.text = documentSnapshot['quizSubject'];

                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          child: SingleChildScrollView(
                                              child: Container(
                                                  padding: EdgeInsets.all(30),
                                                  child: Form(
                                                      // key: _formkey,
                                                      child:
                                                          SingleChildScrollView(
                                                              child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'แก้ไขแบบทดสอบ',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Container(
                                                          color: Colors.white,
                                                          height: 500,
                                                          width: 500,
                                                          child: Container(
                                                              child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                Center(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              30),
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            150,
                                                                        width: double
                                                                            .infinity,
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            Expanded(
                                                                              child: Container(
                                                                                width: 200,
                                                                                decoration: BoxDecoration(
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                  border: Border.all(color: Colors.deepPurple),
                                                                                ),
                                                                                child: Center(
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      // Expanded(
                                                                                      //   child: _image == null
                                                                                      //       ? Center(
                                                                                      //           child:
                                                                                      //               Text("No image selected"))
                                                                                      //       : Image.file(_image!),
                                                                                      // ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                ElevatedButton(
                                                                    style: ElevatedButton.styleFrom(
                                                                        primary:
                                                                            Colors
                                                                                .yellow),
                                                                    onPressed:
                                                                        () {},
                                                                    child: Text(
                                                                      'เพิ่มรูปภาพ',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    )),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                      "ชื่อแบบทดสอบ",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        TextFormField(
                                                                      controller:
                                                                          quizTitleEdit,

                                                                      // decoration: InputDecoration(hintText: "Quiz Title"),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  child:
                                                                      Container(
                                                                    child: Text(
                                                                      "ชื่อวิชาของแบบทดสอบ",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  margin: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              10),
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        TextFormField(
                                                                      // decoration: InputDecoration(hintText: "Quiz Subject"),
                                                                      controller:
                                                                          quizSubjectEdit,
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              primary: Colors
                                                                                  .blueGrey),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('ยกเลิก')),
                                                                      SizedBox(
                                                                        width:
                                                                            100,
                                                                      ),
                                                                      ElevatedButton(
                                                                          style: ElevatedButton.styleFrom(
                                                                              primary: Colors
                                                                                  .deepPurple),
                                                                          onPressed:
                                                                              () async {
                                                                            // final TextEditingController
                                                                            //     quizTitleEdit =
                                                                            //     TextEditingController();
                                                                            // final TextEditingController
                                                                            //     quizSubjectEdit =
                                                                            //     TextEditingController();

                                                                            snapshot.data!.docs[index].reference.update({
                                                                              "quizTitle": quizTitleEdit.text,
                                                                              "quizSubject": quizSubjectEdit.text
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text('ตกลง')),
                                                                    ]),
                                                              ])))
                                                    ],
                                                  ))))),
                                        );
                                      });
                                }
                              }, itemBuilder: (context) {
                                return popList
                                    .map((e) =>
                                        PopupMenuItem(value: e, child: Text(e)))
                                    .toList();
                              })),
                        ),
                      ),
                    ],
                  );
                });
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          
        });
  }
   noQuiz() {
    return Container(
      margin: EdgeInsets.all(50),
      child: Center(
        child: Column(
          children: [
            Image.network('https://cdn-icons-png.flaticon.com/512/29/29302.png', height: 150,),
            Text('ไม่มีแบบทดสอบที่สร้าง', style: TextStyle(fontSize: 20),),
          ],
        )),
    );
  }
}

