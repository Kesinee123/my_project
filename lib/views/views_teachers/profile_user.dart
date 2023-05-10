import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_project/models/usermodel.dart';

import '../../config/responsive.dart';

class ProfileUser extends StatefulWidget {
  ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.deepPurple,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 34),
                                child: Center(
                                  child: Column(
                                    children: [
                                      const Text(
                                        "โปรไฟล์ของฉัน",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        height: 360,
                                        // width: 500,
                                        child: LayoutBuilder(
                                            builder: (context, constraints) {
                                          double innerHeight =
                                              constraints.maxHeight;
                                          double innerWidth =
                                              constraints.maxHeight;
                                          return Responsive(
                                            mobile: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Positioned(
                                                    bottom: 0,
                                                    left: 0,
                                                    right: 0,
                                                    child: Container(
                                                      width: 200,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30),
                                                        color: Colors.white,
                                                      ),
                                                      child: Container(
                                                        margin:
                                                            const EdgeInsets.symmetric(
                                                                horizontal: 20),
                                                        child: Column(
                                                          children: [
                                                            
                                                            const SizedBox(
                                                              height: 50,
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
                                                                  FirebaseAuth.instance.currentUser!.displayName! ,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                 SizedBox(
                                                                  width: 10,
                                                                ),
                                                              
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    const Text(
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
                                                                  FirebaseAuth.instance.currentUser!.email!,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    const Text(
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
                                                                const Expanded(
                                                                  child: Text(
                                                                    'คุณครู',
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
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                           
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
                                                          backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!, scale: 1.0)),
                                                    ),
                                                  ),
                                                ),
                                                
                                              ]
                                                ),
                                                destop: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                Positioned(
                                                    bottom: 0,
                                                    left: 400,
                                                    right: 400,
                                                    child: Container(
                                                      // width: 100,
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                30),
                                                        color: Colors.white,
                                                      ),
                                                      child: Container(
                                                        margin:
                                                            const EdgeInsets.symmetric(
                                                                horizontal: 20),
                                                        child: Column(
                                                          children: [
                                                            
                                                            const SizedBox(
                                                              height: 50,
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
                                                                  FirebaseAuth.instance.currentUser!.displayName! ,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                 SizedBox(
                                                                  width: 10,
                                                                ),
                                                              
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    const Text(
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
                                                                  FirebaseAuth.instance.currentUser!.email!,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20),
                                                                )
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    const Text(
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
                                                                const Expanded(
                                                                  child: Text(
                                                                    'คุณครู',
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
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                           
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
                                                          backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!, scale: 1.0)),
                                                    ),
                                                  ),
                                                ),
                                                
                                              ]
                                                ),
                                          );
                                            }
                                        )
                                      )
                                            ],
                                  )
                                )
                )
            )
        )
                                          );
                                        }
                            
         
                            }
                  
