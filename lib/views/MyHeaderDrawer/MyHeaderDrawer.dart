import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/models/userT.dart';
import 'package:my_project/services/firebase_service.dart';
import 'package:my_project/views/views_teachers/profile_user.dart';
import 'package:my_project/views/signin.dart';
import 'package:provider/provider.dart';

class MyHeaderDrawer extends StatefulWidget {
  MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.deepPurple,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/avatan.jpg"),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "UserName",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "610107030033@gmail.com",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: (() => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileUser()))),
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("LogOut"),
              onTap: (() async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => SignIn())));
              }),
            ),
          ],
        ),
      ),
    );
  }
}
