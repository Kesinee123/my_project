import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_project/views/signin.dart';

class ProfileSPage extends StatefulWidget {
  const ProfileSPage({Key? key}) : super(key: key);
  @override
  State<ProfileSPage> createState() => _ProfileSPageState();
}

class _ProfileSPageState extends State<ProfileSPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 151, 114, 253),
        // ),
        backgroundColor: Color.fromARGB(255, 151, 114, 253),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 34),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(onPressed: (){
                                    showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text("ออกจากระบบ"),
                                        content:
                                            Text("ต้องการออกจากระบบหรือไม่"),
                                        actions: [
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.cancel,
                                                color: Colors.red,
                                              )),
                                          IconButton(
                                              onPressed: () async {
                                                await FirebaseAuth.instance
                                                    .signOut()
                                                    .then((value) => Navigator
                                                            .of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SignIn(path: '',))));
                                              },
                                              icon: Icon(
                                                Icons.exit_to_app,
                                                color: Colors.green,
                                              )),
                                        ],
                                      );
                                    });
                            },
                            icon: Icon(Icons.exit_to_app, size: 30,))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "MyProfile",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 360,
                            // width: 500,
                            child:
                                LayoutBuilder(builder: (context, constraints) {
                              double innerHeight = constraints.maxHeight;
                              double innerWidth = constraints.maxHeight;
                              return Stack(fit: StackFit.expand, children: [
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.white,
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
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
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  FirebaseAuth
                                                      .instance
                                                      .currentUser!
                                                      .displayName!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
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
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                Text(
                                                  FirebaseAuth.instance
                                                      .currentUser!.email!,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
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
                                                          color: Colors.black,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )
                                                  ],
                                                ),
                                                const Expanded(
                                                  child: Text(
                                                    'นักเรียน',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
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
                                          backgroundImage: NetworkImage(
                                              FirebaseAuth.instance.currentUser!
                                                  .photoURL!,
                                              scale: 1.0)),
                                    ),
                                  ),
                                ),
                              ]);
                            }))
                      ],
                    )))));
  }
}
