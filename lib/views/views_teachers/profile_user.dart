import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/models/userT.dart';
import 'package:my_project/views/signin.dart';
import 'package:path_provider/path_provider.dart';

class ProfileUser extends StatefulWidget {
  ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple,),
      backgroundColor: Colors.deepPurple,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 34),
          child: Center(
            child: Column(
              children: [
                Text(
                  "MyProfile",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  child: LayoutBuilder(builder: (context, constraints) {
                    double innerHeight = constraints.maxHeight;
                    double innerWidth = constraints.maxHeight;
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                        children: [
                                          SizedBox(
                                            height: 60,
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text("User Name", style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
                                                ],
                                              ),
                                              IconButton(onPressed: (){},
                                              icon: Icon(FontAwesomeIcons.pen,
                                                  color: Colors.blue,
                                                ),)
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text("Email : ", style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)
                                                ],
                                              ),
                                              Text("610107030033@gmail.com", style: TextStyle(color: Colors.black,fontSize: 20),)
                                            ],
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
                                radius: 80,
                                backgroundImage: AssetImage("assets/avatan.jpg"),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 110,
                          right: 110,
                          child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.yellow,
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add_a_photo))),
                        )
                      ],
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
