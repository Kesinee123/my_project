import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_project/models/usermodel.dart';

class ProfileUser extends StatefulWidget {
  ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      firstNameController.text = documentSnapshot['firstName'];
      lastNameController.text = documentSnapshot['lastName'];
      
    }

    await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: firstNameController,
                    decoration: InputDecoration(labelText: 'ชื่อ'),
                  ),
                  TextField(
                    controller: lastNameController,
                    decoration: InputDecoration(labelText: 'นามสกุล'),
                  ),
                  
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final String firstName = firstNameController.text;
                      final String lastName = lastNameController.text;
                     

                      await FirebaseFirestore.instance
                          .collection("users")
                          .doc(documentSnapshot!.id)
                          .update(
                              {"firstName": firstName, "lastName": lastName});
                      firstNameController.text = '';
                      lastNameController.text = '';

                      Navigator.pop(context);
                    },
                    child: Text('Update'),
                  )
                ],
              ),
            ),
          );
        });
  }

  final currenUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
            child: SingleChildScrollView(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .where("uid", isEqualTo: currenUser.currentUser!.uid)
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  snapshot.data!.docs[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 34),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        "MyProfile",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 350,
                                        // width: 500,
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          double innerHeight =
                                              constraints.maxHeight;
                                          double innerWidth =
                                              constraints.maxHeight;
                                          return Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Positioned(
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      color: Colors.white,
                                                    ),
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: [
                                                              IconButton(
                                                                  onPressed: () => _update(
                                                                      documentSnapshot),
                                                                  icon: Icon(Icons.edit))
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            // mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "ชื่อ-นามสกุล : ",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Text(
                                                                documentSnapshot[
                                                                    "firstName"],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                      documentSnapshot[
                                                                          "lastName"],
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              20)),
                                                                ],
                                                              ),
                                                              // IconButton(onPressed: (){},
                                                              // icon: Icon(FontAwesomeIcons.pen,
                                                              //     color: Colors.blue,
                                                              //   ),)
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "อีเมล : ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ],
                                                              ),
                                                              Text(
                                                                documentSnapshot[
                                                                    "email"],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        20),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Row(
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Text(
                                                                    "สถานะ : ",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )
                                                                ],
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  documentSnapshot[
                                                                    "type"],
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20),
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          // Row(
                                                          //   children: [
                                                          //     Column(
                                                          //       children: [
                                                          //         Text(
                                                          //           "สาขาวิชา : ",
                                                          //           style: TextStyle(
                                                          //               color: Colors
                                                          //                   .black,
                                                          //               fontSize:
                                                          //                   20,
                                                          //               fontWeight:
                                                          //                   FontWeight.bold),
                                                          //         )
                                                          //       ],
                                                          //     ),
                                                          //     Expanded(
                                                          //       child: Text(
                                                          //         "คอมพิวเตอร์",
                                                          //         style: TextStyle(
                                                          //             color: Colors
                                                          //                 .black,
                                                          //             fontSize:
                                                          //                 20),
                                                          //         maxLines: 1,
                                                          //         overflow:
                                                          //             TextOverflow
                                                          //                 .ellipsis,
                                                          //       ),
                                                          //     )
                                                          //   ],
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                              Positioned(
                                                top: 0,
                                                left: 0,
                                                right: 0,
                                                child: Center(
                                                  child: Container(
                                                    child: CircleAvatar(
                                                        radius: 70,
                                                        backgroundImage: AssetImage(
                                                            'assets/avatan.jpg')),
                                                  ),
                                                ),
                                              ),
                                              // Positioned(
                                              //   top: 0,
                                              //   left: 150,
                                              //   right: 0,
                                              //   bottom: 10,
                                              //   child: Center(
                                              //     child: Container(
                                              //       decoration: BoxDecoration(
                                              //         shape: BoxShape.circle,
                                              //         color: Colors.yellow,
                                              //       ),
                                              //       child: IconButton(
                                              //         icon: Icon(Icons.add_a_photo), onPressed: () {  },)
                                              //     ),
                                              //   ),
                                              // ),
                                              
                                            ],
                                          );
                                        }),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }))));
  }
}
