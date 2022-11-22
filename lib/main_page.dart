import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:my_project/views/signin.dart';
import 'package:my_project/views/views_students/codePage.dart';
import 'package:my_project/views/views_teachers/homepage.dart';
import 'package:my_project/views/views_teachers/profile_user.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return StreamBuilder(
              stream: FirebaseFirestore.instance.collection("users").doc(snapshot.data!.uid).snapshots(),
              builder:(BuildContext context, AsyncSnapshot snapshot) {
                if(snapshot.hasData) {
                  final user = snapshot.data.data();
                  if (user['type'] == 'นักเรียน') {
                    return LetPage();
                  }else{
                    return HomePage();
                  }
                }return Material(child: Center(
                  child: CircularProgressIndicator(),
                ),);
              },);
            // return HomePage();
          }else{
            return SignIn();
          }
        }),
    );
  }
}