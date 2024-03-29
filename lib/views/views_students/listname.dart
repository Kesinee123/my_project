import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/rankingStudent.dart';

class ListName extends StatefulWidget {
  const ListName({super.key, required this.quizId});

  final String quizId;

  @override
  State<ListName> createState() => _ListNameState();
}

class _ListNameState extends State<ListName> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            // backgroundColor: Colors.purple,
            body: Container(
                height: 1000,
                color: Colors.grey[300],
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(colors:[ Colors.deepPurple , Colors.purple])
                // ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.exit_to_app))),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: 500,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(255, 151, 114, 253),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'ลำดับ',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'ชื่อ-นามสกุล',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'คะแนน',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('quizs')
                              .doc(widget.quizId)
                              .collection('studentList')
                              .orderBy('score', descending: true)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final DocumentSnapshot documentSnapshot =
                                        snapshot.data!.docs[index];
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  '${index + 1}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const Icon(
                                                  Icons.arrow_drop_up,
                                                  color: Colors.black,
                                                )
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                               CircleAvatar(
                                                backgroundImage: NetworkImage(documentSnapshot['imageUrl'])
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                documentSnapshot['name'],
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20, top: 5),
                                            child: Text(
                                              documentSnapshot['score'],
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }

                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }))
                ]))));
  }
}
