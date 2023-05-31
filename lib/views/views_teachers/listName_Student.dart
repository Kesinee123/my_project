import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/rankingStudent.dart';

import '../../models/quiz.dart';

class ListName_Student extends StatefulWidget {
  const ListName_Student({super.key, required this.quizId});

  final String quizId;

  @override
  State<ListName_Student> createState() => _ListName_StudentState();
}

class _ListName_StudentState extends State<ListName_Student> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: const [Colors.deepPurple, Colors.purple]),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.exit_to_app,
                              size: 30,
                              color: Colors.white,
                            )),
                        // ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         backgroundColor: Colors.red),
                        //     onPressed: () {
                        //       Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (context) =>
                        //                   HomePage(path: '',)));
                        //     },
                        //     child: IconButton(onPressed: (){},
                        //     icon: Icon(Icons.exit_to_app))),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        // Container(
                        //   width: 50,
                        //   height: 50,
                        //   decoration: BoxDecoration(
                        //       border: Border.all(
                        //         width: 1.5,
                        //         color: Colors.white,
                        //       ),
                        //       boxShadow: [
                        //         BoxShadow(
                        //             color: Colors.black.withOpacity(.1),
                        //             blurRadius: 8,
                        //             spreadRadius: 3),
                        //       ],
                        //       borderRadius: BorderRadius.circular(40)),
                        //   padding: EdgeInsets.all(5),
                        //   child: CircleAvatar(
                        //     backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                        //   ),
                        // ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'ชื่อ - นามสกุล : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  FirebaseAuth
                                      .instance.currentUser!.displayName!,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'คุณครู',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(25),
              color: Colors.grey[300],
              child: Center(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'รายชื่อนักเรียน',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    // รายชื่อนักเรียน
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('quizs')
                                    .doc(widget.quizId)
                                    .collection('studentList')
                                    .snapshots(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    return ListView.builder(
                                        itemCount: snapshot.data!.docs.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final DocumentSnapshot
                                              documentSnapshot =
                                              snapshot.data!.docs[index];
                                          return Container(
                                              // color: Colors.amber,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 5),
                                              child: ListTile(
                                                  title: Text(
                                                    documentSnapshot['name'],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  leading: CircleAvatar(
                                                    child: Text('${index + 1}'),
                                                  )));
                                        });
                                  }
                                  return CircularProgressIndicator();
                                }))),

                    SizedBox(height: 30),
                    // button
                    InkWell(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection('quizs')
                            .doc(widget.quizId)
                            .update({'start': true,});
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RankingStudent(
                                      quizId: widget.quizId,
                                    )));
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.purple,
                                  spreadRadius: 1,
                                  // blurRadius: 5,
                                  offset: Offset(4, 4)),
                              BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 1,
                                  // blurRadius: 5,
                                  offset: Offset(-4, -4)),
                            ]),
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'เริ่มต้นการทำแบบทดสอบ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
