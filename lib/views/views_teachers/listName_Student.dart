import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/ranking_Student.dart';

class ListName_Student extends StatefulWidget {
  const ListName_Student({super.key});

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
                gradient:
                    LinearGradient(colors: [Colors.deepPurple, Colors.purple]),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage()));
                            },
                            child: Text('END')),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.5,
                                color: Colors.orange,
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 8,
                                    spreadRadius: 3),
                              ],
                              borderRadius: BorderRadius.circular(40)),
                          padding: EdgeInsets.all(5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Name : ',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  FirebaseAuth.instance.currentUser!.displayName!,
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
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Teacher',
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
                      children: [
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

                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    padding: EdgeInsets.all(16),
                                    color: Colors.purple,
                                    child: Center(
                                        child: Text(
                                      '1',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [Text('Name_Student')],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    padding: EdgeInsets.all(16),
                                    color: Colors.purple,
                                    child: Center(
                                        child: Text(
                                      '2',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [Text('Name_Student')],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    padding: EdgeInsets.all(16),
                                    color: Colors.purple,
                                    child: Center(
                                        child: Text(
                                      '3',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [Text('Name_Student')],
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                    width: 50,
                                    height: 50,
                                    padding: EdgeInsets.all(16),
                                    color: Colors.purple,
                                    child: Center(
                                        child: Text(
                                      '4',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ))),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [Text('Name_Student')],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    // button
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Ranking_Student()));
                      },
                      child: Container(
                        height: 50,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
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
                        child: Center(
                          child: Text(
                            'START',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
